
# Module `Node.Child_process`

Node Child Process API

```ocaml
type option
```
```reasonml
type option;
```
```ocaml
val option : ?cwd:string -> ?encoding:string -> unit -> option
```
```reasonml
let option: ?cwd:string => ?encoding:string => unit => option;
```
```ocaml
val execSync : string -> option -> string
```
```reasonml
let execSync: string => option => string;
```
```ocaml
type spawnResult
```
```reasonml
type spawnResult;
```
```ocaml
val spawnSync : string -> spawnResult
```
```reasonml
let spawnSync: string => spawnResult;
```
```ocaml
val readAs : 
  spawnResult ->
  < pid : int
    ; status : int Js.null
    ; signal : string Js.null
    ; stdout : Node.string_buffer Js.null
    ; stderr : Node.string_buffer Js.null >
    Js.t
```
```reasonml
let readAs: 
  spawnResult =>
  Js.t({. pid: int
    , status: Js.null(int)
    , signal: Js.null(string)
    , stdout: Js.null(Node.string_buffer)
    , stderr: Js.null(Node.string_buffer)});
```