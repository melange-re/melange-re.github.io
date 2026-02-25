
# Module `Js.Bigint`

Bindings to functions in JavaScript's `BigInt`

JavaScript BigInt API

```ocaml
type t = Js.bigint
```
```reasonml
type t = Js.bigint;
```
```ocaml
val make : 'a -> t
```
```reasonml
let make: 'a => t;
```
`make repr` creates a new BigInt from the representation `repr`. `repr` can be a number, a string, boolean, etc.

```ocaml
val asIntN : precision:int -> t -> t
```
```reasonml
let asIntN: precision:int => t => t;
```
`asIntN ~precision bigint` truncates the BigInt value of `bigint` to the given number of least significant bits specified by `precision` and returns that value as a signed integer.

```ocaml
val asUintN : precision:int -> t -> t
```
```reasonml
let asUintN: precision:int => t => t;
```
`asUintN ~precision bigint` truncates the BigInt value of `bigint` to the given number of least significant bits specified by `precision` and returns that value as an unsigned integer.

```
type toLocaleStringOptions = {
```
`style : string;`
`currency : string;`
```ocaml
}
```
```reasonml
};
```
```ocaml
val toLocaleString : 
  locale:string ->
  ?options:toLocaleStringOptions ->
  t ->
  string
```
```reasonml
let toLocaleString: 
  locale:string =>
  ?options:toLocaleStringOptions =>
  t =>
  string;
```
`toLocaleString bigint` returns a string with a language-sensitive representation of this BigInt.

```ocaml
val toString : t -> string
```
```reasonml
let toString: t => string;
```
`toString bigint` returns a string representing the specified BigInt value.

```ocaml
val neg : t -> t
```
```reasonml
let neg: t => t;
```
```ocaml
val add : t -> t -> t
```
```reasonml
let add: t => t => t;
```
```ocaml
val sub : t -> t -> t
```
```reasonml
let sub: t => t => t;
```
Subtraction.

```ocaml
val mul : t -> t -> t
```
```reasonml
let mul: t => t => t;
```
Multiplication.

```ocaml
val div : t -> t -> t
```
```reasonml
let div: t => t => t;
```
Division.

```ocaml
val rem : t -> t -> t
```
```reasonml
let rem: t => t => t;
```