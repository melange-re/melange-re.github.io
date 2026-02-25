
# Module `Stdlib.Type`

Type introspection.

since 5\.1

## Type equality witness

```ocaml
type (_, _) eq = 
```
```reasonml
type eq(_, _) = 
```
```ocaml
| Equal : ('a, 'a) eq
```
```reasonml
| Equal : eq('a, 'a)
```
```ocaml

```
```reasonml
;
```
The purpose of `eq` is to represent type equalities that may not otherwise be known by the type checker (e.g. because they may depend on dynamic data).

A value of type `(a, b) eq` represents the fact that types `a` and `b` are equal.

If one has a value `eq : (a, b) eq` that proves types `a` and `b` are equal, one can use it to convert a value of type `a` to a value of type `b` by pattern matching on `Equal`:

```ocaml
  let cast (type a) (type b) (Equal : (a, b) Type.eq) (a : a) : b = a
```
```reasonml
let cast = (type a, type b, Equal: Type.eq(a, b), a: a): b => a;
```
At runtime, this function simply returns its second argument unchanged.


## Type identifiers

```ocaml
module Id : sig ... end
```
```reasonml
module Id: { ... };
```
Type identifiers.
