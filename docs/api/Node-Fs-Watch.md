
# Module `Fs.Watch`

```ocaml
type t
```
```reasonml
type t;
```
```ocaml
type config
```
```reasonml
type config;
```
```ocaml
val config : 
  ?persistent:bool ->
  ?recursive:bool ->
  ?encoding:Js.String.t ->
  unit ->
  config
```
```reasonml
let config: 
  ?persistent:bool =>
  ?recursive:bool =>
  ?encoding:Js.String.t =>
  unit =>
  config;
```
```ocaml
val watch : string -> ?config:config -> unit -> t
```
```reasonml
let watch: string => ?config:config => unit => t;
```
there is no need to accept listener, since we return a `watcher` back it can register event listener there. Currently we introduce a type `string_buffer`, for the `filename`, it will be `Buffer` when the encoding is ``utf8`. This is dependent type which can be tracked by GADT in some way, but to make things simple, let's just introduce an or type`

```ocaml
val on : 
  t ->
  f:
    [ `change of (string -> Node.string_buffer -> unit) Js.Fn.arity2
    | `error of unit Js.Fn.arity0 ] ->
  t
```
```reasonml
let on: 
  t =>
  f:
    [ `change(Js.Fn.arity2((string => Node.string_buffer => unit)))
    | `error(Js.Fn.arity0(unit)) ] =>
  t;
```
```ocaml
val close : t -> unit
```
```reasonml
let close: t => unit;
```