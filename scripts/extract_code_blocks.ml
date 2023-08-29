module Prelude = struct
  let prefix = "<!--#prelude#"

  let remove_prefix str =
    String.sub str (String.length prefix)
      (String.length str - String.length prefix)

  let remove_suffix str =
    let comment_ending = "-->" in
    String.sub str 0 (String.length str - String.length comment_ending)
end

let ocaml_code_blocks doc =
  let open Cmarkit in
  let module String_set = Set.Make (String) in
  let last = ref None in
  let block _m acc = function
    | Block.Code_block (cb, _) ->
        let acc =
          match Block.Code_block.info_string cb with
          | Some ("ocaml", _) -> (
              match !last with
              | Some (Block.Html_block ((first_line :: _ as hb), _))
                when String.starts_with ~prefix:Prelude.prefix
                       (Block_line.to_string first_line) ->
                  (cb, Some hb) :: acc
              | _ -> (cb, None) :: acc)
          | Some _ | None -> acc
        in
        last := None;
        Folder.ret acc
    | block ->
        last := Some block;
        Folder.default (* let the folder thread the fold *)
  in
  let folder = Folder.make ~block () in
  Folder.fold_doc folder [] doc

let process_cmark : strict:bool -> string -> unit =
 fun ~strict md ->
  let doc = Cmarkit.Doc.of_string ~layout:true ~strict md in
  let code_blocks = ocaml_code_blocks doc in
  List.iter
    (fun (cb, prelude) ->
      print_endline "  $ cat > input.ml <<\\EOF";

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
  print_endline
    {|Test code snippets from the markdown files

  $ cat > dune-project <<EOF
  > (lang dune 3.8)
  > (using melange 0.1)
  > EOF

  $ cat > dune <<EOF
  > (melange.emit
  >  (emit_stdlib false)
  >  (target output)
  >  (libraries melange.node)
  >  (preprocess (pps melange.ppx)))
  > EOF
|};
  process_cmark ~strict:false input
