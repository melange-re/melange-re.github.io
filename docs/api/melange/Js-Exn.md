# Module `Js.Exn`
Utilities for dealing with Js exceptions
```
type t
```
```
type exn += private 
```
```
| Error of t
```
```

```
```
val asJsExn : exn -> t option
```
```
val stack : t -> string option
```
```
val message : t -> string option
```
```
val name : t -> string option
```
```
val fileName : t -> string option
```
```
val isCamlExceptionOrOpenVariant : 'a -> bool
```
internal use only
```
val anyToExnInternal : 'a -> exn
```
`anyToExnInternal obj` will take any value `obj` and wrap it in a Js.Exn.Error if given value is not an exn already. If `obj` is an exn, it will return `obj` without any changes.
This function is mostly useful for cases where you want to unify a type of a value that potentially is either exn, a JS error, or any other JS value really (e.g. for a value passed to a Promise.catch callback)
IMPORTANT: This is an internal API and may be changed / removed any time in the future.
```ocaml
  switch (Js.Exn.unsafeAnyToExn("test")) {
  | Js.Exn.Error(v) =>
    switch (Js.Exn.message(v)) {
    | Some(str) => Js.log("We won't end up here")
    | None => Js.log2("We will land here: ", v)
    }
  }
```
```
val raiseError : string -> 'a
```
Raise Js exception Error object with stacktrace
```
val raiseEvalError : string -> 'a
```
```
val raiseRangeError : string -> 'a
```
```
val raiseReferenceError : string -> 'a
```
```
val raiseSyntaxError : string -> 'a
```
```
val raiseTypeError : string -> 'a
```
```
val raiseUriError : string -> 'a
```