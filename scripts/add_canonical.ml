open Printf
open Unix
open Str

let to_v2_paths input = input

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

let replace_in_file ~orig_path file_path search_str =
  let ic = open_in file_path in
  let lines = ref [] in
  try
    while true do
      lines := input_line ic :: !lines
    done
  with End_of_file ->
    close_in ic;
    let add_write_permission = 0o200 in
    let orig_permissions = (Unix.stat file_path).st_perm in
    let new_permissions = orig_permissions lor add_write_permission in
    Unix.chmod file_path new_permissions;
    let relative_file_path =
      let path = relative_path orig_path file_path in
      to_v2_paths path
    in
    let canonical_link =
      Printf.sprintf
        "<link rel=\"canonical\" href=\"https://melange.re/v2.0.0/api/%s\" \
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
    close_out oc

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
