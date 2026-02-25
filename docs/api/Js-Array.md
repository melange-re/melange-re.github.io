
# Module `Js.Array`

Bindings to the functions in `Array.prototype`

JavaScript Array API

```ocaml
type 'a t = 'a array
```
```reasonml
type t('a) = array('a);
```
```ocaml
type 'a array_like = 'a Js.array_like
```
```reasonml
type array_like('a) = Js.array_like('a);
```
```ocaml
val from : 'a array_like -> 'a array
```
```reasonml
let from: array_like('a) => array('a);
```
```ocaml
val fromMap : 'a array_like -> f:('a -> 'b) -> 'b array
```
```reasonml
let fromMap: array_like('a) => f:('a => 'b) => array('b);
```
```ocaml
val isArray : 'a -> bool
```
```reasonml
let isArray: 'a => bool;
```
```ocaml
val length : 'a array -> int
```
```reasonml
let length: array('a) => int;
```
Mutating functions

```ocaml
val copyWithin : to_:int -> ?start:int -> ?end_:int -> 'a t -> 'a t
```
```reasonml
let copyWithin: to_:int => ?start:int => ?end_:int => t('a) => t('a);
```
```ocaml
val fill : value:'a -> ?start:int -> ?end_:int -> 'a t -> 'a t
```
```reasonml
let fill: value:'a => ?start:int => ?end_:int => t('a) => t('a);
```
```ocaml
val flat : 'a t t -> 'a t
```
```reasonml
let flat: t(t('a)) => t('a);
```
```ocaml
val pop : 'a t -> 'a option
```
```reasonml
let pop: t('a) => option('a);
```
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/Array/pop

```ocaml
val push : value:'a -> 'a t -> int
```
```reasonml
let push: value:'a => t('a) => int;
```
```ocaml
val pushMany : values:'a array -> 'a t -> int
```
```reasonml
let pushMany: values:array('a) => t('a) => int;
```
```ocaml
val toReversed : 'a t -> 'a t
```
```reasonml
let toReversed: t('a) => t('a);
```
returns a new array with the elements in reversed order. (ES2023)

```ocaml
val reverseInPlace : 'a t -> 'a t
```
```reasonml
let reverseInPlace: t('a) => t('a);
```
```ocaml
val shift : 'a t -> 'a option
```
```reasonml
let shift: t('a) => option('a);
```
```ocaml
val toSorted : 'a t -> 'a t
```
```reasonml
let toSorted: t('a) => t('a);
```
returns a new array with the elements sorted in ascending order. (ES2023)

```ocaml
val toSortedWith : f:('a -> 'a -> int) -> 'a t -> 'a t
```
```reasonml
let toSortedWith: f:('a => 'a => int) => t('a) => t('a);
```
returns a new array with the elements sorted in ascending order. (ES2023)

```ocaml
val sortInPlace : 'a t -> 'a t
```
```reasonml
let sortInPlace: t('a) => t('a);
```
```ocaml
val sortInPlaceWith : f:('a -> 'a -> int) -> 'a t -> 'a t
```
```reasonml
let sortInPlaceWith: f:('a => 'a => int) => t('a) => t('a);
```
```ocaml
val spliceInPlace : start:int -> remove:int -> add:'a array -> 'a t -> 'a t
```
```reasonml
let spliceInPlace: start:int => remove:int => add:array('a) => t('a) => t('a);
```
changes the contents of the given array by removing or replacing existing elements and/or adding new elements in place. returns a new array containing the removed elements.

```ocaml
val toSpliced : start:int -> remove:int -> add:'a array -> 'a t -> 'a t
```
```reasonml
let toSpliced: start:int => remove:int => add:array('a) => t('a) => t('a);
```
returns a new array with some elements removed and/or replaced at a given index. (ES2023)

```ocaml
val removeFromInPlace : start:int -> 'a t -> 'a t
```
```reasonml
let removeFromInPlace: start:int => t('a) => t('a);
```
removes all elements from the given array starting at the `start` index and returns the removed elements.

```ocaml
val removeFrom : start:int -> 'a t -> 'a t
```
```reasonml
let removeFrom: start:int => t('a) => t('a);
```
returns a new array with elements removed starting at the `start` index. (ES2023)

```ocaml
val removeCountInPlace : start:int -> count:int -> 'a t -> 'a t
```
```reasonml
let removeCountInPlace: start:int => count:int => t('a) => t('a);
```
removes `count` elements from the given array starting at the `start` index and returns the removed elements.

```ocaml
val removeCount : start:int -> count:int -> 'a t -> 'a t
```
```reasonml
let removeCount: start:int => count:int => t('a) => t('a);
```
returns a new array with `count` elements removed starting at the `start` index. (ES2023)

```ocaml
val unshift : value:'a -> 'a t -> int
```
```reasonml
let unshift: value:'a => t('a) => int;
```
```ocaml
val unshiftMany : values:'a array -> 'a t -> int
```
```reasonml
let unshiftMany: values:array('a) => t('a) => int;
```
```ocaml
val concat : other:'a t -> 'a t -> 'a t
```
```reasonml
let concat: other:t('a) => t('a) => t('a);
```
```ocaml
val concatMany : arrays:'a t array -> 'a t -> 'a t
```
```reasonml
let concatMany: arrays:array(t('a)) => t('a) => t('a);
```
```ocaml
val includes : value:'a -> 'a t -> bool
```
```reasonml
let includes: value:'a => t('a) => bool;
```
ES2015

```ocaml
val join : ?sep:string -> 'a t -> string
```
```reasonml
let join: ?sep:string => t('a) => string;
```
Accessor functions

```ocaml
val at : index:int -> 'a t -> 'a option
```
```reasonml
let at: index:int => t('a) => option('a);
```
ES2022

