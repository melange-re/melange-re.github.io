
# Module `Js.Nullable`

Utility functions on [`nullable`](./Js.md#type-nullable)

Contains functionality for dealing with values that can be both `null` and `undefined`

```
type +'a t = 'a Js.nullable
```
Local alias for `'a Js.nullable`

```
val return : 'a -> 'a t
```
Constructs a value of `'a Js.nullable` containing a value of `'a`

```
val isNullable : 'a t -> bool
```
Returns `true` if the given value is `null` or `undefined`, `false` otherwise

```
val null : 'a t
```
The `null` value of type `'a Js.nullable`

```
val undefined : 'a t
```
The `undefined` value of type `'a Js.nullable`

```
val map : f:('a -> 'b) Js.Fn.arity1 -> 'a t -> 'b t
```
```
val bind : f:('a -> 'b t) Js.Fn.arity1 -> 'a t -> 'b t
```
Binds the contained value using the given function

If `'a Js.nullable` contains a value, that value is unwrapped, mapped to a `'b` using the given function `a' -> 'b`, then wrapped back up and returned as `'b Js.nullable`

```ocaml
let maybeGreetWorld (maybeGreeting: string Js.nullable) =
  Js.Nullable.bind maybeGreeting ~f:(fun greeting -> greeting ^ " world!")
```
```
val iter : f:('a -> unit) Js.Fn.arity1 -> 'a t -> unit
```
Iterates over the contained value with the given function

If `'a Js.nullable` contains a value, that value is unwrapped and applied to the given function.

```ocaml
let maybeSay (maybeMessage: string Js.nullable) =
  Js.Nullable.iter maybeMessage ~f:(fun message -> Js.log message)
```
```
val fromOption : 'a option -> 'a t
```
Maps `'a option` to `'a Js.nullable`


<table>
<tr> <td>Some a <td>-> <td>return a
<tr> <td>None <td>-> <td>undefined
</table>

```
val toOption : 'a t -> 'a option
```
Maps `'a Js.nullable` to `'a option`


<table>
<tr> <td>return a <td>-> <td>Some a
<tr> <td>undefined <td>-> <td>None
<tr> <td>null <td>-> <td>None
</table>
