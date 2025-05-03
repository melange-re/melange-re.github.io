
# Module `Js.Json`

Utility functions to manipulate JSON values

Efficient JSON encoding using JavaScript API @see \<https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/JSON\> MDN


### Types

```
type t
```
The JSON data structure

```
type _ kind = 
```
```
| String : string kind
```
```
| Number : float kind
```
```
| Object : t Js.dict kind
```
```
| Array : t array kind
```
```
| Boolean : bool kind
```
```
| Null : t Js.null kind
```
```

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
```
| JSONString of string
```
```
| JSONNumber of float
```
```
| JSONObject of t Js.dict
```
```
| JSONArray of t array
```
```

```

### Accessor

```
val classify : t -> tagged_t
```
```
val test : 'a -> 'b kind -> bool
```
`test v kind` returns true if `v` is of `kind`

```
val decodeString : t -> string option
```
`decodeString json` returns `Some s` if `json` is a string, `None` otherwise

```
val decodeNumber : t -> float option
```
`decodeNumber json` returns `Some n` if `json` is a number, `None` otherwise

```
val decodeObject : t -> t Js.dict option
```
`decodeObject json` returns `Some o` if `json` is an object, `None` otherwise

```
val decodeArray : t -> t array option
```
`decodeArray json` returns `Some a` if `json` is an array, `None` otherwise

```
val decodeBoolean : t -> bool option
```
`decodeBoolean json` returns `Some b` if `json` is a boolean, `None` otherwise

```
val decodeNull : t -> 'a Js.null option
```
`decodeNull json` returns `Some null` if `json` is a null, `None` otherwise


### Construtors

Those functions allows the construction of an arbitrary complex JSON values.

```
val null : t
```
`null` is the singleton null JSON value

```
val string : string -> t
```
`string s` makes a JSON string of the `string` `s`

```
val number : float -> t
```
`number n` makes a JSON number of the `float` `n`

```
val boolean : bool -> t
```
`boolean b` makes a JSON boolean of the `bool` `b`

```
val object_ : t Js.dict -> t
```
`object_ dict` makes a JSON object of the `Js.dict` `dict`

```
val array : t array -> t
```
`array a` makes a JSON array of the `Js.Json.t array` `a`

The functions below are specialized for specific array type which happened to be already JSON object in the Melange runtime. Therefore they are more efficient (constant time rather than linear conversion).

```
val stringArray : string array -> t
```
`stringArray a` makes a JSON array of the `string array` `a`

```
val numberArray : float array -> t
```
`numberArray a` makes a JSON array of the `float array` `a`

```
val booleanArray : bool array -> t
```
`booleanArray` makes a JSON array of the `bool array` `a`

```
val objectArray : t Js.dict array -> t
```
`objectArray a` makes a JSON array of the `JsDict.t array` `a`


### String conversion

```
val parseExn : string -> t
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
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/JSON/parse](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/parse) MDN
```
val stringify : t -> string
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
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/JSON/stringify](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify) MDN
```
val stringifyWithSpace : t -> int -> string
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
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/JSON/stringify](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify) MDN
```
val stringifyAny : 'a -> string option
```
`stringifyAny value` formats any `value` into a JSON string

```ocaml
  (* prints ``"foo", "bar"`` *)
  Js.log (Js.Json.stringifyAny [| "foo"; "bar" |])
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/JSON/stringify](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify) MDN
Best-effort serialization, it tries to seralize as many objects as possible and deserialize it back

```
val deserializeUnsafe : string -> 'a
```
It is unsafe in two aspects

- It may throw during parsing
- when you cast it to a specific type, it may have a type mismatch
```
val serializeExn : 'a -> string
```
It will raise in such situations:

- The object can not be serlialized to a JSON
- There are cycles
- Some JS engines can not stringify deeply nested json objects