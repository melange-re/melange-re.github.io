# Module `Js.Global`
Bindings to functions in the JS global namespace
Contains functions available in the global scope (`window` in a browser context)
```
type intervalId
```
Identify an interval started by [`setInterval`](./#val-setInterval)
```
type timeoutId
```
Identify timeout started by [`setTimeout`](./#val-setTimeout)
```
val clearInterval : intervalId -> unit
```
Clear an interval started by [`setInterval`](./#val-setInterval)
```ocaml
(* API for a somewhat aggressive snoozing alarm clock *)

let interval = ref Js.Nullable.null

let remind () =
  Js.log "Wake Up!";
  IO.punchSleepyGuy ()

let snooze mins =
  interval := Js.Nullable.return (Js.Global.setInterval remind (mins * 60 * 1000))

let cancel () =
  Js.Nullable.iter !interval (fun[\@u] intervalId -> Js.Global.clearInterval intervalId)
```
see [https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/clearInterval](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/clearInterval) MDN
```
val clearTimeout : timeoutId -> unit
```
Clear a timeout started by [`setTimeout`](./#val-setTimeout)
```ocaml
(* A simple model of a code monkey's brain *)

let timer = ref Js.Nullable.null

let work () =
  IO.closeHackerNewsTab ()

let procrastinate mins =
  Js.Nullable.iter !timer (fun[\@u] timer -> Js.Global.clearTimeout timer);
  timer := Js.Nullable.return (Js.Global.setTimeout work (mins * 60 * 1000))
```
see [https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/clearTimeout](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/clearTimeout) MDN
```
val setInterval : f:(unit -> unit) -> int -> intervalId
```
*Repeatedly* executes a callback with a specified interval (in milliseconds) between calls
**Return** an [`intervalId`](./#type-intervalId) that can be passed to [`clearInterval`](./#val-clearInterval) to cancel the timeout
see [https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setInterval](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setInterval) MDN
```ocaml
(* Will count up and print the count to the console every second *)

let count = ref 0

let tick () =
  count := !count + 1; Js.log (string_of_int !count)

let _ =
  Js.Global.setInterval tick 1000
```
```
val setIntervalFloat : f:(unit -> unit) -> float -> intervalId
```
*Repeatedly* executes a callback with a specified interval (in milliseconds) between calls
**Return** an [`intervalId`](./#type-intervalId) that can be passed to [`clearInterval`](./#val-clearInterval) to cancel the timeout
see [https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setInterval](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setInterval) MDN
```ocaml
(* Will count up and print the count to the console every second *)

let count = ref 0

let tick () =
  count := !count + 1; Js.log (string_of_int !count)

let _ =
  Js.Global.setIntervalFloat tick 1000.0
```
```
val setTimeout : f:(unit -> unit) -> int -> timeoutId
```
Execute a callback after a specified delay (in milliseconds)
**returns** a [`timeoutId`](./#type-timeoutId) that can be passed to [`clearTimeout`](./#val-clearTimeout) to cancel the timeout
see [https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setTimeout](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setTimeout) MDN
```ocaml
(* Prints "Timed out!" in the console after one second *)

let message = "Timed out!"

let _ =
  Js.Global.setTimeout (fun () -> Js.log message) 1000
```
```
val setTimeoutFloat : f:(unit -> unit) -> float -> timeoutId
```
Execute a callback after a specified delay (in milliseconds)
**returns** a [`timeoutId`](./#type-timeoutId) that can be passed to [`clearTimeout`](./#val-clearTimeout) to cancel the timeout
see [https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setTimeout](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setTimeout) MDN
```ocaml
(* Prints "Timed out!" in the console after one second *)

let message = "Timed out!"

let _ =
  Js.Global.setTimeoutFloat (fun () -> Js.log message) 1000.0
```
```
val encodeURI : string -> string
```
URL-encodes a string.
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/encodeURI](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURI) MDN
```
val decodeURI : string -> string
```
Decodes a URL-enmcoded string produced by `encodeURI`
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/decodeURI](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/decodeURI) MDN
```
val encodeURIComponent : string -> string
```
URL-encodes a string, including characters with special meaning in a URI.
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/encodeURIComponent](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURIComponent) MDN
```
val decodeURIComponent : string -> string
```
Decodes a URL-enmcoded string produced by `encodeURIComponent`
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/decodeURIComponent](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/decodeURIComponent) MDN