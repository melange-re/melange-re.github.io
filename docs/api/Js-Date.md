
# Module `Js.Date`

Bindings to the functions in JS's `Date.prototype`

JavaScript Date API

```ocaml
type t
```
```reasonml
type t;
```
```ocaml
val valueOf : t -> float
```
```reasonml
let valueOf: t => float;
```
returns the primitive value of this date, equivalent to getTime

```ocaml
val fromFloat : float -> t
```
```reasonml
let fromFloat: float => t;
```
```ocaml
val fromString : string -> t
```
```reasonml
let fromString: string => t;
```
```ocaml
val make : 
  ?year:float ->
  ?month:float ->
  ?date:float ->
  ?hours:float ->
  ?minutes:float ->
  ?seconds:float ->
  unit ->
  t
```
```reasonml
let make: 
  ?year:float =>
  ?month:float =>
  ?date:float =>
  ?hours:float =>
  ?minutes:float =>
  ?seconds:float =>
  unit =>
  t;
```
`make ()` returns a date representing the current time.

```ocaml
val utc : 
  year:float ->
  ?month:float ->
  ?date:float ->
  ?hours:float ->
  ?minutes:float ->
  ?seconds:float ->
  unit ->
  float
```
```reasonml
let utc: 
  year:float =>
  ?month:float =>
  ?date:float =>
  ?hours:float =>
  ?minutes:float =>
  ?seconds:float =>
  unit =>
  float;
```
```ocaml
val now : unit -> float
```
```reasonml
let now: unit => float;
```
returns the number of milliseconds since Unix epoch

```ocaml
val parseAsFloat : string -> float
```
```reasonml
let parseAsFloat: string => float;
```
returns NaN if passed invalid date string

```ocaml
val getDate : t -> float
```
```reasonml
let getDate: t => float;
```
return the day of the month (1-31)

```ocaml
val getDay : t -> float
```
```reasonml
let getDay: t => float;
```
returns the day of the week (0-6)

```ocaml
val getFullYear : t -> float
```
```reasonml
let getFullYear: t => float;
```
```ocaml
val getHours : t -> float
```
```reasonml
let getHours: t => float;
```
```ocaml
val getMilliseconds : t -> float
```
```reasonml
let getMilliseconds: t => float;
```
```ocaml
val getMinutes : t -> float
```
```reasonml
let getMinutes: t => float;
```
```ocaml
val getMonth : t -> float
```
```reasonml
let getMonth: t => float;
```
returns the month (0-11)

```ocaml
val getSeconds : t -> float
```
```reasonml
let getSeconds: t => float;
```
```ocaml
val getTime : t -> float
```
```reasonml
let getTime: t => float;
```
returns the number of milliseconds since Unix epoch

```ocaml
val getTimezoneOffset : t -> float
```
```reasonml
let getTimezoneOffset: t => float;
```
```ocaml
val getUTCDate : t -> float
```
```reasonml
let getUTCDate: t => float;
```
return the day of the month (1-31)

```ocaml
val getUTCDay : t -> float
```
```reasonml
let getUTCDay: t => float;
```
returns the day of the week (0-6)

```ocaml
val getUTCFullYear : t -> float
```
```reasonml
let getUTCFullYear: t => float;
```
```ocaml
val getUTCHours : t -> float
```
```reasonml
let getUTCHours: t => float;
```
```ocaml
val getUTCMilliseconds : t -> float
```
```reasonml
let getUTCMilliseconds: t => float;
```
```ocaml
val getUTCMinutes : t -> float
```
```reasonml
let getUTCMinutes: t => float;
```
```ocaml
val getUTCMonth : t -> float
```
```reasonml
let getUTCMonth: t => float;
```
returns the month (0-11)

