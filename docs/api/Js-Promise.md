
# Module `Js.Promise`

Bindings to JS `Promise` functions

Specialized bindings to Promise. Note: For simplicity, this binding does not track the error type, it treat it as an opaque type

```ocaml
type +'a t = 'a Js.promise
```
```reasonml
type t(+'a) = Js.promise('a);
```
```ocaml
type error
```
```reasonml
type error;
```
```ocaml
val make : 
  (resolve:('a -> unit) Js.Fn.arity1 ->
    reject:(exn -> unit) Js.Fn.arity1 ->
    unit) ->
  'a t
```
```reasonml
let make: 
  (resolve:Js.Fn.arity1(('a => unit)) =>
    reject:Js.Fn.arity1((exn => unit)) =>
    unit) =>
  t('a);
```
```ocaml
val resolve : 'a -> 'a t
```
```reasonml
let resolve: 'a => t('a);
```
```ocaml
val reject : exn -> 'a t
```
```reasonml
let reject: exn => t('a);
```
```ocaml
val all : 'a t array -> 'a array t
```
```reasonml
let all: array(t('a)) => t(array('a));
```
```ocaml
val all2 : ('a0 t * 'a1 t) -> ('a0 * 'a1) t
```
```reasonml
let all2: (t('a0), t('a1)) => t(('a0, 'a1));
```
```ocaml
val all3 : ('a0 t * 'a1 t * 'a2 t) -> ('a0 * 'a1 * 'a2) t
```
```reasonml
let all3: (t('a0), t('a1), t('a2)) => t(('a0, 'a1, 'a2));
```
```ocaml
val all4 : ('a0 t * 'a1 t * 'a2 t * 'a3 t) -> ('a0 * 'a1 * 'a2 * 'a3) t
```
```reasonml
let all4: (t('a0), t('a1), t('a2), t('a3)) => t(('a0, 'a1, 'a2, 'a3));
```
```ocaml
val all5 : 
  ('a0 t * 'a1 t * 'a2 t * 'a3 t * 'a4 t) ->
  ('a0 * 'a1 * 'a2 * 'a3 * 'a4) t
```
```reasonml
let all5: 
  (t('a0), t('a1), t('a2), t('a3), t('a4)) =>
  t(('a0, 'a1, 'a2, 'a3, 'a4));
```
```ocaml
val all6 : 
  ('a0 t * 'a1 t * 'a2 t * 'a3 t * 'a4 t * 'a5 t) ->
  ('a0 * 'a1 * 'a2 * 'a3 * 'a4 * 'a5) t
```
```reasonml
let all6: 
  (t('a0), t('a1), t('a2), t('a3), t('a4), t('a5)) =>
  t(('a0, 'a1, 'a2, 'a3, 'a4, 'a5));
```
```ocaml
val race : 'a t array -> 'a t
```
```reasonml
let race: array(t('a)) => t('a);
```
```ocaml
val then_ : ('a -> 'b t) -> 'a t -> 'b t
```
```reasonml
let then_: ('a => t('b)) => t('a) => t('b);
```
```ocaml
val catch : (error -> 'a t) -> 'a t -> 'a t
```
```reasonml
let catch: (error => t('a)) => t('a) => t('a);
```