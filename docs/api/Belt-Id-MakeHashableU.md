
# Module `Id.MakeHashableU`


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
val hash : (t, identity) hash
```
```reasonml
let hash: hash(t, identity);
```
```ocaml
val eq : (t, identity) eq
```
```reasonml
let eq: eq(t, identity);
```