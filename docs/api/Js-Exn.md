
# Module `Js.Exn`

Utilities for dealing with Js exceptions

```ocaml
type t
```
```reasonml
type t;
```
```ocaml
type exn += private 
```
```reasonml
type exn += pri 
```
```ocaml
| Error of t
```
```reasonml
| Error(t)
```
```ocaml

```
```reasonml
;
```
```ocaml
val asJsExn : exn -> t option
```
```reasonml
let asJsExn: exn => option(t);
```
```ocaml
val stack : t -> string option
```
```reasonml
let stack: t => option(string);
```
```ocaml
val message : t -> string option
```
```reasonml
let message: t => option(string);
```
```ocaml
val name : t -> string option
```
```reasonml
let name: t => option(string);
```
```ocaml
val fileName : t -> string option
```
```reasonml
let fileName: t => option(string);
```
```ocaml
val isCamlExceptionOrOpenVariant : 'a -> bool
```
```reasonml
let isCamlExceptionOrOpenVariant: 'a => bool;
```
internal use only

```ocaml
val anyToExnInternal : 'a -> exn
```
```reasonml
let anyToExnInternal: 'a => exn;
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
```ocaml
val raiseError : string -> 'a
```
```reasonml
let raiseError: string => 'a;
```
Raise Js exception Error object with stacktrace

```ocaml
val raiseEvalError : string -> 'a
```
```reasonml
let raiseEvalError: string => 'a;
```
```ocaml
val raiseRangeError : string -> 'a
```
```reasonml
let raiseRangeError: string => 'a;
```
```ocaml
val raiseReferenceError : string -> 'a
```
```reasonml
let raiseReferenceError: string => 'a;
```
```ocaml
val raiseSyntaxError : string -> 'a
```
```reasonml
let raiseSyntaxError: string => 'a;
```
```ocaml
val raiseTypeError : string -> 'a
```
```reasonml
let raiseTypeError: string => 'a;
```
```ocaml
val raiseUriError : string -> 'a
```
```reasonml
let raiseUriError: string => 'a;
```