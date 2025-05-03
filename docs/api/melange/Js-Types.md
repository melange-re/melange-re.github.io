
# Module `Js.Types`

Utility functions for runtime reflection on JS types

```
type symbol
```
Js symbol type only available in ES6

```
type bigint_val
```
Js bigint type only available in ES2020

```
type obj_val
```
```
type undefined_val
```
This type has only one value `undefined`

```
type null_val
```
This type has only one value `null`

```
type function_val
```
```
type _ t = 
```
```
| Undefined : undefined_val t
```
```
| Null : null_val t
```
```
| Boolean : bool t
```
```
| Number : float t
```
```
| String : string t
```
```
| Function : function_val t
```
```
| Object : obj_val t
```
```
| Symbol : symbol t
```
```
| BigInt : bigint_val t
```
```

```
```
val test : 'a -> 'b t -> bool
```
```ocaml
test "x" String = true
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
```
| JSNumber of float
```
```
| JSString of string
```
```
| JSFunction of function_val
```
```
| JSObject of obj_val
```
```
| JSSymbol of symbol
```
```
| JSBigInt of bigint_val
```
```

```
```
val classify : 'a -> tagged_t
```