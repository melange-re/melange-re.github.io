open Js_of_ocaml
open Ocamlformat_lib

let format source conf =
  match
    Translation_unit.parse_and_format Syntax.Use_file conf ~input_name:"_none_"
      ~source
  with
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
          ( "format",
            inject
            @@ Js.wrap_meth_callback (fun _ code ->
                   format (Js.to_string code) conf) );
        |])
  in
  Js.Unsafe.set Js.Unsafe.global "ocamlformat" fields
