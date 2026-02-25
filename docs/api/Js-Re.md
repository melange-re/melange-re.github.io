
# Module `Js.Re`

Bindings to the functions in `RegExp.prototype`

Provides bindings for JavaScript Regular Expressions


##### Syntax sugar

Melange provides a bit of syntax sugar for regex literals: `[%re "/foo/g"]` will evaluate to a [`t`](./#type-t) that can be passed around and used like usual.

**Note:** This is not an immutable API. A RegExp object with the `global` ("g") flag set will modify the [`lastIndex`](./#val-lastIndex) property when the RegExp object is used, and subsequent uses will continue the search from the previous [`lastIndex`](./#val-lastIndex).

```ocaml
let maybeMatches = Js.String.exec ~str:"banana" [\[%re "/na+/g"\]]
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/RegExp](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp) JavaScript API reference on MDN
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular\_Expressions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions) JavaScript Regular Expressions Guide on MDN
```ocaml
type t = Js.re
```
```reasonml
type t = Js.re;
```
the RegExp object

```ocaml
type result
```
```reasonml
type result;
```
the result of a executing a RegExp on a string

```ocaml
val captures : result -> string Js.nullable array
```
```reasonml
let captures: result => array(Js.nullable(string));
```
an array of the match and captures, the first is the full match and the remaining are the substring captures

```ocaml
val index : result -> int
```
```reasonml
let index: result => int;
```
0-based index of the match in the input string

```ocaml
val input : result -> string
```
```reasonml
let input: result => string;
```
the original input string

```ocaml
val fromString : string -> t
```
```reasonml
let fromString: string => t;
```
Constructs a RegExp object ([`t`](./#type-t)) from a string

Regex literals (`[%re "/.../"]`) should generally be preferred, but `fromString` is very useful when you need to insert a string into a regex.

```ocaml
(* A function that extracts the content of the first element with the given tag *)

let contentOf tag xmlString =
  Js.Re.fromString ("<" ^ tag ^ ">(.*?)<\\/" ^ tag ^">")
    |> Js.Re.exec ~str:xmlString
    |> function
      | Some result -> Js.Nullable.toOption (Js.Re.captures result).(1)
      | None -> None
```
```reasonml
/* A function that extracts the content of the first element with the given tag */

let contentOf = (tag, xmlString) =>
  Js.Re.fromString("<" ++ tag ++ ">(.*?)<\\/" ++ tag ++ ">")
  |> Js.Re.exec(~str=xmlString)
  |> (
    fun
    | Some(result) => Js.Nullable.toOption(Js.Re.captures(result)[1])
    | None => None
  );
```
```ocaml
val fromStringWithFlags : string -> flags:string -> t
```
```reasonml
let fromStringWithFlags: string => flags:string => t;
```
Constructs a RegExp object ([`t`](./#type-t)) from a string with the given `flags`

See [`fromString`](./#val-fromString)

Valid flags:

| --- | --- |
| g | global |
| i | ignore case |
| m | multiline |
| u | unicode (es2015) |
| y | sticky (es2015) |
```ocaml
val flags : t -> string
```
```reasonml
let flags: t => string;
```
returns the enabled flags as a string

```ocaml
val global : t -> bool
```
```reasonml
let global: t => bool;
```
returns a bool indicating whether the `global` flag is set

```ocaml
val ignoreCase : t -> bool
```
```reasonml
let ignoreCase: t => bool;
```
returns a bool indicating whether the `ignoreCase` flag is set

```ocaml
val lastIndex : t -> int
```
```reasonml
let lastIndex: t => int;
```
returns the index where the next match will start its search

This property will be modified when the RegExp object is used, if the `global` ("g") flag is set.

```ocaml
(* Finds and prints successive matches *)

let re = [%re "/ab*/g"] in
let str = "abbcdefabh" in

let break = ref false in
while not !break do
  match re |> Js.Re.exec ~str with
  | None -> break := true
  | Some result ->
    Js.Nullable.iter (Js.Re.captures result).(0) ((fun match_ ->
      let next = string_of_int (Js.Re.lastIndex re) in
      Js.log ("Found " ^ match_ ^ ". Next match starts at " ^ next)))
done
```
```reasonml
/* Finds and prints successive matches */

{
  let re = [%re "/ab*/g"];
  let str = "abbcdefabh";

  let break = ref(false);
  while (! break^) {
    switch (re |> Js.Re.exec(~str)) {
    | None => break := true
    | Some(result) =>
      Js.Nullable.iter(
        Js.Re.captures(result)[0],
        match => {
          let next = string_of_int(Js.Re.lastIndex(re));
          Js.log("Found " ++ match ++ ". Next match starts at " ++ next);
        },
      )
    };
  };
};
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/RegExp/lastIndex](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp/lastIndex) MDN
```ocaml
val setLastIndex : t -> int -> unit
```
```reasonml
let setLastIndex: t => int => unit;
```
sets the index at which the next match will start its search from

```ocaml
val multiline : t -> bool
```
```reasonml
let multiline: t => bool;
```
returns a bool indicating whether the `multiline` flag is set

```ocaml
val source : t -> string
```
```reasonml
let source: t => string;
```
returns the pattern as a string

```ocaml
val sticky : t -> bool
```
```reasonml
let sticky: t => bool;
```
returns a bool indicating whether the `sticky` flag is set

```ocaml
val unicode : t -> bool
```
```reasonml
let unicode: t => bool;
```
returns a bool indicating whether the `unicode` flag is set

```ocaml
val exec : str:string -> t -> result option
```
```reasonml
let exec: str:string => t => option(result);
```
executes a search on a given string using the given RegExp object

**returns** `Some` [`result`](./#type-result) if a match is found, `None` otherwise

```ocaml
(* Match "quick brown" followed by "jumps", ignoring characters in between
 * Remember "brown" and "jumps"
 * Ignore case
 *)

let re = [%re "/quick\s(brown).+?(jumps)/ig"] in
let result = re |. Js.Re.exec ~str:"The Quick Brown Fox Jumps Over The Lazy Dog"
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/RegExp/exec](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp/exec) MDN
```ocaml
val test : str:string -> t -> bool
```
```reasonml
let test: str:string => t => bool;
```
tests whether the given RegExp object will match a given string

**returns** `true` if a match is found, `false` otherwise

```ocaml
(* A simple implementation of Js.String.startsWith *)

let str = "hello world!"

let startsWith target substring =
  Js.Re.fromString ("^" ^ substring)
    |. Js.Re.test ~str:target

let () = Js.log (str |. startsWith "hello") (* prints "true" *)
```
```reasonml
/* A simple implementation of Js.String.startsWith */

let str = "hello world!";

let startsWith = (target, substring) =>
  Js.Re.fromString("^" ++ substring)->(Js.Re.test(~str=target));

let () = Js.log(str->(startsWith("hello"))); /* prints "true" */
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/RegExp/test](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp/test) MDN