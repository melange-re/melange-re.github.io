
# Module `Fs.Watch`

```
type t
```
```
type config
```
```
val config : 
  ?persistent:bool ->
  ?recursive:bool ->
  ?encoding:Js.String.t ->
  unit ->
  config
```
```
val watch : string -> ?config:config -> unit -> t
```
there is no need to accept listener, since we return a `watcher` back it can register event listener there. Currently we introduce a type `string_buffer`, for the `filename`, it will be `Buffer` when the encoding is `` `utf8 ``. This is dependent type which can be tracked by GADT in some way, but to make things simple, let's just introduce an or type

```
val on : 
  t ->
  f:
    [ `change of (string -> Node.string_buffer -> unit) Js.Fn.arity2
    | `error of unit Js.Fn.arity0 ] ->
  t
```
```
val close : t -> unit
```