
# Module `Id.MakeComparable`


## Parameters

```ocaml
module M : sig ... end
```
```reasonml
module M: { ... }
```

## Signature

```ocaml
type identity
```
```reasonml
type identity;
```
```ocaml
type t = M.t
```
```reasonml
type t = M.t;
```
```ocaml
val cmp : (t, identity) cmp
```
```reasonml
let cmp: cmp(t, identity);
```