
# Module `Js.Types`

Utility functions for runtime reflection on JS types

```ocaml
type symbol
```
```reasonml
type symbol;
```
Js symbol type only available in ES6

```ocaml
type bigint_val
```
```reasonml
type bigint_val;
```
Js bigint type only available in ES2020

```ocaml
type obj_val
```
```reasonml
type obj_val;
```
```ocaml
type undefined_val
```
```reasonml
type undefined_val;
```
This type has only one value `undefined`

```ocaml
type null_val
```
```reasonml
type null_val;
```
This type has only one value `null`

```ocaml
type function_val
```
```reasonml
type function_val;
```
```ocaml
type _ t = 
```
```reasonml
type t(_) = 
```
```ocaml
| Undefined : undefined_val t
```
```reasonml
| Undefined : t(undefined_val)
```
```ocaml
| Null : null_val t
```
```reasonml
| Null : t(null_val)
```
```ocaml
| Boolean : bool t
```
```reasonml
| Boolean : t(bool)
```
```ocaml
| Number : float t
```
```reasonml
| Number : t(float)
```
```ocaml
| String : string t
```
```reasonml
| String : t(string)
```
```ocaml
| Function : function_val t
```
```reasonml
| Function : t(function_val)
```
```ocaml
| Object : obj_val t
```
```reasonml
| Object : t(obj_val)
```
```ocaml
| Symbol : symbol t
```
```reasonml
| Symbol : t(symbol)
```
```ocaml
| BigInt : bigint_val t
```
```reasonml
| BigInt : t(bigint_val)
```
```ocaml

```
```reasonml
;
```
```ocaml
val test : 'a -> 'b t -> bool
```
```reasonml
let test: 'a => t('b) => bool;
```
```ocaml
test "x" String = true
```
```reasonml
test("x", String) == true;
```
```
type tagged_t = 
```
```
| JSFalse
```
```
| JSTrue
```
```
| JSNull
```
```
| JSUndefined
```
```ocaml
| JSNumber of float
```
```reasonml
| JSNumber(float)
```
```ocaml
| JSString of string
```
```reasonml
| JSString(string)
```
```ocaml
| JSFunction of function_val
```
```reasonml
| JSFunction(function_val)
```
```ocaml
| JSObject of obj_val
```
```reasonml
| JSObject(obj_val)
```
```ocaml
| JSSymbol of symbol
```
```reasonml
| JSSymbol(symbol)
```
```ocaml
| JSBigInt of bigint_val
```
```reasonml
| JSBigInt(bigint_val)
```
```ocaml

```
```reasonml
;
```
```ocaml
val classify : 'a -> tagged_t
```
```reasonml
let classify: 'a => tagged_t;
```