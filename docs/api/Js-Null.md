
# Module `Js.Null`

Utility functions on [`null`](./Js.md#type-null)

Provides functionality for dealing with the <code class="text-ocaml">'a Js.null</code><code class="text-reasonml">Js.null('a)</code> type

```ocaml
type +'a t = 'a Js.null
```
```reasonml
type t(+'a) = Js.null('a);
```
Local alias for <code class="text-ocaml">'a Js.null</code><code class="text-reasonml">Js.null('a)</code>

```ocaml
val return : 'a -> 'a t
```
```reasonml
let return: 'a => t('a);
```
Constructs a value of <code class="text-ocaml">'a Js.null</code><code class="text-reasonml">Js.null('a)</code> containing a value of `'a`

```ocaml
val empty : 'a t
```
```reasonml
let empty: t('a);
```
The empty value, `null`

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
val bind : f:('a -> 'b t) Js.Fn.arity1 -> 'a t -> 'b t
```
```reasonml
let bind: f:Js.Fn.arity1(('a => t('b))) => t('a) => t('b);
```
```ocaml
val map : f:('a -> 'b) Js.Fn.arity1 -> 'a t -> 'b t
```
```reasonml
let map: f:Js.Fn.arity1(('a => 'b)) => t('a) => t('b);
```
Maps the contained value using the given function

If <code class="text-ocaml">'a Js.null</code><code class="text-reasonml">Js.null('a)</code> contains a value, that value is unwrapped, mapped to a `'b` using the given function <code class="text-ocaml">a' -&gt; 'b</code><code class="text-reasonml">a' =&gt; 'b</code>, then wrapped back up and returned as <code class="text-ocaml">'b Js.null</code><code class="text-reasonml">Js.null('b)</code>

```ocaml
let maybeGreetWorld (maybeGreeting: string Js.null) =
  Js.Null.bind maybeGreeting ~f:(fun greeting -> greeting ^ " world!")
```
```reasonml
let maybeGreetWorld = (maybeGreeting: Js.null(string)) =>
  Js.Null.bind(maybeGreeting, ~f=greeting => greeting ++ " world!");
```
```ocaml
val iter : f:('a -> unit) Js.Fn.arity1 -> 'a t -> unit
```
```reasonml
let iter: f:Js.Fn.arity1(('a => unit)) => t('a) => unit;
```
Iterates over the contained value with the given function

If <code class="text-ocaml">'a Js.null</code><code class="text-reasonml">Js.null('a)</code> contains a value, that value is unwrapped and applied to the given function.

```ocaml
let maybeSay (maybeMessage: string Js.null) =
  Js.Null.iter maybeMessage ~f:(fun message -> Js.log message)
```
```reasonml
let maybeSay = (maybeMessage: Js.null(string)) =>
  Js.Null.iter(maybeMessage, ~f=message => Js.log(message));
```
```ocaml
val fromOption : 'a option -> 'a t
```
```reasonml
let fromOption: option('a) => t('a);
```
Maps <code class="text-ocaml">'a option</code><code class="text-reasonml">option('a)</code> to <code class="text-ocaml">'a Js.null</code><code class="text-reasonml">Js.null('a)</code>

| Some a | return a |
| --- | --- |
| None | empty |
```ocaml
val toOption : 'a t -> 'a option
```
```reasonml
let toOption: t('a) => option('a);
```
Maps <code class="text-ocaml">'a Js.null</code><code class="text-reasonml">Js.null('a)</code> to <code class="text-ocaml">'a option</code><code class="text-reasonml">option('a)</code>

| return a | Some a |
| --- | --- |
| empty | None |