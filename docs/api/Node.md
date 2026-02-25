
# Module `Node`

```ocaml
type node_exports
```
```reasonml
type node_exports;
```
```ocaml
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
```reasonml
type node_module =
  Js.t({. id: string
    , exports: node_exports
    , parent: Js.nullable(node_module)
    , filename: string
    , loaded: bool
    , children: array(node_module)
    , paths: array(string)});
```
```ocaml
type node_require =
  < main : node_module Js.undefined
    ; resolve : (string -> string) Js.Fn.arity1 >
    Js.t
```
```reasonml
type node_require =
  Js.t({. main: Js.undefined(node_module)
    , resolve: Js.Fn.arity1((string => string))});
```
```ocaml
type string_buffer
```
```reasonml
type string_buffer;
```
```ocaml
type buffer
```
```reasonml
type buffer;
```
```ocaml
type _ string_buffer_kind = 
```
```reasonml
type string_buffer_kind(_) = 
```
```ocaml
| String : string string_buffer_kind
```
```reasonml
| String : string_buffer_kind(string)
```
```ocaml
| Buffer : buffer string_buffer_kind
```
```reasonml
| Buffer : string_buffer_kind(buffer)
```
```ocaml

```
```reasonml
;
```
```ocaml
val test : string_buffer -> 't string_buffer_kind * 't
```
```reasonml
let test: string_buffer => (string_buffer_kind('t), 't);
```
We expect a good inliner will eliminate such boxing in the future

```ocaml
module Path : sig ... end
```
```reasonml
module Path: { ... };
```
Node Path API

```ocaml
module Fs : sig ... end
```
```reasonml
module Fs: { ... };
```
Node FS API

```ocaml
module Process : sig ... end
```
```reasonml
module Process: { ... };
```
```ocaml
module Module : sig ... end
```
```reasonml
module Module: { ... };
```
Node Module API

```ocaml
module Buffer : sig ... end
```
```reasonml
module Buffer: { ... };
```
Node Buffer API

```ocaml
module Child_process : sig ... end
```
```reasonml
module Child_process: { ... };
```
Node Child Process API
