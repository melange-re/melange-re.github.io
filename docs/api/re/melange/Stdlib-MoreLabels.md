
# Module `Stdlib.MoreLabels`

Extra labeled libraries.

This meta-module provides labelized versions of the [`Hashtbl`](./Stdlib-MoreLabels-Hashtbl.md), [`Map`](./Stdlib-MoreLabels-Map.md) and [`Set`](./Stdlib-MoreLabels-Set.md) modules.

This module is intended to be used through `open MoreLabels` which replaces [`Hashtbl`](./Stdlib-MoreLabels-Hashtbl.md), [`Map`](./Stdlib-MoreLabels-Map.md), and [`Set`](./Stdlib-MoreLabels-Set.md) with their labeled counterparts.

For example:

```ocaml
  open MoreLabels

  Hashtbl.iter ~f:(fun ~key ~data -> g key data) table
```
```
module Hashtbl : sig ... end
```
Hash tables and hash functions.

```
module Map : sig ... end
```
Association tables over ordered types.

```
module Set : sig ... end
```
Sets over ordered types.
