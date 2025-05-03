
# Module `Stdlib.StdLabels`

Standard labeled libraries.

This meta-module provides versions of the [`Array`](./Stdlib-ArrayLabels.md), [`Bytes`](./Stdlib-BytesLabels.md), [`List`](./Stdlib-ListLabels.md) and [`String`](./Stdlib-StringLabels.md) modules where function arguments are systematically labeled. It is intended to be opened at the top of source files, as shown below.

```ocaml
  open StdLabels

  let to_upper = String.map ~f:Char.uppercase_ascii
  let seq len = List.init ~f:(fun i -> i) ~len
  let everything = Array.create_matrix ~dimx:42 ~dimy:42 42
```
```
module Array = ArrayLabels
```
```
module Bytes = BytesLabels
```
```
module List = ListLabels
```
```
module String = StringLabels
```