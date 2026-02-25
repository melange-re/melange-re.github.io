
# Module `Js.Nullable`

Utility functions on [`nullable`](./Js.md#type-nullable)

Contains functionality for dealing with values that can be both `null` and `undefined`

```ocaml
type +'a t = 'a Js.nullable
```
```reasonml
type t(+'a) = Js.nullable('a);
```
Local alias for <code class="text-ocaml">'a Js.nullable</code><code class="text-reasonml">Js.nullable('a)</code>

```ocaml
val return : 'a -> 'a t
```
```reasonml
let return: 'a => t('a);
```
Constructs a value of <code class="text-ocaml">'a Js.nullable</code><code class="text-reasonml">Js.nullable('a)</code> containing a value of `'a`

```ocaml
val isNullable : 'a t -> bool
```
```reasonml
let isNullable: t('a) => bool;
```
Returns `true` if the given value is `null` or `undefined`, `false` otherwise

```ocaml
val null : 'a t
```
```reasonml
let null: t('a);
```
The `null` value of type <code class="text-ocaml">'a Js.nullable</code><code class="text-reasonml">Js.nullable('a)</code>

```ocaml
val undefined : 'a t
```
```reasonml
let undefined: t('a);
```
The `undefined` value of type <code class="text-ocaml">'a Js.nullable</code><code class="text-reasonml">Js.nullable('a)</code>

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
Binds the contained value using the given function

If <code class="text-ocaml">'a Js.nullable</code><code class="text-reasonml">Js.nullable('a)</code> contains a value, that value is unwrapped, mapped to a `'b` using the given function <code class="text-ocaml">a' -&gt; 'b</code><code class="text-reasonml">a' =&gt; 'b</code>, then wrapped back up and returned as <code class="text-ocaml">'b Js.nullable</code><code class="text-reasonml">Js.nullable('b)</code>

```ocaml
let maybeGreetWorld (maybeGreeting: string Js.nullable) =
  Js.Nullable.bind maybeGreeting ~f:(fun greeting -> greeting ^ " world!")
```
```reasonml
let maybeGreetWorld = (maybeGreeting: Js.nullable(string)) =>
  Js.Nullable.bind(maybeGreeting, ~f=greeting => greeting ++ " world!");
```
```ocaml
val iter : f:('a -> unit) Js.Fn.arity1 -> 'a t -> unit
```
```reasonml
let iter: f:Js.Fn.arity1(('a => unit)) => t('a) => unit;
```
Iterates over the contained value with the given function

If <code class="text-ocaml">'a Js.nullable</code><code class="text-reasonml">Js.nullable('a)</code> contains a value, that value is unwrapped and applied to the given function.

```ocaml
let maybeSay (maybeMessage: string Js.nullable) =
  Js.Nullable.iter maybeMessage ~f:(fun message -> Js.log message)
```
```reasonml
let maybeSay = (maybeMessage: Js.nullable(string)) =>
  Js.Nullable.iter(maybeMessage, ~f=message => Js.log(message));
```
```ocaml
val fromOption : 'a option -> 'a t
```
```reasonml
let fromOption: option('a) => t('a);
```
Maps <code class="text-ocaml">'a option</code><code class="text-reasonml">option('a)</code> to <code class="text-ocaml">'a Js.nullable</code><code class="text-reasonml">Js.nullable('a)</code>

| Some a | return a |
| --- | --- |
| None | undefined |
```ocaml
val toOption : 'a t -> 'a option
```
```reasonml
let toOption: t('a) => option('a);
```
Maps <code class="text-ocaml">'a Js.nullable</code><code class="text-reasonml">Js.nullable('a)</code> to <code class="text-ocaml">'a option</code><code class="text-reasonml">option('a)</code>

| return a | Some a |
| --- | --- |
| undefined | None |
| null | None |