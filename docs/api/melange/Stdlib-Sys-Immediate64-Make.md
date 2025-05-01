# Module `Immediate64.Make`
## Parameters
```
module Immediate : Immediate
```
```
module Non_immediate : Non_immediate
```
## Signature
```
type t
```
```
type 'a repr = 
```
```
| Immediate : Immediate.t repr
```
```
| Non_immediate : Non_immediate.t repr
```
```

```
```
val repr : t repr
```