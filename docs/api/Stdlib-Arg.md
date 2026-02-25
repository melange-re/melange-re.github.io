
# Module `Stdlib.Arg`

Parsing of command line arguments.

This module provides a general mechanism for extracting options and arguments from the command line to the program. For example:

```ocaml
     let usage_msg = "append [-verbose] <file1> [<file2>] ... -o <output>"
     let verbose = ref false
     let input_files = ref []
     let output_file = ref ""

     let anon_fun filename =
       input_files := filename::!input_files

     let speclist =
       [("-verbose", Arg.Set verbose, "Output debug information");
        ("-o", Arg.Set_string output_file, "Set output file name")]

     let () =
       Arg.parse speclist anon_fun usage_msg;
       (* Main functionality here *)
```
```reasonml
let usage_msg = "append [-verbose] <file1> [<file2>] ... -o <output>";
let verbose = ref(false);
let input_files = ref([]);
let output_file = ref("");

let anon_fun = filename => input_files := [filename, ...input_files^];

let speclist = [
  ("-verbose", Arg.Set(verbose), "Output debug information"),
  ("-o", Arg.Set_string(output_file), "Set output file name"),
];

let () = Arg.parse(speclist, anon_fun, usage_msg);
/* Main functionality here */
```
Syntax of command lines: A keyword is a character string starting with a `-`. An option is a keyword alone or followed by an argument. The types of keywords are: `Unit`, `Bool`, `Set`, `Clear`, `String`, `Set_string`, `Int`, `Set_int`, `Float`, `Set_float`, `Tuple`, `Symbol`, `Rest`, `Rest_all` and `Expand`.

`Unit`, `Set` and `Clear` keywords take no argument.

A `Rest` or `Rest_all` keyword takes the remainder of the command line as arguments. (More explanations below.)

Every other keyword takes the following word on the command line as argument. For compatibility with GNU getopt\_long, `keyword=arg` is also allowed. Arguments not preceded by a keyword are called anonymous arguments.

Examples (`cmd` is assumed to be the command name):

- `cmd -flag           `(a unit option)
- `cmd -int 1          `(an int option with argument `1`)
- `cmd -string foobar  `(a string option with argument `"foobar"`)
- `cmd -float 12.34    `(a float option with argument `12.34`)
- `cmd a b c           `(three anonymous arguments: `"a"`, `"b"`, and `"c"`)
- `cmd a b -- c d      `(two anonymous arguments and a rest option with two arguments)
`Rest` takes a function that is called repeatedly for each remaining command line argument. `Rest_all` takes a function that is called once, with the list of all remaining arguments.

Note that if no arguments follow a `Rest` keyword then the function is not called at all whereas the function for a `Rest_all` keyword is called with an empty list.

alert unsynchronized\_access The Arg module relies on a mutable global state, parsing functions should only be called from a single domain.
```
type spec = 
```
```ocaml
| Unit of unit -> unit
```
```reasonml
| Unit(unit => unit)
```
Call the function with unit argument

```ocaml
| Bool of bool -> unit
```
```reasonml
| Bool(bool => unit)
```
Call the function with a bool argument

```ocaml
| Set of bool ref
```
```reasonml
| Set(ref(bool))
```
Set the reference to true

```ocaml
| Clear of bool ref
```
```reasonml
| Clear(ref(bool))
```
Set the reference to false

```ocaml
| String of string -> unit
```
```reasonml
| String(string => unit)
```
Call the function with a string argument

```ocaml
| Set_string of string ref
```
```reasonml
| Set_string(ref(string))
```
Set the reference to the string argument

```ocaml
| Int of int -> unit
```
```reasonml
| Int(int => unit)
```
Call the function with an int argument

```ocaml
| Set_int of int ref
```
```reasonml
| Set_int(ref(int))
```
Set the reference to the int argument

```ocaml
| Float of float -> unit
```
```reasonml
| Float(float => unit)
```
Call the function with a float argument

```ocaml
| Set_float of float ref
```
```reasonml
| Set_float(ref(float))
```
Set the reference to the float argument

```ocaml
| Tuple of spec list
```
```reasonml
| Tuple(list(spec))
```
Take several arguments according to the spec list

```ocaml
| Symbol of string list * string -> unit
```
```reasonml
| Symbol(list(string), string => unit)
```
Take one of the symbols as argument and call the function with the symbol

