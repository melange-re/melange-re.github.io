open Js_of_ocaml
open Ocamlformat_lib
module Parser = Ocamlformat_parser_standard
module Location = Ocamlformat_ocaml_common.Location

module To_ppxlib =
  Ppxlib_ast.Convert (Ppxlib_ast__Versions.OCaml_505) (Ppxlib_ast.Selected_ast)

(* ocamlformat-mlx 0.29.0.2 uses the OCaml 5.5 AST, with two additional
   constructors for editor holes. Reject those before migrating the AST. *)
external to_ast_505 :
  Parser.Parsetree.structure -> Astlib.Ast_505.Parsetree.structure = "%identity"

let prepare_ast =
  let open Parser in
  let mapper =
    {
      Ast_mapper.default_mapper with
      expr =
        (fun self expr ->
          let expr = Ast_mapper.default_mapper.expr self expr in
          match expr.pexp_desc with
          | Pexp_hole -> Location.raise_errorf ~loc:expr.pexp_loc "Syntax error"
          | Pexp_apply
              ( fn,
                (( Nolabel,
                   {
                     pexp_desc = Pexp_construct ({ txt = Lident "()"; _ }, None);
                     _;
                   } ) as unit)
                :: args )
            when List.exists
                   (fun (attr : Parsetree.attribute) ->
                     attr.attr_name.txt = "JSX")
                   expr.pexp_attributes ->
              (* Reason's JSX printer expects the synthetic unit argument last. *)
              { expr with pexp_desc = Pexp_apply (fn, args @ [ unit ]) }
          | _ -> expr);
      module_expr =
        (fun self expr ->
          match expr.pmod_desc with
          | Pmod_hole -> Location.raise_errorf ~loc:expr.pmod_loc "Syntax error"
          | _ -> Ast_mapper.default_mapper.module_expr self expr);
    }
  in
  mapper.structure mapper

let parse_mlx source =
  let lexbuf = Lexing.from_string source in
  Location.init_info lexbuf "playground.mlx";
  let ast =
    Parser.Parse.implementation ~ocaml_version:(Some (5, 5)) lexbuf
    |> prepare_ast |> to_ast_505 |> To_ppxlib.copy_structure
  in
  (* Docstrings already occur as attributes in the AST. *)
  let docstrings = Hashtbl.create 8 in
  let iter =
    object
      inherit Ppxlib.Ast_traverse.iter as super

      method! attribute attr =
        (match (attr.attr_name.txt, attr.attr_payload) with
        | ("ocaml.doc" | "ocaml.text"), PStr [ { pstr_loc; _ } ] ->
            Hashtbl.replace docstrings pstr_loc ()
        | _ -> ());
        super#attribute attr
    end
  in
  iter#structure ast;
  let comments =
    Parser.Lexer.comments ()
    |> List.filter_map (fun (text, (loc : Location.t)) ->
        let location : Ppxlib.Location.t =
          {
            loc_start = loc.loc_start;
            loc_end = loc.loc_end;
            loc_ghost = loc.loc_ghost;
          }
        in
        if Hashtbl.mem docstrings location then None
        else Some (Reason.Reason_comment.make ~location Regular text))
  in
  (ast, comments)

let parse_ocaml source =
  Reason.Reason_toolchain.ML.implementation_with_comments
    (Lexing.from_string source)

let parse source =
  try parse_mlx source
  with mlx_error -> ( try parse_ocaml source with _ -> raise mlx_error)

(* In valid OCaml, [x<y] is a comparison; MLX lexes [<y] as a tag.
   Separate native LESS tokens before retrying formatting, preserving comments
   and strings. Compilation continues to use the original source locations. *)
let disambiguate_ocaml source =
  let lexbuf = Lexing.from_string source in
  let buffer = Buffer.create (String.length source) in
  Ocaml_common.Lexer.init ();
  let rec loop offset =
    match Ocaml_common.Lexer.token lexbuf with
    | LESS ->
        let stop = lexbuf.lex_curr_p.pos_cnum in
        Buffer.add_substring buffer source offset (stop - offset);
        Buffer.add_char buffer ' ';
        loop stop
    | EOF ->
        Buffer.add_substring buffer source offset (String.length source - offset);
        Buffer.contents buffer
    | _ -> loop offset
  in
  loop 0

let parse_for_js source =
  let open Js.Unsafe in
  try obj [| ("ast", inject (parse source)) |]
  with exn ->
    let message, loc =
      match Location.error_of_exn exn with
      | Some (`Ok error) ->
          (Format.asprintf "%a" Location.print_report error, error.main.loc)
      | _ -> (Printexc.to_string exn, Location.none)
    in
    let start = loc.loc_start and stop = loc.loc_end in
    obj
      [|
        ("js_warning_error_msg", inject (Js.string message));
        ("text", inject (Js.string message));
        ("type", inject (Js.string "error"));
        ("row", inject (max 0 (start.pos_lnum - 1)));
        ("column", inject (max 0 (start.pos_cnum - start.pos_bol)));
        ("endRow", inject (max 0 (stop.pos_lnum - 1)));
        ("endColumn", inject (max 0 (stop.pos_cnum - stop.pos_bol)));
      |]

let format source conf =
  let run source =
    Translation_unit.parse_and_format Syntax.Use_file conf ~input_name:"_none_"
      ~source
  in
  let result =
    match run source with
    | Ok _ as result -> result
    | Error _ as error -> (
        try
          ignore (parse_ocaml source);
          run (disambiguate_ocaml source)
        with _ -> error)
  in
  match result with
  | Ok formatted -> Ok formatted
  | Error e ->
      let error_buf = Buffer.create 100 in
      let fmt = Format.formatter_of_buffer error_buf in
      Translation_unit.Error.print fmt e;
      Format.pp_print_flush fmt ();
      let error_msg = Buffer.contents error_buf in
      Error error_msg

let () =
  let conf = Conf.default in
  let fields =
    Js.Unsafe.(
      obj
        [|
          ( "parse",
            inject
            @@ Js.wrap_meth_callback (fun _ code ->
                parse_for_js (Js.to_string code)) );
          ( "format",
            inject
            @@ Js.wrap_meth_callback (fun _ code ->
                format (Js.to_string code) conf) );
        |])
  in
  Js.Unsafe.set Js.Unsafe.global "ocamlformat" fields
