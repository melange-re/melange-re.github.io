type code_block_info = OCaml | Reason

module Prelude = struct
  let prefix = "<!--#prelude#"

  let remove_prefix str =
    String.sub str (String.length prefix)
      (String.length str - String.length prefix)

  let remove_suffix str =
    let comment_ending = "-->" in
    String.sub str 0 (String.length str - String.length comment_ending)
end

let code_blocks ~code_block_info doc =
  let open Cmarkit in
  let module String_set = Set.Make (String) in
  let last = ref None in
  let block _m acc = function
    | Block.Code_block (cb, _) ->
        let acc =
          match (Block.Code_block.info_string cb, code_block_info) with
          | Some ("ocaml", _), OCaml | Some ("reasonml", _), Reason -> (
              match !last with
              | Some (Block.Html_block ((first_line :: _ as hb), _))
                when String.starts_with ~prefix:Prelude.prefix
                       (Block_line.to_string first_line) ->
                  (cb, Some hb) :: acc
              | _ -> (cb, None) :: acc)
          | Some _, _ | None, _ -> acc
        in
        last := None;
        Folder.ret acc
    | block ->
        last := Some block;
        Folder.default (* let the folder thread the fold *)
  in
  let folder = Folder.make ~block () in
  Folder.fold_doc folder [] doc

let process_cmark :
    code_block_info:code_block_info -> strict:bool -> string -> unit =
 fun ~code_block_info ~strict md ->
  let doc = Cmarkit.Doc.of_string ~layout:true ~strict md in
  let code_blocks = code_blocks ~code_block_info doc in
  List.iter
    (fun (cb, prelude) ->
      let suffix =
        match code_block_info with OCaml -> "ml" | Reason -> "re"
      in
      print_endline (Printf.sprintf "  $ cat > input.%s <<\\EOF" suffix);

      let () =
        let open Prelude in
        match prelude with
        | Some prelude_lines ->
            List.iteri
              (fun index line ->
                let raw_line = Cmarkit.Block_line.to_string line in
                let remove_prefix str =
                  if index == 0 then remove_prefix str else str
                in
                let remove_suffix str =
                  if index == List.length prelude_lines - 1 then
                    remove_suffix str
                  else str
                in
                print_endline ("  > " ^ remove_suffix (remove_prefix raw_line)))
              prelude_lines
        | None -> ()
      in

      List.iter
        (fun line -> print_endline ("  > " ^ Cmarkit.Block_line.to_string line))
        (Cmarkit.Block.Code_block.code cb);

      print_endline {|  > EOF

  $ dune build @melange
|})
    code_blocks

let maybe_read_line () = try Some (read_line ()) with End_of_file -> None

let rec loop acc =
  match maybe_read_line () with
  | Some line -> loop (line :: acc)
  | None -> List.rev acc

let input = String.concat "\n" (loop [])

let () =
  let open Printf in
  let num_args = Array.length Sys.argv in
  if num_args <> 2 && num_args <> 3 && num_args <> 4 then
    eprintf
      "Usage: %s code_block_info_string (\"ocaml\" or \"reason\") \
       <optional_lib> <optional_ppx>\n"
      Sys.argv.(0)
  else
    let code_block_info_string = Sys.argv.(1) in
    let optional_lib = if num_args >= 3 then Some Sys.argv.(2) else None in
    let optional_ppx = if num_args >= 4 then Some Sys.argv.(3) else None in
    let code_block_info =
      match code_block_info_string with
      | "ocaml" -> OCaml
      | "reason" -> Reason
      | _ ->
          eprintf "Usage: %s code_block_info_string (\"ocaml\" or \"reason\")\n"
            Sys.argv.(0);
          failwith "Invalid code_block_info_string"
    in
    print_endline
      (Printf.sprintf
         {|This test file is automatically generated from its corresponding markdown
file. To update the tests, run `dune build @extract-code-blocks`.

  $ cat > dune-project <<EOF
  > (lang dune 3.8)
  > (using melange 0.1)
  > EOF

  $ cat > dune <<EOF
  > (melange.emit
  >  (emit_stdlib false)
  >  (target output)
  >  (libraries melange.dom melange.node%s)
  >  (preprocess (pps melange.ppx%s)))
  > EOF
|}
         (match optional_lib with None -> "" | Some lib -> " " ^ lib)
         (match optional_ppx with None -> "" | Some ppx -> " " ^ ppx));
    process_cmark ~code_block_info ~strict:false input
