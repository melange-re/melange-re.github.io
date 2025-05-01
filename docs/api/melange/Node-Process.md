# Module `Node.Process`
```
type t =
  < argv : string array
    ; arch : string
    ; abort : unit Js.OO.Meth.arity0
    ; chdir : (string -> unit) Js.OO.Meth.arity1
    ; cwd : string Js.OO.Meth.arity0
    ; disconnect : unit Js.OO.Meth.arity0
    ; platform : string
    ; env : string Js.Dict.t >
    Js.t
```
```
val process : t
```
```
val argv : string array
```
```
val exit : int -> 'a
```
```
val cwd : unit -> string
```
```
val uptime : t -> unit -> float
```
The process.uptime() method returns the number of seconds the current Node.js process has been running.)
```
val putEnvVar : string -> string -> unit
```
```
val deleteEnvVar : string -> unit
```