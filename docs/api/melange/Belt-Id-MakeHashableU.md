# Module `Id.MakeHashableU`
## Parameters
```
module M : sig ... end
```
## Signature
```
type identity
```
```
type t = M.t
```
```
val hash : (t, identity) hash
```
```
val eq : (t, identity) eq
```