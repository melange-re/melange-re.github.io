let run cmd =
  Printf.printf "Running: %s\n%!" cmd;
  let code = Sys.command cmd in
  if code <> 0 then
    failwith (Printf.sprintf "Command failed with exit code %d: %s" code cmd)

let read_file path =
  let ic = open_in path in
  let n = in_channel_length ic in
  let s = really_input_string ic n in
  close_in ic;
  s

let write_file path content =
  let oc = open_out path in
  output_string oc content;
  close_out oc

(* Adapted from process_md.ml *)

let parse_with f code = code |> Lexing.from_string |> f

let print_with f structure_and_comments =
  f Format.str_formatter structure_and_comments;
  Format.flush_str_formatter ()

let parse_ml =
  parse_with Reason.Reason_toolchain.ML.implementation_with_comments

let print_re =
  print_with Reason.Reason_toolchain.RE.print_implementation_with_comments

let designature s =
  let dedent s =
    let n = String.length s in
    if n <= 2 then "" else String.sub s 2 (n - 2)
  in
  let lines = String.split_on_char '\n' s in
  let len = List.length lines in
  lines
  |> List.filteri (fun i _ -> i <> 0 && i <> len - 2)
  |> List.map dedent |> String.concat "\n"

let to_re str =
  let is_type_signature, str =
    if String.starts_with str ~prefix:"val " then
      (true, "module type _FAKE_  = sig " ^ str ^ " end")
    else (false, str)
  in
  let parsed_ast = parse_ml str in
  let output = print_re parsed_ast in
  if is_type_signature then designature output else output

let remove_last_newline s =
  let n = String.length s in
  if n > 0 && s.[n - 1] = '\n' then String.sub s 0 (n - 1) else s

let html_escape s =
  let buf = Buffer.create (String.length s) in
  String.iter
    (function
      | '&' -> Buffer.add_string buf "&amp;"
      | '<' -> Buffer.add_string buf "&lt;"
      | '>' -> Buffer.add_string buf "&gt;"
      | '"' -> Buffer.add_string buf "&quot;"
      | c -> Buffer.add_char buf c)
    s;
  Buffer.contents buf

let looks_like_type_expr code =
  let len = String.length code in
  let rec check i =
    if i >= len then false
    else if i + 1 < len && code.[i] = '-' && code.[i + 1] = '>' then true
    else if code.[i] = '*' then true
    else if
      i + 1 < len
      && code.[i] = '\''
      && code.[i + 1] >= 'a'
      && code.[i + 1] <= 'z'
    then true
    else check (i + 1)
  in
  check 0

let try_parse_as_type code =
  try
    let ml = "val _x : " ^ code in
    let re = remove_last_newline (to_re ml) in
    let prefix = "let _x: " in
    if String.starts_with ~prefix re then
      let rest =
        String.sub re (String.length prefix)
          (String.length re - String.length prefix)
      in
      let rest = String.trim rest in
      let rest =
        if String.ends_with ~suffix:";" rest then
          String.sub rest 0 (String.length rest - 1)
        else rest
      in
      Some (String.trim rest)
    else None
  with _ -> None

let rewrite_prefix_to_postfix code =
  match String.index_opt code ' ' with
  | Some pos when pos > 0 ->
      let path = String.sub code 0 pos in
      let arg =
        String.trim (String.sub code (pos + 1) (String.length code - pos - 1))
      in
      if String.contains path '.' && String.length arg > 0 then
        Some (arg ^ " " ^ path)
      else None
  | _ -> None

let try_convert_inline code =
  let trim = String.trim code in
  if String.length trim = 0 || not (looks_like_type_expr trim) then None
  else
    let result =
      match try_parse_as_type trim with
      | Some _ as r -> r
      | None -> (
          match rewrite_prefix_to_postfix trim with
          | Some rewritten -> try_parse_as_type rewritten
          | None -> None)
    in
    match result with Some r when r <> trim -> Some r | _ -> None

