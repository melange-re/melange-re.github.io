# Module `Node`
```
type node_exports
```
```
type node_module =
  < id : string
    ; exports : node_exports
    ; parent : node_module Js.nullable
    ; filename : string
    ; loaded : bool
    ; children : node_module array
    ; paths : string array >
    Js.t
```
```
type node_require =
  < main : node_module Js.undefined
    ; resolve : (string -> string) Js.Fn.arity1 >
    Js.t
```
```
type string_buffer
```
```
type buffer
```
```
type _ string_buffer_kind = 
```
```
| String : string string_buffer_kind
```
```
| Buffer : buffer string_buffer_kind
```
```

```
```
val test : string_buffer -> 't string_buffer_kind * 't
```
We expect a good inliner will eliminate such boxing in the future
```
module Path : sig ... end
```
Node Path API
```
module Fs : sig ... end
```
Node FS API
```
module Process : sig ... end
```
```
module Module : sig ... end
```
Node Module API
```
module Buffer : sig ... end
```
Node Buffer API
```
module Child_process : sig ... end
```
Node Child Process API