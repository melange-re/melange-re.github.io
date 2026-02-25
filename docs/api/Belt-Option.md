
# Module `Belt.Option`

[`Belt.Option`](#)

Utilities for option data type.

[`Belt.Option`](#)

Utilities for option data type

```ocaml
val keepU : 'a option -> ('a -> bool) Js.Fn.arity1 -> 'a option
```
```reasonml
let keepU: option('a) => Js.Fn.arity1(('a => bool)) => option('a);
```
Uncurried version of `keep`

```ocaml
val keep : 'a option -> ('a -> bool) -> 'a option
```
```reasonml
let keep: option('a) => ('a => bool) => option('a);
```
`keep optionValue p`

If `optionValue` is `Some value` and `p value = true`, it returns `Some value`; otherwise returns `None`

```ocaml
  keep (Some 10)(fun x -> x > 5);; (* returns [Some 10] *)
  keep (Some 4)(fun x -> x > 5);; (* returns [None] *)
  keep None (fun x -> x > 5);; (* returns [None] *)
```
```reasonml
keep(Some(10), x => x > 5); /* returns [Some 10] */
keep(Some(4), x => x > 5); /* returns [None] */
keep(None, x => x > 5); /* returns [None] */
```
```ocaml
val forEachU : 'a option -> ('a -> unit) Js.Fn.arity1 -> unit
```
```reasonml
let forEachU: option('a) => Js.Fn.arity1(('a => unit)) => unit;
```
Uncurried version of `forEach`

```ocaml
val forEach : 'a option -> ('a -> unit) -> unit
```
```reasonml
let forEach: option('a) => ('a => unit) => unit;
```
`forEach optionValue f`

If `optionValue` is `Some value`, it calls `f value`; otherwise returns `()`

```ocaml
  forEach (Some "thing")(fun x -> Js.log x);; (* logs "thing" *)
  forEach None (fun x -> Js.log x);; (* returns () *)
```
```reasonml
forEach(Some("thing"), x => Js.log(x)); /* logs "thing" */
forEach(None, x => Js.log(x)); /* returns () */
```
```ocaml
val getExn : 'a option -> 'a
```
```reasonml
let getExn: option('a) => 'a;
```
`getExn optionalValue` Returns `value` if `optionalValue` is `Some value`, otherwise raises `getExn`

```ocaml
  getExn (Some 3) = 3;;
  getExn None (* Raises getExn error *)
```
```reasonml
getExn(Some(3)) == 3;
getExn(None); /* Raises getExn error */
```
```ocaml
val getUnsafe : 'a option -> 'a
```
```reasonml
let getUnsafe: option('a) => 'a;
```
`getUnsafe x` returns x This is an unsafe operation, it assumes x is neither not None or (Some (None .. ))

```ocaml
val mapWithDefaultU : 'a option -> 'b -> ('a -> 'b) Js.Fn.arity1 -> 'b
```
```reasonml
let mapWithDefaultU: option('a) => 'b => Js.Fn.arity1(('a => 'b)) => 'b;
```
Uncurried version of `mapWithDefault`

```ocaml
val mapWithDefault : 'a option -> 'b -> ('a -> 'b) -> 'b
```
```reasonml
let mapWithDefault: option('a) => 'b => ('a => 'b) => 'b;
```
`mapWithDefault optionValue default f`

If `optionValue` is `Some value`, returns `f value`; otherwise returns `default`

```ocaml
  mapWithDefault (Some 3) 0 (fun x -> x + 5) = 8;;
  mapWithDefault None 0 (fun x -> x + 5) = 0;;
```
```reasonml
mapWithDefault(Some(3), 0, x => x + 5) == 8;
mapWithDefault(None, 0, x => x + 5) == 0;
```
```ocaml
val mapU : 'a option -> ('a -> 'b) Js.Fn.arity1 -> 'b option
```
```reasonml
let mapU: option('a) => Js.Fn.arity1(('a => 'b)) => option('b);
```
Uncurried version of `map`

```ocaml
val map : 'a option -> ('a -> 'b) -> 'b option
```
```reasonml
let map: option('a) => ('a => 'b) => option('b);
```
`map optionValue f`

If `optionValue` is `Some value`, returns `Some (f value)`; otherwise returns `None`

```ocaml
  map (Some 3) (fun x -> x * x) = (Some 9);;
  map None (fun x -> x * x) = None;;
```
```reasonml
map(Some(3), x => x * x) == Some(9);
map(None, x => x * x) == None;
```
```ocaml
val flatMapU : 'a option -> ('a -> 'b option) Js.Fn.arity1 -> 'b option
```
```reasonml
let flatMapU: option('a) => Js.Fn.arity1(('a => option('b))) => option('b);
```
Uncurried version of `flatMap`

```ocaml
val flatMap : 'a option -> ('a -> 'b option) -> 'b option
```
```reasonml
let flatMap: option('a) => ('a => option('b)) => option('b);
```
`flatMap optionValue f`

If `optionValue` is `Some value`, returns `f value`; otherwise returns `None` The function `f` must have a return type of <code class="text-ocaml">'a option</code><code class="text-reasonml">option('a)</code>

```ocaml
  let f (x : float) =
      if x >= 0.0 then
        Some (sqrt x)
      else
        None;;

  flatMap (Some 4.0) f = Some 2.0;;
  flatMap (Some (-4.0)) f = None;;
  flatMap None f = None;;
```
```reasonml
let f = (x: float) =>
  if (x >= 0.0) {
    Some(sqrt(x));
  } else {
    None;
  };

flatMap(Some(4.0), f) == Some(2.0);
flatMap(Some(-4.0), f) == None;
flatMap(None, f) == None;
```
```ocaml
val getWithDefault : 'a option -> 'a -> 'a
```
```reasonml
let getWithDefault: option('a) => 'a => 'a;
```
`getWithDefault optionalValue default`

If `optionalValue` is `Some value`, returns `value`, otherwise `default`

```ocaml
  getWithDefault (Some 1812) 1066 = 1812;;
  getWithDefault None 1066 = 1066;;
```
```reasonml
getWithDefault(Some(1812), 1066) == 1812;
getWithDefault(None, 1066) == 1066;
```
```ocaml
val orElse : 'a option -> 'a option -> 'a option
```
```reasonml
let orElse: option('a) => option('a) => option('a);
```
`orElse optionalValue otherOptional`

If `optionalValue` is `Some value`, returns `Some value`, otherwise `otherOptional`

```ocaml
  orElse (Some 1812) (Some 1066) = Some 1812;;
  orElse None (Some 1066) = Some 1066;;
  orElse None None = None;;
```
```reasonml
orElse(Some(1812), Some(1066)) == Some(1812);
orElse(None, Some(1066)) == Some(1066);
orElse(None, None) == None;
```
```ocaml
val isSome : 'a option -> bool
```
```reasonml
let isSome: option('a) => bool;
```
Returns `true` if the argument is `Some value`, `false` otherwise

```ocaml
val isNone : 'a option -> bool
```
```reasonml
let isNone: option('a) => bool;
```
Returns `true` if the argument is `None`, `false` otherwise

```ocaml
val eqU : 'a option -> 'b option -> ('a -> 'b -> bool) Js.Fn.arity2 -> bool
```
```reasonml
let eqU: option('a) => option('b) => Js.Fn.arity2(('a => 'b => bool)) => bool;
```
Uncurried version of `eq`

```ocaml
val eq : 'a option -> 'b option -> ('a -> 'b -> bool) -> bool
```
```reasonml
let eq: option('a) => option('b) => ('a => 'b => bool) => bool;
```
`eq optValue1 optvalue2 predicate`

Evaluates two optional values for equality with respect to a predicate function.

If both `optValue1` and `optValue2` are `None`, returns `true`.

If one of the arguments is `Some value` and the other is `None`, returns `false`

If arguments are `Some value1` and `Some value2`, returns the result of `predicate value1 value2`; the `predicate` function must return a `bool`

```ocaml
  let clockEqual = (fun a b -> a mod 12 = b mod 12);;
  eq (Some 3) (Some 15) clockEqual = true;;
  eq (Some 3) None clockEqual = false;;
  eq None (Some 3) clockEqual = false;;
  eq None None clockEqual = true;;
```
```reasonml
let clockEqual = (a, b) => a mod 12 == b mod 12;
eq(Some(3), Some(15), clockEqual) == true;
eq(Some(3), None, clockEqual) == false;
eq(None, Some(3), clockEqual) == false;
eq(None, None, clockEqual) == true;
```
```ocaml
val cmpU : 'a option -> 'b option -> ('a -> 'b -> int) Js.Fn.arity2 -> int
```
```reasonml
let cmpU: option('a) => option('b) => Js.Fn.arity2(('a => 'b => int)) => int;
```
Uncurried version of `cmp`

```ocaml
val cmp : 'a option -> 'b option -> ('a -> 'b -> int) -> int
```
```reasonml
let cmp: option('a) => option('b) => ('a => 'b => int) => int;
```
`cmp optValue1 optvalue2 comparisonFcn`

Compares two optional values with respect to a comparison function

If both `optValue1` and `optValue2` are `None`, returns 0\.

If the first argument is `Some value1` and the second is `None`, returns 1 (something is greater than nothing)

If the first argument is `None` and the second is `Some value2`, returns \-1 (nothing is less than something)

If the arguments are `Some value1` and `Some value2`, returns the result of `comparisonFcn value1 value2`; `comparisonFcn` takes two arguments and returns \-1 if the first argument is less than the second, 0 if the arguments are equal, and 1 if the first argument is greater than the second.

```ocaml
  let clockCompare = fun a b -> compare (a mod 12) (b mod 12);;
  cmp (Some 3) (Some 15) clockCompare = 0;;
  cmp (Some 3) (Some 14) clockCompare = 1;;
  cmp (Some 2) (Some 15) clockCompare = -1;;
  cmp None (Some 15) clockCompare = -1;;
  cmp (Some 14) None clockCompare = 1;;
  cmp None None clockCompare = 0;;
```
```reasonml
let clockCompare = (a, b) => compare(a mod 12, b mod 12);
cmp(Some(3), Some(15), clockCompare) == 0;
cmp(Some(3), Some(14), clockCompare) == 1;
cmp(Some(2), Some(15), clockCompare) == (-1);
cmp(None, Some(15), clockCompare) == (-1);
cmp(Some(14), None, clockCompare) == 1;
cmp(None, None, clockCompare) == 0;
```