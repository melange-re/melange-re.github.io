
# Module `Js.Json`

Utility functions to manipulate JSON values

Efficient JSON encoding using JavaScript API @see \<https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/JSON\> MDN


### Types

```ocaml
type t
```
```reasonml
type t;
```
The JSON data structure

```ocaml
type _ kind = 
```
```reasonml
type kind(_) = 
```
```ocaml
| String : string kind
```
```reasonml
| String : kind(string)
```
```ocaml
| Number : float kind
```
```reasonml
| Number : kind(float)
```
```ocaml
| Object : t Js.dict kind
```
```reasonml
| Object : kind(Js.dict(t))
```
```ocaml
| Array : t array kind
```
```reasonml
| Array : kind(array(t))
```
```ocaml
| Boolean : bool kind
```
```reasonml
| Boolean : kind(bool)
```
```ocaml
| Null : t Js.null kind
```
```reasonml
| Null : kind(Js.null(t))
```
```ocaml

```
```reasonml
;
```
Underlying type of a JSON value

```
type tagged_t = 
```
```
| JSONFalse
```
```
| JSONTrue
```
```
| JSONNull
```
```ocaml
| JSONString of string
```
```reasonml
| JSONString(string)
```
```ocaml
| JSONNumber of float
```
```reasonml
| JSONNumber(float)
```
```ocaml
| JSONObject of t Js.dict
```
```reasonml
| JSONObject(Js.dict(t))
```
```ocaml
| JSONArray of t array
```
```reasonml
| JSONArray(array(t))
```
```ocaml

```
```reasonml
;
```

### Accessor

```ocaml
val classify : t -> tagged_t
```
```reasonml
let classify: t => tagged_t;
```
```ocaml
val test : 'a -> 'b kind -> bool
```
```reasonml
let test: 'a => kind('b) => bool;
```
`test v kind` returns true if `v` is of `kind`

```ocaml
val decodeString : t -> string option
```
```reasonml
let decodeString: t => option(string);
```
`decodeString json` returns `Some s` if `json` is a string, `None` otherwise

```ocaml
val decodeNumber : t -> float option
```
```reasonml
let decodeNumber: t => option(float);
```
`decodeNumber json` returns `Some n` if `json` is a number, `None` otherwise

```ocaml
val decodeObject : t -> t Js.dict option
```
```reasonml
let decodeObject: t => option(Js.dict(t));
```
`decodeObject json` returns `Some o` if `json` is an object, `None` otherwise

```ocaml
val decodeArray : t -> t array option
```
```reasonml
let decodeArray: t => option(array(t));
```
`decodeArray json` returns `Some a` if `json` is an array, `None` otherwise

```ocaml
val decodeBoolean : t -> bool option
```
```reasonml
let decodeBoolean: t => option(bool);
```
`decodeBoolean json` returns `Some b` if `json` is a boolean, `None` otherwise

```ocaml
val decodeNull : t -> 'a Js.null option
```
```reasonml
let decodeNull: t => option(Js.null('a));
```
`decodeNull json` returns `Some null` if `json` is a null, `None` otherwise


### Construtors

Those functions allows the construction of an arbitrary complex JSON values.

```ocaml
val null : t
```
```reasonml
let null: t;
```
`null` is the singleton null JSON value

```ocaml
val string : string -> t
```
```reasonml
let string: string => t;
```
`string s` makes a JSON string of the `string` `s`

```ocaml
val number : float -> t
```
```reasonml
let number: float => t;
```
`number n` makes a JSON number of the `float` `n`

```ocaml
val boolean : bool -> t
```
```reasonml
let boolean: bool => t;
```
`boolean b` makes a JSON boolean of the `bool` `b`

```ocaml
val object_ : t Js.dict -> t
```
```reasonml
let object_: Js.dict(t) => t;
```
`object_ dict` makes a JSON object of the `Js.dict` `dict`

```ocaml
val array : t array -> t
```
```reasonml
let array: array(t) => t;
```
`array a` makes a JSON array of the `Js.Json.t array` `a`

The functions below are specialized for specific array type which happened to be already JSON object in the Melange runtime. Therefore they are more efficient (constant time rather than linear conversion).

```ocaml
val stringArray : string array -> t
```
```reasonml
let stringArray: array(string) => t;
```
`stringArray a` makes a JSON array of the `string array` `a`

```ocaml
val numberArray : float array -> t
```
```reasonml
let numberArray: array(float) => t;
```
`numberArray a` makes a JSON array of the `float array` `a`

```ocaml
val booleanArray : bool array -> t
```
```reasonml
let booleanArray: array(bool) => t;
```
`booleanArray` makes a JSON array of the `bool array` `a`

```ocaml
val objectArray : t Js.dict array -> t
```
```reasonml
let objectArray: array(Js.dict(t)) => t;
```
`objectArray a` makes a JSON array of the `JsDict.t array` `a`


### String conversion

```ocaml
val parseExn : string -> t
```
```reasonml
let parseExn: string => t;
```
`parseExn s` parses the string `s` into a JSON data structure

**Returns** a JSON data structure

