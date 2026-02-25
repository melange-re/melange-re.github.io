
# Module `Stdlib.Obj`

Operations on internal representations of values.

Not for the casual user.

```ocaml
type t
```
```reasonml
type t;
```
```ocaml
type raw_data = nativeint
```
```reasonml
type raw_data = nativeint;
```
```ocaml
val repr : 'a -> t
```
```reasonml
let repr: 'a => t;
```
```ocaml
val obj : t -> 'a
```
```reasonml
let obj: t => 'a;
```
```ocaml
val magic : 'a -> 'b
```
```reasonml
let magic: 'a => 'b;
```
```ocaml
val is_block : t -> bool
```
```reasonml
let is_block: t => bool;
```
```ocaml
val is_int : t -> bool
```
```reasonml
let is_int: t => bool;
```
```ocaml
val tag : t -> int
```
```reasonml
let tag: t => int;
```
```ocaml
val size : t -> int
```
```reasonml
let size: t => int;
```
```ocaml
val reachable_words : t -> int
```
```reasonml
let reachable_words: t => int;
```
Computes the total size (in words, including the headers) of all heap blocks accessible from the argument. Statically allocated blocks are included.

since 4\.04
```ocaml
val field : t -> int -> t
```
```reasonml
let field: t => int => t;
```
```ocaml
val set_field : t -> int -> t -> unit
```
```reasonml
let set_field: t => int => t => unit;
```
When using flambda:

`set_field` MUST NOT be called on immutable blocks. (Blocks allocated in C stubs, or with `new_block` below, are always considered mutable.)

The same goes for `set_double_field`.

For experts only: `set_field` et al can be made safe by first wrapping the block in [`Sys.opaque_identity`](./Stdlib-Sys.md#val-opaque_identity), so any information about its contents will not be propagated.

```ocaml
val double_field : t -> int -> float
```
```reasonml
let double_field: t => int => float;
```
```ocaml
val set_double_field : t -> int -> float -> unit
```
```reasonml
let set_double_field: t => int => float => unit;
```
```ocaml
val raw_field : t -> int -> raw_data
```
```reasonml
let raw_field: t => int => raw_data;
```
```ocaml
val set_raw_field : t -> int -> raw_data -> unit
```
```reasonml
let set_raw_field: t => int => raw_data => unit;
```
```ocaml
val new_block : int -> int -> t
```
```reasonml
let new_block: int => int => t;
```
```ocaml
val dup : t -> t
```
```reasonml
let dup: t => t;
```
```ocaml
val add_offset : t -> Int32.t -> t
```
```reasonml
let add_offset: t => Int32.t => t;
```
```ocaml
val with_tag : int -> t -> t
```
```reasonml
let with_tag: int => t => t;
```
```ocaml
val first_non_constant_constructor_tag : int
```
```reasonml
let first_non_constant_constructor_tag: int;
```
```ocaml
val last_non_constant_constructor_tag : int
```
```reasonml
let last_non_constant_constructor_tag: int;
```
```ocaml
val forcing_tag : int
```
```reasonml
let forcing_tag: int;
```
```ocaml
val cont_tag : int
```
```reasonml
let cont_tag: int;
```
```ocaml
val lazy_tag : int
```
```reasonml
let lazy_tag: int;
```
```ocaml
val closure_tag : int
```
```reasonml
let closure_tag: int;
```
```ocaml
val object_tag : int
```
```reasonml
let object_tag: int;
```
```ocaml
val infix_tag : int
```
```reasonml
let infix_tag: int;
```
```ocaml
val forward_tag : int
```
```reasonml
let forward_tag: int;
```
```ocaml
val no_scan_tag : int
```
```reasonml
let no_scan_tag: int;
```
```ocaml
val abstract_tag : int
```
```reasonml
let abstract_tag: int;
```
```ocaml
val string_tag : int
```
```reasonml
let string_tag: int;
```
```ocaml
val double_tag : int
```
```reasonml
let double_tag: int;
```
```ocaml
val double_array_tag : int
```
```reasonml
let double_array_tag: int;
```
```ocaml
val custom_tag : int
```
```reasonml
let custom_tag: int;
```
```ocaml
val int_tag : int
```
```reasonml
let int_tag: int;
```
```ocaml
val out_of_heap_tag : int
```
```reasonml
let out_of_heap_tag: int;
```
```ocaml
val unaligned_tag : int
```
```reasonml
let unaligned_tag: int;
```
```ocaml
module Extension_constructor : sig ... end
```
```reasonml
module Extension_constructor: { ... };
```
```ocaml
module Ephemeron : sig ... end
```
```reasonml
module Ephemeron: { ... };
```
Ephemeron with arbitrary arity and untyped
