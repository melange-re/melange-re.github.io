# Module `Node.Child_process`
Node Child Process API
```
type option
```
```
val option : ?cwd:string -> ?encoding:string -> unit -> option
```
```
val execSync : string -> option -> string
```
```
type spawnResult
```
```
val spawnSync : string -> spawnResult
```
```
val readAs : 
  spawnResult ->
  < pid : int
    ; status : int Js.null
    ; signal : string Js.null
    ; stdout : Node.string_buffer Js.null
    ; stderr : Node.string_buffer Js.null >
    Js.t
```