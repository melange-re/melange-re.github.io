open Printf
open Unix
open Str

let contains_substring ~sub str =
  let regex = regexp_string sub in
  try
    ignore (search_forward regex str 0);
    true
  with Not_found -> false

let to_v2_paths input =
  let rec transform_helper acc = function
    | [] -> List.rev acc
    | 'm' :: 'e' :: 'l' :: 'a' :: 'n' :: 'g' :: 'e' :: '/' :: melange_rest -> (
        match melange_rest with
        | [] -> List.rev acc
        | 'J' :: 's' :: '_' :: next :: rest
          when Char.lowercase_ascii next == next ->
            transform_helper
              (Char.uppercase_ascii next :: '/' :: 's' :: 'J' :: '/' :: 'e'
             :: 'g' :: 'n' :: 'a' :: 'l' :: 'e' :: 'm' :: acc)
              rest
        | 'N' :: 'o' :: 'd' :: 'e' :: '_' :: next :: rest
          when Char.lowercase_ascii next == next ->
            transform_helper
              (Char.uppercase_ascii next :: '/' :: 'e' :: 'd' :: 'o' :: 'N'
             :: '/' :: 'e' :: 'g' :: 'n' :: 'a' :: 'l' :: 'e' :: 'm' :: acc)
              rest
        | 'D' :: 'o' :: 'm' :: '_' :: next :: rest
          when Char.lowercase_ascii next == next ->
            transform_helper
              (Char.uppercase_ascii next :: '/' :: 'm' :: 'o' :: 'D' :: '/'
             :: 'e' :: 'g' :: 'n' :: 'a' :: 'l' :: 'e' :: 'm' :: acc)
              rest
        | 'B' :: 'e' :: 'l' :: 't' :: '_' :: next :: rest
          when Char.uppercase_ascii next == next ->
            transform_helper
              (next :: '/' :: 't' :: 'l' :: 'e' :: 'B' :: '/' :: 'e' :: 'g'
             :: 'n' :: 'a' :: 'l' :: 'e' :: 'm' :: acc)
              rest
        | c :: rest ->
            transform_helper
              (c :: '/' :: 'e' :: 'g' :: 'n' :: 'a' :: 'l' :: 'e' :: 'm' :: acc)
              rest)
    | c :: rest -> transform_helper (c :: acc) rest
  in
  let input_chars = List.of_seq (String.to_seq input) in
  let transformed_chars = transform_helper [] input_chars in
  String.of_seq (List.to_seq transformed_chars)
  |> global_replace (regexp_string "MapDict") "Map/Dict"
  |> global_replace (regexp_string "MapInt") "Map/Int"
  |> global_replace (regexp_string "MapString") "Map/String"
  |> global_replace (regexp_string "SetDict") "Set/Dict"
  |> global_replace (regexp_string "SetInt") "Set/Int"
  |> global_replace (regexp_string "SetString") "Set/String"
  |> global_replace (regexp_string "SortArrayInt") "SortArray/Int"
  |> global_replace (regexp_string "SortArrayString") "SortArray/String"
  |> global_replace (regexp_string "Js/Weakset") "Js/WeakSet"
  |> global_replace (regexp_string "Js/Weakmap") "Js/WeakMap"
  |> global_replace (regexp_string "Js/Typed_array2") "Js/TypedArray2"
  |> global_replace (regexp_string "Js/Parser") "Js_parser"

let relative_path base_path target_path =
  let base_parts = split (regexp_string Filename.dir_sep) base_path in
  let target_parts = split (regexp_string Filename.dir_sep) target_path in

  let rec common_prefix base_parts target_parts =
    match (base_parts, target_parts) with
    | b :: b_rest, t :: t_rest when b = t -> b :: common_prefix b_rest t_rest
    | _ -> []
  in

  let rec drop n lst = if n <= 0 then lst else drop (n - 1) (List.tl lst) in

  let common = common_prefix base_parts target_parts in
  let parent_dirs =
    List.init (List.length base_parts - List.length common) (fun _ -> "..")
  in
  let remaining = drop (List.length common) target_parts in
  String.concat Filename.dir_sep (parent_dirs @ remaining)

let can_ignore file_path =
  contains_substring ~sub:"melange/Caml/" file_path
  || contains_substring ~sub:"melange/Caml_" file_path
  || contains_substring ~sub:"melange/Js_OO" file_path
  || contains_substring ~sub:"melange/Js_cast" file_path
  || contains_substring ~sub:"melange/Parsing0" file_path
  || contains_substring ~sub:"melange/Belt_internal" file_path
  || contains_substring ~sub:"melange/Ast_signature" file_path
  || contains_substring ~sub:"melange/Melange_ppx_lib" file_path
  || contains_substring ~sub:"melange/Melange_ppxlib_ast" file_path
  || contains_substring ~sub:"melange/Node_fs/Node" file_path

let replace_in_file ~orig_path file_path search_str =
  let ic = open_in file_path in
  let lines = ref [] in
  try
    while true do
      lines := input_line ic :: !lines
    done
  with End_of_file -> (
    close_in ic;
    let add_write_permission = 0o200 in
    let orig_permissions = (Unix.stat file_path).st_perm in
    let new_permissions = orig_permissions lor add_write_permission in
    Unix.chmod file_path new_permissions;
    match can_ignore file_path with
    | true -> ()
    | false ->
        let relative_file_path =
          let path = relative_path orig_path file_path in
          to_v2_paths path
        in
        (* Dom, Js, Node, Belt *)
        let canonical_link =
          Printf.sprintf
            "<link rel=\"canonical\" href=\"https://melange.re/v5.0.0/api/%s\" \
             /></head>"
            (String.escaped relative_file_path)
        in
        let oc = open_out file_path in
        List.iter
          (fun line ->
            let modified_line =
              global_replace (regexp_string search_str) canonical_link line
            in
            fprintf oc "%s\n" modified_line)
          (List.rev !lines);
        close_out oc)

let rec process_files ~orig_path folder_path =
  let dir = opendir folder_path in
  try
    while true do
      let entry = readdir dir in
      if entry <> "." && entry <> ".." then
        let entry_path = Filename.concat folder_path entry in
        if Sys.is_directory entry_path then process_files ~orig_path entry_path
        else if Filename.extension entry = ".html" then
          replace_in_file ~orig_path entry_path "</head>"
    done
  with End_of_file -> closedir dir

let () =
  if Array.length Sys.argv <> 2 then
    eprintf "Usage: %s folder_path\n" Sys.argv.(0)
  else
    let folder_path = Sys.argv.(1) in
    if Sys.file_exists folder_path && Sys.is_directory folder_path then
      process_files ~orig_path:folder_path folder_path
    else eprintf "Invalid folder path\n"
