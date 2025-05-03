
# Module `Js.Promise`

Bindings to JS `Promise` functions

Specialized bindings to Promise. Note: For simplicity, this binding does not track the error type, it treat it as an opaque type

```
type +'a t = 'a Js.promise
```
```
type error
```
```
val make : 
  (resolve:('a -> unit) Js.Fn.arity1 ->
    reject:(exn -> unit) Js.Fn.arity1 ->
    unit) ->
  'a t
```
```
val resolve : 'a -> 'a t
```
```
val reject : exn -> 'a t
```
```
val all : 'a t array -> 'a array t
```
```
val all2 : ('a0 t * 'a1 t) -> ('a0 * 'a1) t
```
```
val all3 : ('a0 t * 'a1 t * 'a2 t) -> ('a0 * 'a1 * 'a2) t
```
```
val all4 : ('a0 t * 'a1 t * 'a2 t * 'a3 t) -> ('a0 * 'a1 * 'a2 * 'a3) t
```
```
val all5 : 
  ('a0 t * 'a1 t * 'a2 t * 'a3 t * 'a4 t) ->
  ('a0 * 'a1 * 'a2 * 'a3 * 'a4) t
```
```
val all6 : 
  ('a0 t * 'a1 t * 'a2 t * 'a3 t * 'a4 t * 'a5 t) ->
  ('a0 * 'a1 * 'a2 * 'a3 * 'a4 * 'a5) t
```
```
val race : 'a t array -> 'a t
```
```
val then_ : ('a -> 'b t) -> 'a t -> 'b t
```
```
val catch : (error -> 'a t) -> 'a t -> 'a t
```