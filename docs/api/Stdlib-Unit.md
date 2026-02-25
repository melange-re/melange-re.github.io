
# Module `Stdlib.Unit`

Unit values.

since 4\.08

## The unit type

```
type t = unit = 
```
```
| ()
```
```ocaml

```
```reasonml
;
```
The unit type.

The constructor `()` is included here so that it has a path, but it is not intended to be used in user-defined data types.

```ocaml
val equal : t -> t -> bool
```
```reasonml
let equal: t => t => bool;
```
`equal u1 u2` is `true`.

```ocaml
val compare : t -> t -> int
```
```reasonml
let compare: t => t => int;
```
`compare u1 u2` is `0`.

```ocaml
val to_string : t -> string
```
```reasonml
let to_string: t => string;
```
`to_string b` is `"()"`.
