
# Module `Js.Undefined`

Utility functions on [`undefined`](./Js.md#type-undefined)

Provides functionality for dealing with the <code class="text-ocaml">'a Js.undefined</code><code class="text-reasonml">Js.undefined('a)</code> type

```ocaml
type +'a t = 'a Js.undefined
```
```reasonml
type t(+'a) = Js.undefined('a);
```
Local alias for <code class="text-ocaml">'a Js.undefined</code><code class="text-reasonml">Js.undefined('a)</code>

```ocaml
val return : 'a -> 'a t
```
```reasonml
let return: 'a => t('a);
```
Constructs a value of <code class="text-ocaml">'a Js.undefined</code><code class="text-reasonml">Js.undefined('a)</code> containing a value of `'a`

```ocaml
val testAny : 'a -> bool
```
```reasonml
let testAny: 'a => bool;
```
Returns `true` if the given value is `empty` (`undefined`)

```ocaml
val empty : 'a t
```
```reasonml
let empty: t('a);
```
The empty value, `undefined`

```ocaml
val getUnsafe : 'a t -> 'a
```
```reasonml
let getUnsafe: t('a) => 'a;
```
```ocaml
val getExn : 'a t -> 'a
```
```reasonml
let getExn: t('a) => 'a;
```
```ocaml
val map : f:('a -> 'b) Js.Fn.arity1 -> 'a t -> 'b t
```
```reasonml
let map: f:Js.Fn.arity1(('a => 'b)) => t('a) => t('b);
```
```ocaml
val bind : f:('a -> 'b t) Js.Fn.arity1 -> 'a t -> 'b t
```
```reasonml
let bind: f:Js.Fn.arity1(('a => t('b))) => t('a) => t('b);
```
Bind the contained value using the given function

If <code class="text-ocaml">'a Js.undefined</code><code class="text-reasonml">Js.undefined('a)</code> contains a value, that value is unwrapped, mapped to a `'b` using the given function <code class="text-ocaml">a' -&gt; 'b</code><code class="text-reasonml">a' =&gt; 'b</code>, then wrapped back up and returned as <code class="text-ocaml">'b Js.undefined</code><code class="text-reasonml">Js.undefined('b)</code>

```ocaml
let maybeGreetWorld (maybeGreeting: string Js.undefined) =
  Js.Undefined.bind maybeGreeting ~f:(fun greeting -> greeting ^ " world!")
```
```reasonml
let maybeGreetWorld = (maybeGreeting: Js.undefined(string)) =>
  Js.Undefined.bind(maybeGreeting, ~f=greeting => greeting ++ " world!");
```
```ocaml
val iter : f:('a -> unit) Js.Fn.arity1 -> 'a t -> unit
```
```reasonml
let iter: f:Js.Fn.arity1(('a => unit)) => t('a) => unit;
```
Iterates over the contained value with the given function

If <code class="text-ocaml">'a Js.undefined</code><code class="text-reasonml">Js.undefined('a)</code> contains a value, that value is unwrapped and applied to the given function.

```ocaml
let maybeSay (maybeMessage: string Js.undefined) =
  Js.Undefined.iter maybeMessage ~f:(fun message -> Js.log message)
```
```reasonml
let maybeSay = (maybeMessage: Js.undefined(string)) =>
  Js.Undefined.iter(maybeMessage, ~f=message => Js.log(message));
```
```ocaml
val fromOption : 'a option -> 'a t
```
```reasonml
let fromOption: option('a) => t('a);
```
Maps <code class="text-ocaml">'a option</code><code class="text-reasonml">option('a)</code> to <code class="text-ocaml">'a Js.undefined</code><code class="text-reasonml">Js.undefined('a)</code>

| --- | --- | --- |
| Some a | \-\> | return a |
| None | \-\> | empty |
```ocaml
val toOption : 'a t -> 'a option
```
```reasonml
let toOption: t('a) => option('a);
```
Maps <code class="text-ocaml">'a Js.undefined</code><code class="text-reasonml">Js.undefined('a)</code> to <code class="text-ocaml">'a option</code><code class="text-reasonml">option('a)</code>

| --- | --- | --- |
| return a | \-\> | Some a |
| empty | \-\> | None |