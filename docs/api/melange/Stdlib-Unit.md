# Module `Stdlib.Unit`
Unit values.
since 4.08
## The unit type
```
type t = unit = 
```
```
| ()
```
```

```
The unit type.
The constructor `()` is included here so that it has a path, but it is not intended to be used in user-defined data types.
```
val equal : t -> t -> bool
```
`equal u1 u2` is `true`.
```
val compare : t -> t -> int
```
`compare u1 u2` is `0`.
```
val to_string : t -> string
```
`to_string b` is `"()"`.