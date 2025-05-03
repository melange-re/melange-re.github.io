
# Module `Js.Undefined`

Utility functions on [`undefined`](./Js.md#type-undefined)

Provides functionality for dealing with the `'a Js.undefined` type

```
type +'a t = 'a Js.undefined
```
Local alias for `'a Js.undefined`

```
val return : 'a -> 'a t
```
Constructs a value of `'a Js.undefined` containing a value of `'a`

```
val testAny : 'a -> bool
```
Returns `true` if the given value is `empty` (`undefined`)

```
val empty : 'a t
```
The empty value, `undefined`

```
val getUnsafe : 'a t -> 'a
```
```
val getExn : 'a t -> 'a
```
```
val map : f:('a -> 'b) Js.Fn.arity1 -> 'a t -> 'b t
```
```
val bind : f:('a -> 'b t) Js.Fn.arity1 -> 'a t -> 'b t
```
Bind the contained value using the given function

If `'a Js.undefined` contains a value, that value is unwrapped, mapped to a `'b` using the given function `a' -> 'b`, then wrapped back up and returned as `'b Js.undefined`

```ocaml
let maybeGreetWorld (maybeGreeting: string Js.undefined) =
  Js.Undefined.bind maybeGreeting ~f:(fun greeting -> greeting ^ " world!")
```
```
val iter : f:('a -> unit) Js.Fn.arity1 -> 'a t -> unit
```
Iterates over the contained value with the given function

If `'a Js.undefined` contains a value, that value is unwrapped and applied to the given function.

```ocaml
let maybeSay (maybeMessage: string Js.undefined) =
  Js.Undefined.iter maybeMessage ~f:(fun message -> Js.log message)
```
```
val fromOption : 'a option -> 'a t
```
Maps `'a option` to `'a Js.undefined`


<table>
<tr> <td>Some a <td>-> <td>return a
<tr> <td>None <td>-> <td>empty
</table>

```
val toOption : 'a t -> 'a option
```
Maps `'a Js.undefined` to `'a option`


<table>
<tr> <td>return a <td>-> <td>Some a
<tr> <td>empty <td>-> <td>None
</table>
