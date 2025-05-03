
# Module `Stdlib.Obj`

Operations on internal representations of values.

Not for the casual user.

```
type t
```
```
type raw_data = nativeint
```
```
val repr : 'a -> t
```
```
val obj : t -> 'a
```
```
val magic : 'a -> 'b
```
```
val is_block : t -> bool
```
```
val is_int : t -> bool
```
```
val tag : t -> int
```
```
val size : t -> int
```
```
val reachable_words : t -> int
```
Computes the total size (in words, including the headers) of all heap blocks accessible from the argument. Statically allocated blocks are included.

since 4.04
```
val field : t -> int -> t
```
```
val set_field : t -> int -> t -> unit
```
When using flambda:

`set_field` MUST NOT be called on immutable blocks. (Blocks allocated in C stubs, or with `new_block` below, are always considered mutable.)

The same goes for `set_double_field`.

For experts only: `set_field` et al can be made safe by first wrapping the block in [`Sys.opaque_identity`](./Stdlib-Sys.md#val-opaque_identity), so any information about its contents will not be propagated.

```
val double_field : t -> int -> float
```
```
val set_double_field : t -> int -> float -> unit
```
```
val raw_field : t -> int -> raw_data
```
```
val set_raw_field : t -> int -> raw_data -> unit
```
```
val new_block : int -> int -> t
```
```
val dup : t -> t
```
```
val add_offset : t -> Int32.t -> t
```
```
val with_tag : int -> t -> t
```
```
val first_non_constant_constructor_tag : int
```
```
val last_non_constant_constructor_tag : int
```
```
val forcing_tag : int
```
```
val cont_tag : int
```
```
val lazy_tag : int
```
```
val closure_tag : int
```
```
val object_tag : int
```
```
val infix_tag : int
```
```
val forward_tag : int
```
```
val no_scan_tag : int
```
```
val abstract_tag : int
```
```
val string_tag : int
```
```
val double_tag : int
```
```
val double_array_tag : int
```
```
val custom_tag : int
```
```
val int_tag : int
```
```
val out_of_heap_tag : int
```
```
val unaligned_tag : int
```
```
module Extension_constructor : sig ... end
```
```
module Ephemeron : sig ... end
```
Ephemeron with arbitrary arity and untyped