raises `SyntaxError` if given string is not a valid JSON. Note SyntaxError is a JavaScript exception.
```ocaml
(* parse a simple JSON string *)

let json =
  try
    Js.Json.parseExn {| "foo" |}
  with
  | _ -> failwith "Error parsing JSON string"
in
match Js.Json.classify json with
| Js.Json.JSONString value -> Js.log value
| _ -> failwith "Expected a string"
```
```reasonml
/* parse a simple JSON string */

{
  let json =
    try(Js.Json.parseExn({| "foo" |})) {
    | _ => failwith("Error parsing JSON string")
    };

  switch (Js.Json.classify(json)) {
  | Js.Json.JSONString(value) => Js.log(value)
  | _ => failwith("Expected a string")
  };
};
```
```ocaml
(* parse a complex JSON string *)

let getIds s =
  let json =
    try
      Js.Json.parseExn s
    with
    | _ -> failwith "Error parsing JSON string"
  in
  match Js.Json.classify json with
  | Js.Json.JSONObject value ->
    (* In this branch, compiler infer value : Js.Json.t Js.dict *)
    begin match Js.Dict.get value "ids" with
    | Some ids ->
      begin match Js.Json.classify ids with
      | Js.Json.JSONArray ids ->
        (* In this branch compiler infer ids : Js.Json.t array *)
        ids
      | _ -> failwith "Expected an array"
      end
    | None -> failwith "Expected an `ids` property"
    end
  | _ -> failwith "Expected an object"

  (* prints `1, 2, 3` *)
  let _ =
    Js.log (getIds {| { "ids" : [1, 2, 3] } |})
```
```reasonml
/* parse a complex JSON string */

let getIds = s => {
  let json =
    try(Js.Json.parseExn(s)) {
    | _ => failwith("Error parsing JSON string")
    };

  switch (Js.Json.classify(json)) {
  | Js.Json.JSONObject(value) =>
    /* In this branch, compiler infer value : Js.Json.t Js.dict */
    switch (Js.Dict.get(value, "ids")) {
    | Some(ids) =>
      switch (Js.Json.classify(ids)) {
      | Js.Json.JSONArray(ids) =>
        /* In this branch compiler infer ids : Js.Json.t array */
        ids
      | _ => failwith("Expected an array")
      }
    | None => failwith("Expected an `ids` property")
    }
  | _ => failwith("Expected an object")
  };
};

/* prints `1, 2, 3` */
let _ = Js.log(getIds({| { "ids" : [1, 2, 3] } |}));
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/JSON/parse](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/parse) MDN
```ocaml
val stringify : t -> string
```
```reasonml
let stringify: t => string;
```
`stringify json` formats the JSON data structure as a string

**Returns** the string representation of a given JSON data structure

```ocaml
(* Creates and stringifies a simple JS object *)

let dict = Js.Dict.empty () in
Js.Dict.set dict "name" (Js.Json.string "John Doe");
Js.Dict.set dict "age" (Js.Json.number 30.0);
Js.Dict.set dict "likes"
  (Js.Json.stringArray [|"bucklescript";"ocaml";"js"|]);

Js.log (Js.Json.stringify (Js.Json.object_ dict))
```
```reasonml
/* Creates and stringifies a simple JS object */

{
  let dict = Js.Dict.empty();
  Js.Dict.set(dict, "name", Js.Json.string("John Doe"));
  Js.Dict.set(dict, "age", Js.Json.number(30.0));
  Js.Dict.set(
    dict,
    "likes",
    Js.Json.stringArray([|"bucklescript", "ocaml", "js"|]),
  );

  Js.log(Js.Json.stringify(Js.Json.object_(dict)));
};
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/JSON/stringify](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify) MDN
```ocaml
val stringifyWithSpace : t -> int -> string
```
```reasonml
let stringifyWithSpace: t => int => string;
```
`stringify json` formats the JSON data structure as a string

**Returns** the string representation of a given JSON data structure

```ocaml
(* Creates and stringifies a simple JS object with spacing *)

let dict = Js.Dict.empty () in
Js.Dict.set dict "name" (Js.Json.string "John Doe");
Js.Dict.set dict "age" (Js.Json.number 30.0);
Js.Dict.set dict "likes"
  (Js.Json.stringArray [|"bucklescript";"ocaml";"js"|]);

  Js.log (Js.Json.stringifyWithSpace (Js.Json.object_ dict) 2)
```
```reasonml
/* Creates and stringifies a simple JS object with spacing */

{
  let dict = Js.Dict.empty();
  Js.Dict.set(dict, "name", Js.Json.string("John Doe"));
  Js.Dict.set(dict, "age", Js.Json.number(30.0));
  Js.Dict.set(
    dict,
    "likes",
    Js.Json.stringArray([|"bucklescript", "ocaml", "js"|]),
  );

  Js.log(Js.Json.stringifyWithSpace(Js.Json.object_(dict), 2));
};
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/JSON/stringify](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify) MDN
```ocaml
val stringifyAny : 'a -> string option
```
```reasonml
let stringifyAny: 'a => option(string);
```
`stringifyAny value` formats any `value` into a JSON string

```ocaml
  (* prints ``"foo", "bar"`` *)
  Js.log (Js.Json.stringifyAny [| "foo"; "bar" |])
```
```reasonml
/* prints ``"foo", "bar"`` */
Js.log(Js.Json.stringifyAny([|"foo", "bar"|]));
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/JSON/stringify](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify) MDN
Best-effort serialization, it tries to seralize as many objects as possible and deserialize it back

```ocaml
val deserializeUnsafe : string -> 'a
```
```reasonml
let deserializeUnsafe: string => 'a;
```
It is unsafe in two aspects

- It may throw during parsing
- when you cast it to a specific type, it may have a type mismatch
```ocaml
val serializeExn : 'a -> string
```
```reasonml
let serializeExn: 'a => string;
```
It will raise in such situations:

- The object can not be serlialized to a JSON
- There are cycles
- Some JS engines can not stringify deeply nested json objects