```ocaml
val getUTCSeconds : t -> float
```
```reasonml
let getUTCSeconds: t => float;
```
```ocaml
val setDate : date:float -> t -> float
```
```reasonml
let setDate: date:float => t => float;
```
```ocaml
val setFullYear : year:float -> ?month:float -> ?date:float -> t -> float
```
```reasonml
let setFullYear: year:float => ?month:float => ?date:float => t => float;
```
```ocaml
val setHours : 
  hours:float ->
  ?minutes:float ->
  ?seconds:float ->
  ?milliseconds:float ->
  t ->
  float
```
```reasonml
let setHours: 
  hours:float =>
  ?minutes:float =>
  ?seconds:float =>
  ?milliseconds:float =>
  t =>
  float;
```
```ocaml
val setMilliseconds : milliseconds:float -> t -> float
```
```reasonml
let setMilliseconds: milliseconds:float => t => float;
```
```ocaml
val setMinutes : 
  minutes:float ->
  ?seconds:float ->
  ?milliseconds:float ->
  t ->
  float
```
```reasonml
let setMinutes: 
  minutes:float =>
  ?seconds:float =>
  ?milliseconds:float =>
  t =>
  float;
```
```ocaml
val setMonth : month:float -> ?date:float -> t -> float
```
```reasonml
let setMonth: month:float => ?date:float => t => float;
```
```ocaml
val setSeconds : seconds:float -> ?milliseconds:float -> t -> float
```
```reasonml
let setSeconds: seconds:float => ?milliseconds:float => t => float;
```
```ocaml
val setTime : time:float -> t -> float
```
```reasonml
let setTime: time:float => t => float;
```
```ocaml
val setUTCDate : date:float -> t -> float
```
```reasonml
let setUTCDate: date:float => t => float;
```
```ocaml
val setUTCFullYear : year:float -> ?month:float -> ?date:float -> t -> float
```
```reasonml
let setUTCFullYear: year:float => ?month:float => ?date:float => t => float;
```
```ocaml
val setUTCHours : 
  hours:float ->
  ?minutes:float ->
  ?seconds:float ->
  ?milliseconds:float ->
  t ->
  float
```
```reasonml
let setUTCHours: 
  hours:float =>
  ?minutes:float =>
  ?seconds:float =>
  ?milliseconds:float =>
  t =>
  float;
```
```ocaml
val setUTCMilliseconds : milliseconds:float -> t -> float
```
```reasonml
let setUTCMilliseconds: milliseconds:float => t => float;
```
```ocaml
val setUTCMinutes : 
  minutes:float ->
  ?seconds:float ->
  ?milliseconds:float ->
  t ->
  float
```
```reasonml
let setUTCMinutes: 
  minutes:float =>
  ?seconds:float =>
  ?milliseconds:float =>
  t =>
  float;
```
```ocaml
val setUTCMonth : month:float -> ?date:float -> t -> float
```
```reasonml
let setUTCMonth: month:float => ?date:float => t => float;
```
```ocaml
val setUTCSeconds : seconds:float -> ?milliseconds:float -> t -> float
```
```reasonml
let setUTCSeconds: seconds:float => ?milliseconds:float => t => float;
```
```ocaml
val setUTCTime : time:float -> t -> float
```
```reasonml
let setUTCTime: time:float => t => float;
```
```ocaml
val toDateString : t -> string
```
```reasonml
let toDateString: t => string;
```
```ocaml
val toISOString : t -> string
```
```reasonml
let toISOString: t => string;
```
```ocaml
val toJSON : t -> string option
```
```reasonml
let toJSON: t => option(string);
```
```ocaml
val toJSONUnsafe : t -> string
```
```reasonml
let toJSONUnsafe: t => string;
```
```ocaml
val toLocaleDateString : t -> string
```
```reasonml
let toLocaleDateString: t => string;
```
```ocaml
val toLocaleString : t -> string
```
```reasonml
let toLocaleString: t => string;
```
```ocaml
val toLocaleTimeString : t -> string
```
```reasonml
let toLocaleTimeString: t => string;
```
```ocaml
val toString : t -> string
```
```reasonml
let toString: t => string;
```
```ocaml
val toTimeString : t -> string
```
```reasonml
let toTimeString: t => string;
```
```ocaml
val toUTCString : t -> string
```
```reasonml
let toUTCString: t => string;
```