```ocaml
val indexOf : value:'a -> ?start:int -> 'a t -> int
```
```reasonml
let indexOf: value:'a => ?start:int => t('a) => int;
```
```ocaml
val lastIndexOf : value:'a -> 'a t -> int
```
```reasonml
let lastIndexOf: value:'a => t('a) => int;
```
```ocaml
val lastIndexOfFrom : value:'a -> start:int -> 'a t -> int
```
```reasonml
let lastIndexOfFrom: value:'a => start:int => t('a) => int;
```
```ocaml
val copy : 'a t -> 'a t
```
```reasonml
let copy: t('a) => t('a);
```
```ocaml
val slice : ?start:int -> ?end_:int -> 'a t -> 'a t
```
```reasonml
let slice: ?start:int => ?end_:int => t('a) => t('a);
```
```ocaml
val toString : 'a t -> string
```
```reasonml
let toString: t('a) => string;
```
```ocaml
val toLocaleString : 'a t -> string
```
```reasonml
let toLocaleString: t('a) => string;
```
Iteration functions

```ocaml
val entries : 'a t -> (int * 'a) Js.iterator
```
```reasonml
let entries: t('a) => Js.iterator((int, 'a));
```
```ocaml
val every : f:('a -> bool) -> 'a t -> bool
```
```reasonml
let every: f:('a => bool) => t('a) => bool;
```
```ocaml
val everyi : f:('a -> int -> bool) -> 'a t -> bool
```
```reasonml
let everyi: f:('a => int => bool) => t('a) => bool;
```
```ocaml
val filter : f:('a -> bool) -> 'a t -> 'a t
```
```reasonml
let filter: f:('a => bool) => t('a) => t('a);
```
```ocaml
val filteri : f:('a -> int -> bool) -> 'a t -> 'a t
```
```reasonml
let filteri: f:('a => int => bool) => t('a) => t('a);
```
```ocaml
val find : f:('a -> bool) -> 'a t -> 'a option
```
```reasonml
let find: f:('a => bool) => t('a) => option('a);
```
```ocaml
val findi : f:('a -> int -> bool) -> 'a t -> 'a option
```
```reasonml
let findi: f:('a => int => bool) => t('a) => option('a);
```
```ocaml
val findLast : f:('a -> bool) -> 'a t -> 'a option
```
```reasonml
let findLast: f:('a => bool) => t('a) => option('a);
```
```ocaml
val findLasti : f:('a -> int -> bool) -> 'a t -> 'a option
```
```reasonml
let findLasti: f:('a => int => bool) => t('a) => option('a);
```
```ocaml
val findIndex : f:('a -> bool) -> 'a t -> int
```
```reasonml
let findIndex: f:('a => bool) => t('a) => int;
```
```ocaml
val findIndexi : f:('a -> int -> bool) -> 'a t -> int
```
```reasonml
let findIndexi: f:('a => int => bool) => t('a) => int;
```
```ocaml
val findLastIndex : f:('a -> bool) -> 'a t -> int
```
```reasonml
let findLastIndex: f:('a => bool) => t('a) => int;
```
```ocaml
val findLastIndexi : f:('a -> int -> bool) -> 'a t -> int
```
```reasonml
let findLastIndexi: f:('a => int => bool) => t('a) => int;
```
```ocaml
val forEach : f:('a -> unit) -> 'a t -> unit
```
```reasonml
let forEach: f:('a => unit) => t('a) => unit;
```
```ocaml
val forEachi : f:('a -> int -> unit) -> 'a t -> unit
```
```reasonml
let forEachi: f:('a => int => unit) => t('a) => unit;
```
```ocaml
val keys : 'a t -> int Js.iterator
```
```reasonml
let keys: t('a) => Js.iterator(int);
```
```ocaml
val map : f:('a -> 'b) -> 'a t -> 'b t
```
```reasonml
let map: f:('a => 'b) => t('a) => t('b);
```
```ocaml
val mapi : f:('a -> int -> 'b) -> 'a t -> 'b t
```
```reasonml
let mapi: f:('a => int => 'b) => t('a) => t('b);
```
```ocaml
val reduce : f:('b -> 'a -> 'b) -> init:'b -> 'a t -> 'b
```
```reasonml
let reduce: f:('b => 'a => 'b) => init:'b => t('a) => 'b;
```
```ocaml
val reducei : f:('b -> 'a -> int -> 'b) -> init:'b -> 'a t -> 'b
```
```reasonml
let reducei: f:('b => 'a => int => 'b) => init:'b => t('a) => 'b;
```
```ocaml
val reduceRight : f:('b -> 'a -> 'b) -> init:'b -> 'a t -> 'b
```
```reasonml
let reduceRight: f:('b => 'a => 'b) => init:'b => t('a) => 'b;
```
```ocaml
val reduceRighti : f:('b -> 'a -> int -> 'b) -> init:'b -> 'a t -> 'b
```
```reasonml
let reduceRighti: f:('b => 'a => int => 'b) => init:'b => t('a) => 'b;
```
```ocaml
val some : f:('a -> bool) -> 'a t -> bool
```
```reasonml
let some: f:('a => bool) => t('a) => bool;
```
```ocaml
val somei : f:('a -> int -> bool) -> 'a t -> bool
```
```reasonml
let somei: f:('a => int => bool) => t('a) => bool;
```
```ocaml
val values : 'a t -> 'a Js.iterator
```
```reasonml
let values: t('a) => Js.iterator('a);
```
```ocaml
val unsafe_get : 'a array -> int -> 'a
```
```reasonml
let unsafe_get: array('a) => int => 'a;
```
```ocaml
val unsafe_set : 'a array -> int -> 'a -> unit
```
```reasonml
let unsafe_set: array('a) => int => 'a => unit;
```