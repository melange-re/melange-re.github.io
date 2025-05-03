
# Module `Js.Null`

Utility functions on [`null`](./Js.md#type-null)

Provides functionality for dealing with the `'a Js.null` type

```
type +'a t = 'a Js.null
```
Local alias for `'a Js.null`

```
val return : 'a -> 'a t
```
Constructs a value of `'a Js.null` containing a value of `'a`

```
val empty : 'a t
```
The empty value, `null`

```
val getUnsafe : 'a t -> 'a
```
```
val getExn : 'a t -> 'a
```
```
val bind : f:('a -> 'b t) Js.Fn.arity1 -> 'a t -> 'b t
```
```
val map : f:('a -> 'b) Js.Fn.arity1 -> 'a t -> 'b t
```
Maps the contained value using the given function

If `'a Js.null` contains a value, that value is unwrapped, mapped to a `'b` using the given function `a' -> 'b`, then wrapped back up and returned as `'b Js.null`

```ocaml
let maybeGreetWorld (maybeGreeting: string Js.null) =
  Js.Null.bind maybeGreeting ~f:(fun greeting -> greeting ^ " world!")
```
```
val iter : f:('a -> unit) Js.Fn.arity1 -> 'a t -> unit
```
Iterates over the contained value with the given function

If `'a Js.null` contains a value, that value is unwrapped and applied to the given function.

```ocaml
let maybeSay (maybeMessage: string Js.null) =
  Js.Null.iter maybeMessage ~f:(fun message -> Js.log message)
```
```
val fromOption : 'a option -> 'a t
```
Maps `'a option` to `'a Js.null`


<table>
<tr> <td>Some a <td>-> <td>return a
<tr> <td>None <td>-> <td>empty
</table>

```
val toOption : 'a t -> 'a option
```
Maps `'a Js.null` to `'a option`


<table>
<tr> <td>return a <td>-> <td>Some a
<tr> <td>empty <td>-> <td>None
</table>