type segment = Plain of string | Backtick of string

let parse_segments text =
  let len = String.length text in
  let segments = ref [] in
  let buf = Buffer.create 64 in
  let i = ref 0 in
  while !i < len do
    if !i + 1 < len && text.[!i] = '\\' && text.[!i + 1] = '`' then begin
      Buffer.add_char buf '\\';
      Buffer.add_char buf '`';
      i := !i + 2
    end
    else if text.[!i] = '`' then begin
      if Buffer.length buf > 0 then begin
        segments := Plain (Buffer.contents buf) :: !segments;
        Buffer.clear buf
      end;
      incr i;
      while !i < len && text.[!i] <> '`' do
        Buffer.add_char buf text.[!i];
        incr i
      done;
      if !i < len then incr i;
      segments := Backtick (Buffer.contents buf) :: !segments;
      Buffer.clear buf
    end
    else begin
      Buffer.add_char buf text.[!i];
      incr i
    end
  done;
  if Buffer.length buf > 0 then
    segments := Plain (Buffer.contents buf) :: !segments;
  List.rev !segments

let render_segments segments =
  let buf = Buffer.create 256 in
  List.iter
    (function
      | Plain s -> Buffer.add_string buf s
      | Backtick s -> (
          match try_convert_inline s with
          | Some re_s ->
              Buffer.add_string buf
                (Printf.sprintf
                   "<code class=\"text-ocaml\">%s</code><code \
                    class=\"text-reasonml\">%s</code>"
                   (html_escape s) (html_escape re_s))
          | None ->
              Buffer.add_char buf '`';
              Buffer.add_string buf s;
              Buffer.add_char buf '`'))
    segments;
  Buffer.contents buf

let convert_inline_code_in_line line =
  let segments = parse_segments line in
  if List.for_all (function Plain _ -> true | Backtick _ -> false) segments
  then line
  else render_segments segments

let convert_inline_code_in_text lines =
  List.map convert_inline_code_in_line lines

(* Markdown block parsing *)

type block =
  | Text of string list
  | Code of { lang : string option; lines : string list }

let is_opening_fence line =
  String.length line >= 3 && line.[0] = '`' && line.[1] = '`' && line.[2] = '`'

let is_closing_fence line = String.trim line = "```"

let parse_fence_lang line =
  let rest = String.trim (String.sub line 3 (String.length line - 3)) in
  if rest = "" then None else Some rest

let parse_blocks content =
  let lines = String.split_on_char '\n' content in
  let blocks = ref [] in
  let acc = ref [] in
  let in_code = ref false in
  let lang = ref None in
  let flush_text () =
    match List.rev !acc with
    | [] -> ()
    | lines -> blocks := Text lines :: !blocks
  in
  let flush_code () =
    blocks := Code { lang = !lang; lines = List.rev !acc } :: !blocks;
    lang := None
  in
  List.iter
    (fun line ->
      if !in_code then begin
        if is_closing_fence line then begin
          flush_code ();
          acc := [];
          in_code := false
        end
        else acc := line :: !acc
      end
      else begin
        if is_opening_fence line then begin
          flush_text ();
          acc := [];
          lang := parse_fence_lang line;
          in_code := true
        end
        else acc := line :: !acc
      end)
    lines;
  if !in_code then flush_code () else flush_text ();
  List.rev !blocks

let render_blocks blocks =
  let buf = Buffer.create 4096 in
  let first_block = ref true in
  List.iter
    (fun block ->
      if not !first_block then Buffer.add_char buf '\n';
      first_block := false;
      match block with
      | Text lines ->
          let first_line = ref true in
          List.iter
            (fun line ->
              if not !first_line then Buffer.add_char buf '\n';
              first_line := false;
              Buffer.add_string buf line)
            lines
      | Code { lang; lines } ->
          Buffer.add_string buf "```";
          (match lang with Some l -> Buffer.add_string buf l | None -> ());
          List.iter
            (fun line ->
              Buffer.add_char buf '\n';
              Buffer.add_string buf line)
            lines;
          Buffer.add_char buf '\n';
          Buffer.add_string buf "```")
    blocks;
  Buffer.contents buf

