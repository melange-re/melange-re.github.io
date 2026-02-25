
# Parameter `MakeMinPoly.E`

```ocaml
type 'a t
```
```reasonml
type t('a);
```
The polymorphic type of elements.

```ocaml
val compare : 'a t -> 'b t -> int
```
```reasonml
let compare: t('a) => t('b) => int;
```
`compare` is a total order on values of type [`t`](./#type-t).
