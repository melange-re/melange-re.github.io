# Module `Sys.Immediate64`
This module allows to define a type `t` with the `immediate64` attribute. This attribute means that the type is immediate on 64 bit architectures. On other architectures, it might or might not be immediate.
since 4.10
```
module type Non_immediate = sig ... end
```
```
module type Immediate = sig ... end
```
```
module Make
  (Immediate : Immediate)
  (Non_immediate : Non_immediate) : 
  sig ... end
```