```ocaml
| Rest of string -> unit
```
```reasonml
| Rest(string => unit)
```
Stop interpreting keywords and call the function with each remaining argument

```ocaml
| Rest_all of string list -> unit
```
```reasonml
| Rest_all(list(string) => unit)
```
Stop interpreting keywords and call the function with all remaining arguments

```ocaml
| Expand of string -> string array
```
```reasonml
| Expand(string => array(string))
```
If the remaining arguments to process are of the form `["-foo"; "arg"] @ rest` where "foo" is registered as `Expand f`, then the arguments `f "arg" @ rest` are processed. Only allowed in `parse_and_expand_argv_dynamic`.

```ocaml

```
```reasonml
;
```
The concrete type describing the behavior associated with a keyword.

```ocaml
type key = string
```
```reasonml
type key = string;
```
```ocaml
type doc = string
```
```reasonml
type doc = string;
```
```ocaml
type usage_msg = string
```
```reasonml
type usage_msg = string;
```
```ocaml
type anon_fun = string -> unit
```
```reasonml
type anon_fun = string => unit;
```
```ocaml
val parse : (key * spec * doc) list -> anon_fun -> usage_msg -> unit
```
```reasonml
let parse: list((key, spec, doc)) => anon_fun => usage_msg => unit;
```
`Arg.parse speclist anon_fun usage_msg` parses the command line. `speclist` is a list of triples `(key, spec, doc)`. `key` is the option keyword, it must start with a `'-'` character. `spec` gives the option type and the function to call when this option is found on the command line. `doc` is a one-line description of this option. `anon_fun` is called on anonymous arguments. The functions in `spec` and `anon_fun` are called in the same order as their arguments appear on the command line.

If an error occurs, `Arg.parse` exits the program, after printing to standard error an error message as follows:

- The reason for the error: unknown option, invalid or missing argument, etc.
- `usage_msg`
- The list of options, each followed by the corresponding `doc` string. Beware: options that have an empty `doc` string will not be included in the list.
For the user to be able to specify anonymous arguments starting with a `-`, include for example `("-", String anon_fun, doc)` in `speclist`.

By default, `parse` recognizes two unit options, `-help` and `--help`, which will print to standard output `usage_msg` and the list of options, and exit the program. You can override this behaviour by specifying your own `-help` and `--help` options in `speclist`.

