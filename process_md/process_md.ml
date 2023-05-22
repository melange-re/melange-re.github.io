let parse_with f code = code |> Lexing.from_string |> f

let print_with f structureAndComments =
  f Format.str_formatter structureAndComments;
  Format.flush_str_formatter ()

let parse_ml = parse_with Reason_toolchain.ML.implementation_with_comments
let print_re = print_with Reason_toolchain.RE.print_implementation_with_comments

let to_re str =
  try
    let parsed_ast = parse_ml str in
    print_re parsed_ast
  with _ ->
    failwith ("Failed to convert OCaml snippet to Reason syntax: " ^ str)

let remove_last_endline s =
  let n = String.length s in
  if n > 0 && s.[n - 1] = '\n' then String.sub s 0 (n - 1) else s

let insert_reason_blocks doc =
  let open Cmarkit in
  let reason_info = ("reasonml", Meta.none) in
  let block _m = function
    | Block.Code_block (cb, meta) as original -> (
        match Block.Code_block.info_string cb with
        | Some ("ocaml", _) ->
            let layout = Block.Code_block.layout cb in
            let ocaml_code = Block.Code_block.code cb in
            let ocaml_code_str =
              String.concat "\n" (List.map Block_line.to_string ocaml_code)
            in
            let reason_code_str = remove_last_endline (to_re ocaml_code_str) in
            let reason_code = Block_line.list_of_string reason_code_str in
            let cb =
              Block.Code_block.make ~layout ~info_string:reason_info reason_code
            in
            Mapper.ret
              (Block.Blocks ([ original; Block.Code_block (cb, meta) ], meta))
        | _ -> Mapper.default)
    | _ -> Mapper.default
  in
  let mapper = Mapper.make ~block () in
  Mapper.map_doc mapper doc

let cmark_to_commonmark : strict:bool -> string -> string =
 fun ~strict md ->
  let doc = Cmarkit.Doc.of_string ~layout:true ~strict md in
  let processed = insert_reason_blocks doc in
  Cmarkit_commonmark.of_doc processed

let maybe_read_line () = try Some (read_line ()) with End_of_file -> None

let rec loop acc =
  match maybe_read_line () with
  | Some line -> loop (line :: acc)
  | None -> List.rev acc

let input = String.concat "\n" (loop [])
let () = print_endline (cmark_to_commonmark ~strict:true input)