let merge_blocks ~filename ml_blocks re_blocks =
  let rec go ml re =
    match (ml, re) with
    | [], [] -> []
    | Text ml_lines :: ml_rest, Text _ :: re_rest ->
        Text (convert_inline_code_in_text ml_lines) :: go ml_rest re_rest
    | Code ml_code :: ml_rest, Code re_code :: re_rest ->
        let ml_content = String.concat "\n" ml_code.lines in
        let re_content = String.concat "\n" re_code.lines in
        if ml_content = re_content then
          match ml_code.lang with
          | Some "ocaml" -> (
              try
                let re_str = remove_last_newline (to_re ml_content) in
                let re_lines = String.split_on_char '\n' re_str in
                Code { lang = Some "ocaml"; lines = ml_code.lines }
                :: Code { lang = Some "reasonml"; lines = re_lines }
                :: go ml_rest re_rest
              with _ -> Code ml_code :: go ml_rest re_rest)
          | _ -> Code ml_code :: go ml_rest re_rest
        else
          Code { lang = Some "ocaml"; lines = ml_code.lines }
          :: Code { lang = Some "reasonml"; lines = re_code.lines }
          :: go ml_rest re_rest
    | (Text _ :: _ | Code _ :: _), (Text _ :: _ | Code _ :: _) ->
        Printf.eprintf
          "Warning: block type mismatch in %s, falling back to ML\n%!" filename;
        ml_blocks
    | rest, [] -> rest
    | [], rest -> rest
  in
  go ml_blocks re_blocks

let should_keep filename =
  let start prefix = String.starts_with ~prefix filename in
  (start "Js" || start "Belt" || start "Dom" || start "Node" || start "Stdlib"
 || filename = "index.md")
  && not (start "Js_parser")

let src_dir = "melange/_build/default/_doc/_markdown/melange"
let output_dir = "docs/api"

let build_docs syntax =
  run
    (Printf.sprintf
       "ODOC_SYNTAX=%s opam exec -- dune build @doc-markdown --root ./melange"
       syntax)

let read_docs () =
  let tbl = Hashtbl.create 256 in
  Array.iter
    (fun f ->
      if Filename.check_suffix f ".md" then
        Hashtbl.replace tbl f (read_file (Filename.concat src_dir f)))
    (Sys.readdir src_dir);
  tbl

let () =
  Printf.printf "Building ML docs...\n%!";
  build_docs "ml";
  let ml_docs = read_docs () in

  Printf.printf "Building RE docs...\n%!";
  build_docs "re";
  let re_docs = read_docs () in

  ignore (Sys.command ("rm -rf " ^ output_dir));
  ignore (Sys.command ("mkdir -p " ^ output_dir));

  let filenames =
    Hashtbl.fold (fun k _ acc -> k :: acc) ml_docs []
    |> List.sort String.compare
  in
  let count = ref 0 in
  List.iter
    (fun filename ->
      if should_keep filename then begin
        let ml_content = Hashtbl.find ml_docs filename in
        let merged_content =
          match Hashtbl.find_opt re_docs filename with
          | Some re_content ->
              let ml_blocks = parse_blocks ml_content in
              let re_blocks = parse_blocks re_content in
              render_blocks (merge_blocks ~filename ml_blocks re_blocks)
          | None ->
              Printf.eprintf "Warning: %s not found in RE docs\n%!" filename;
              ml_content
        in
        let frontmatter = "---\neditLink: false\n---\n\n" in
        write_file
          (Filename.concat output_dir filename)
          (frontmatter ^ merged_content);
        incr count
      end)
    filenames;

  Printf.printf "Merged %d files into %s\n%!" !count output_dir
