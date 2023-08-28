let ocaml_code_blocks doc =
  let open Cmarkit in
  let module String_set = Set.Make (String) in
  let block _m acc = function
    | Block.Code_block (cb, _) ->
        let acc =
          match Block.Code_block.info_string cb with
          | Some ("ocaml", _) -> cb :: acc
          | Some _ | None -> acc
        in
        Folder.ret acc
    | _ -> Folder.default (* let the folder thread the fold *)
  in
  let folder = Folder.make ~block () in
  Folder.fold_doc folder [] doc

let process_cmark : strict:bool -> string -> unit =
 fun ~strict md ->
  let doc = Cmarkit.Doc.of_string ~layout:true ~strict md in
  let code_blocks = ocaml_code_blocks doc in
  List.iter
    (fun cb ->
      print_endline "  $ cat > input.ml <<\\EOF";

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
  >  (preprocess (pps melange.ppx)))
  > EOF
|};
  process_cmark ~strict:false input
