
# Module `Immediate64.Make`


## Parameters

```ocaml
module Immediate : Immediate
```
```reasonml
module Immediate: Immediate
```
```ocaml
module Non_immediate : Non_immediate
```
```reasonml
module Non_immediate: Non_immediate
```

## Signature

```ocaml
type t
```
```reasonml
type t;
```
```ocaml
type 'a repr = 
```
```reasonml
type repr('a) = 
```
```ocaml
| Immediate : Immediate.t repr
```
```reasonml
| Immediate : repr(Immediate.t)
```
```ocaml
| Non_immediate : Non_immediate.t repr
```
```reasonml
| Non_immediate : repr(Non_immediate.t)
```
```ocaml

```
```reasonml
;
```
```ocaml
val repr : t repr
```
```reasonml
let repr: repr(t);
```