
# Module `Node.Process`

```ocaml
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
```reasonml
type t =
  Js.t({. argv: array(string)
    , arch: string
    , abort: Js.OO.Meth.arity0(unit)
    , chdir: Js.OO.Meth.arity1((string => unit))
    , cwd: Js.OO.Meth.arity0(string)
    , disconnect: Js.OO.Meth.arity0(unit)
    , platform: string
    , env: Js.Dict.t(string)});
```
```ocaml
val process : t
```
```reasonml
let process: t;
```
```ocaml
val argv : string array
```
```reasonml
let argv: array(string);
```
```ocaml
val exit : int -> 'a
```
```reasonml
let exit: int => 'a;
```
```ocaml
val cwd : unit -> string
```
```reasonml
let cwd: unit => string;
```
```ocaml
val uptime : t -> unit -> float
```
```reasonml
let uptime: t => unit => float;
```
The process.uptime() method returns the number of seconds the current Node.js process has been running.)

```ocaml
val putEnvVar : string -> string -> unit
```
```reasonml
let putEnvVar: string => string => unit;
```
```ocaml
val deleteEnvVar : string -> unit
```
```reasonml
let deleteEnvVar: string => unit;
```