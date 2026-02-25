
# Module `Sys.Immediate64`

This module allows to define a type `t` with the `immediate64` attribute. This attribute means that the type is immediate on 64 bit architectures. On other architectures, it might or might not be immediate.

since 4\.10
```ocaml
module type Non_immediate = sig ... end
```
```reasonml
module type Non_immediate = { ... };
```
```ocaml
module type Immediate = sig ... end
```
```reasonml
module type Immediate = { ... };
```
```ocaml
module Make
  (Immediate : Immediate)
  (Non_immediate : Non_immediate) : 
  sig ... end
```
```reasonml
module Make: 
   (Immediate: Immediate) =>
   (Non_immediate: Non_immediate) =>
  { ... };
```