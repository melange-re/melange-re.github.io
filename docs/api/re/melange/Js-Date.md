
# Module `Js.Date`

Bindings to the functions in JS's `Date.prototype`

JavaScript Date API

```
type t
```
```
val valueOf : t -> float
```
returns the primitive value of this date, equivalent to getTime

```
val make : unit -> t
```
returns a date representing the current time

```
val fromFloat : float -> t
```
```
val fromString : string -> t
```
```
val makeWithYM : year:float -> month:float -> t
```
```
val makeWithYMD : year:float -> month:float -> date:float -> t
```
```
val makeWithYMDH : year:float -> month:float -> date:float -> hours:float -> t
```
```
val makeWithYMDHM : 
  year:float ->
  month:float ->
  date:float ->
  hours:float ->
  minutes:float ->
  t
```
```
val makeWithYMDHMS : 
  year:float ->
  month:float ->
  date:float ->
  hours:float ->
  minutes:float ->
  seconds:float ->
  t
```
```
val utcWithYM : year:float -> month:float -> float
```
```
val utcWithYMD : year:float -> month:float -> date:float -> float
```
```
val utcWithYMDH : 
  year:float ->
  month:float ->
  date:float ->
  hours:float ->
  float
```
```
val utcWithYMDHM : 
  year:float ->
  month:float ->
  date:float ->
  hours:float ->
  minutes:float ->
  float
```
```
val utcWithYMDHMS : 
  year:float ->
  month:float ->
  date:float ->
  hours:float ->
  minutes:float ->
  seconds:float ->
  float
```
```
val now : unit -> float
```
returns the number of milliseconds since Unix epoch

```
val parseAsFloat : string -> float
```
returns NaN if passed invalid date string

```
val getDate : t -> float
```
return the day of the month (1-31)

```
val getDay : t -> float
```
returns the day of the week (0-6)

```
val getFullYear : t -> float
```
```
val getHours : t -> float
```
```
val getMilliseconds : t -> float
```
```
val getMinutes : t -> float
```
```
val getMonth : t -> float
```
returns the month (0-11)

```
val getSeconds : t -> float
```
```
val getTime : t -> float
```
returns the number of milliseconds since Unix epoch

```
val getTimezoneOffset : t -> float
```
```
val getUTCDate : t -> float
```
return the day of the month (1-31)

```
val getUTCDay : t -> float
```
returns the day of the week (0-6)

```
val getUTCFullYear : t -> float
```
```
val getUTCHours : t -> float
```
```
val getUTCMilliseconds : t -> float
```
```
val getUTCMinutes : t -> float
```
```
val getUTCMonth : t -> float
```
returns the month (0-11)

```
val getUTCSeconds : t -> float
```
```
val setDate : date:float -> t -> float
```
```
val setFullYear : year:float -> t -> float
```
```
val setFullYearM : year:float -> month:float -> t -> float
```
```
val setFullYearMD : year:float -> month:float -> date:float -> t -> float
```
```
val setHours : hours:float -> t -> float
```
```
val setHoursM : hours:float -> minutes:float -> t -> float
```
```
val setHoursMS : hours:float -> minutes:float -> seconds:float -> t -> float
```
```
val setHoursMSMs : 
  hours:float ->
  minutes:float ->
  seconds:float ->
  milliseconds:float ->
  t ->
  float
```
```
val setMilliseconds : milliseconds:float -> t -> float
```
```
val setMinutes : minutes:float -> t -> float
```
```
val setMinutesS : minutes:float -> seconds:float -> t -> float
```
```
val setMinutesSMs : 
  minutes:float ->
  seconds:float ->
  milliseconds:float ->
  t ->
  float
```
```
val setMonth : month:float -> t -> float
```
```
val setMonthD : month:float -> date:float -> t -> float
```
```
val setSeconds : seconds:float -> t -> float
```
```
val setSecondsMs : seconds:float -> milliseconds:float -> t -> float
```
```
val setTime : time:float -> t -> float
```
```
val setUTCDate : date:float -> t -> float
```
```
val setUTCFullYear : year:float -> t -> float
```
```
val setUTCFullYearM : year:float -> month:float -> t -> float
```
```
val setUTCFullYearMD : year:float -> month:float -> date:float -> t -> float
```
```
val setUTCHours : hours:float -> t -> float
```
```
val setUTCHoursM : hours:float -> minutes:float -> t -> float
```
```
val setUTCHoursMS : hours:float -> minutes:float -> seconds:float -> t -> float
```
```
val setUTCHoursMSMs : 
  hours:float ->
  minutes:float ->
  seconds:float ->
  milliseconds:float ->
  t ->
  float
```
```
val setUTCMilliseconds : milliseconds:float -> t -> float
```
```
val setUTCMinutes : minutes:float -> t -> float
```
```
val setUTCMinutesS : minutes:float -> seconds:float -> t -> float
```
```
val setUTCMinutesSMs : 
  minutes:float ->
  seconds:float ->
  milliseconds:float ->
  t ->
  float
```
```
val setUTCMonth : month:float -> t -> float
```
```
val setUTCMonthD : month:float -> date:float -> t -> float
```
```
val setUTCSeconds : seconds:float -> t -> float
```
```
val setUTCSecondsMs : seconds:float -> milliseconds:float -> t -> float
```
```
val setUTCTime : time:float -> t -> float
```
```
val toDateString : t -> string
```
```
val toISOString : t -> string
```
```
val toJSON : t -> string option
```
```
val toJSONUnsafe : t -> string
```
```
val toLocaleDateString : t -> string
```
```
val toLocaleString : t -> string
```
```
val toLocaleTimeString : t -> string
```
```
val toString : t -> string
```
```
val toTimeString : t -> string
```
```
val toUTCString : t -> string
```