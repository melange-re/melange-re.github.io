
# Module `Printexc.Slot`

since 4\.02
```ocaml
type t = backtrace_slot
```
```reasonml
type t = backtrace_slot;
```
```ocaml
val is_raise : t -> bool
```
```reasonml
let is_raise: t => bool;
```
`is_raise slot` is `true` when `slot` refers to a raising point in the code, and `false` when it comes from a simple function call.

since 4\.02
```ocaml
val is_inline : t -> bool
```
```reasonml
let is_inline: t => bool;
```
`is_inline slot` is `true` when `slot` refers to a call that got inlined by the compiler, and `false` when it comes from any other context.

since 4\.04
```ocaml
val location : t -> location option
```
```reasonml
let location: t => option(location);
```
`location slot` returns the location information of the slot, if available, and `None` otherwise.

Some possible reasons for failing to return a location are as follow:

- the slot corresponds to a compiler-inserted raise
- the slot corresponds to a part of the program that has not been compiled with debug information (`-g`)
since 4\.02
```ocaml
val name : t -> string option
```
```reasonml
let name: t => option(string);
```
`name slot` returns the name of the function or definition enclosing the location referred to by the slot.

`name slot` returns None if the name is unavailable, which may happen for the same reasons as `location` returning None.

since 4\.11
```ocaml
val format : int -> t -> string option
```
```reasonml
let format: int => t => option(string);
```
`format pos slot` returns the string representation of `slot` as `raw_backtrace_to_string` would format it, assuming it is the `pos`\-th element of the backtrace: the `0`\-th element is pretty-printed differently than the others.

Whole-backtrace printing functions also skip some uninformative slots; in that case, `format pos slot` returns `None`.

since 4\.02