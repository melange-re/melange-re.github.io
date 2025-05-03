
# Module `Js.Bigint`

Bindings to functions in JavaScript's `BigInt`

JavaScript BigInt API

```
type t = Js.bigint
```
```
val make : 'a -> t
```
`make repr` creates a new BigInt from the representation `repr`. `repr` can be a number, a string, boolean, etc.

```
val asIntN : precision:int -> t -> t
```
`asIntN ~precision bigint` truncates the BigInt value of `bigint` to the given number of least significant bits specified by `precision` and returns that value as a signed integer.

```
val asUintN : precision:int -> t -> t
```
`asUintN ~precision bigint` truncates the BigInt value of `bigint` to the given number of least significant bits specified by `precision` and returns that value as an unsigned integer.

```
type toLocaleStringOptions = {
```
`style : string;`
`currency : string;`
```
}
```
```
val toLocaleString : 
  locale:string ->
  ?options:toLocaleStringOptions ->
  t ->
  string
```
`toLocaleString bigint` returns a string with a language-sensitive representation of this BigInt.

```
val toString : t -> string
```
`toString bigint` returns a string representing the specified BigInt value.

```
val neg : t -> t
```
```
val add : t -> t -> t
```
```
val sub : t -> t -> t
```
Subtraction.

```
val mul : t -> t -> t
```
Multiplication.

```
val div : t -> t -> t
```
Division.

```
val rem : t -> t -> t
```