```ocaml
val parse_dynamic : 
  (key * spec * doc) list ref ->
  anon_fun ->
  usage_msg ->
  unit
```
```reasonml
let parse_dynamic: 
  ref(list((key, spec, doc))) =>
  anon_fun =>
  usage_msg =>
  unit;
```
Same as [`Arg.parse`](./#val-parse), except that the `speclist` argument is a reference and may be updated during the parsing. A typical use for this feature is to parse command lines of the form:

- command subcommand `options` where the list of options depends on the value of the subcommand argument.
since 4\.01
```ocaml
val parse_argv : 
  ?current:int ref ->
  string array ->
  (key * spec * doc) list ->
  anon_fun ->
  usage_msg ->
  unit
```
```reasonml
let parse_argv: 
  ?current:ref(int) =>
  array(string) =>
  list((key, spec, doc)) =>
  anon_fun =>
  usage_msg =>
  unit;
```
`Arg.parse_argv ~current args speclist anon_fun usage_msg` parses the array `args` as if it were the command line. It uses and updates the value of `~current` (if given), or [`Arg.current`](./#val-current). You must set it before calling `parse_argv`. The initial value of `current` is the index of the program name (argument 0\) in the array. If an error occurs, `Arg.parse_argv` raises [`Arg.Bad`](./#exception-Bad) with the error message as argument. If option `-help` or `--help` is given, `Arg.parse_argv` raises [`Arg.Help`](./#exception-Help) with the help message as argument.

```ocaml
val parse_argv_dynamic : 
  ?current:int ref ->
  string array ->
  (key * spec * doc) list ref ->
  anon_fun ->
  string ->
  unit
```
```reasonml
let parse_argv_dynamic: 
  ?current:ref(int) =>
  array(string) =>
  ref(list((key, spec, doc))) =>
  anon_fun =>
  string =>
  unit;
```
Same as [`Arg.parse_argv`](./#val-parse_argv), except that the `speclist` argument is a reference and may be updated during the parsing. See [`Arg.parse_dynamic`](./#val-parse_dynamic).

since 4\.01
```ocaml
val parse_and_expand_argv_dynamic : 
  int ref ->
  string array ref ->
  (key * spec * doc) list ref ->
  anon_fun ->
  string ->
  unit
```
```reasonml
let parse_and_expand_argv_dynamic: 
  ref(int) =>
  ref(array(string)) =>
  ref(list((key, spec, doc))) =>
  anon_fun =>
  string =>
  unit;
```
Same as [`Arg.parse_argv_dynamic`](./#val-parse_argv_dynamic), except that the `argv` argument is a reference and may be updated during the parsing of `Expand` arguments. See [`Arg.parse_argv_dynamic`](./#val-parse_argv_dynamic).

since 4\.05
```ocaml
val parse_expand : (key * spec * doc) list -> anon_fun -> usage_msg -> unit
```
```reasonml
let parse_expand: list((key, spec, doc)) => anon_fun => usage_msg => unit;
```
Same as [`Arg.parse`](./#val-parse), except that the `Expand` arguments are allowed and the [`current`](./#val-current) reference is not updated.

since 4\.05
```ocaml
exception Help of string
```
```reasonml
exception Help(string);
```
Raised by `Arg.parse_argv` when the user asks for help.

```ocaml
exception Bad of string
```
```reasonml
exception Bad(string);
```
Functions in `spec` or `anon_fun` can raise `Arg.Bad` with an error message to reject invalid arguments. `Arg.Bad` is also raised by [`Arg.parse_argv`](./#val-parse_argv) in case of an error.

```ocaml
val usage : (key * spec * doc) list -> usage_msg -> unit
```
```reasonml
let usage: list((key, spec, doc)) => usage_msg => unit;
```
`Arg.usage speclist usage_msg` prints to standard error an error message that includes the list of valid options. This is the same message that [`Arg.parse`](./#val-parse) prints in case of error. `speclist` and `usage_msg` are the same as for [`Arg.parse`](./#val-parse).

```ocaml
val usage_string : (key * spec * doc) list -> usage_msg -> string
```
```reasonml
let usage_string: list((key, spec, doc)) => usage_msg => string;
```
Returns the message that would have been printed by [`Arg.usage`](./#val-usage), if provided with the same parameters.

```ocaml
val align : ?limit:int -> (key * spec * doc) list -> (key * spec * doc) list
```
```reasonml
let align: ?limit:int => list((key, spec, doc)) => list((key, spec, doc));
```
Align the documentation strings by inserting spaces at the first alignment separator (tab or, if tab is not found, space), according to the length of the keyword. Use a alignment separator as the first character in a doc string if you want to align the whole string. The doc strings corresponding to `Symbol` arguments are aligned on the next line.

parameter limit options with keyword and message longer than limit will not be used to compute the alignment.
```ocaml
val current : int ref
```
```reasonml
let current: ref(int);
```
Position (in [`Sys.argv`](./Stdlib-Sys.md#val-argv)) of the argument being processed. You can change this value, e.g. to force [`Arg.parse`](./#val-parse) to skip some arguments. [`Arg.parse`](./#val-parse) uses the initial value of [`Arg.current`](./#val-current) as the index of argument 0 (the program name) and starts parsing arguments at the next element.

```ocaml
val read_arg : string -> string array
```
```reasonml
let read_arg: string => array(string);
```
`Arg.read_arg file` reads newline-terminated command line arguments from file `file`.

since 4\.05
```ocaml
val read_arg0 : string -> string array
```
```reasonml
let read_arg0: string => array(string);
```
Identical to [`Arg.read_arg`](./#val-read_arg) but assumes null character terminated command line arguments.

since 4\.05
```ocaml
val write_arg : string -> string array -> unit
```
```reasonml
let write_arg: string => array(string) => unit;
```
`Arg.write_arg file args` writes the arguments `args` newline-terminated into the file `file`. If any of the arguments in `args` contains a newline, use [`Arg.write_arg0`](./#val-write_arg0) instead.

since 4\.05
```ocaml
val write_arg0 : string -> string array -> unit
```
```reasonml
let write_arg0: string => array(string) => unit;
```
Identical to [`Arg.write_arg`](./#val-write_arg) but uses the null character for terminator instead of newline.

since 4\.05