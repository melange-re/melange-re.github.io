# Celsius Converter, pt 2

After all the changes we made in the last chapter, your `CelsiusConverter.re`
might look something like this:

```reasonml
let getValueFromEvent = (evt): string => ReactEvent.Form.target(evt)##value;

let convert = celsius => 9.0 /. 5.0 *. celsius +. 32.0;

[@react.component]
let make = () => {
  let (celsius, setCelsius) = React.useState(() => "");
  let (fahrenheit, setFahrenheit) = React.useState(() => "?");

  <div>
    <input
      value=celsius
      onChange={evt => {
        let newCelsius = getValueFromEvent(evt);
        setCelsius(_ => newCelsius);
        switch (newCelsius |> float_of_string |> convert |> Js.Float.toFixedWithPrecision(~digits=2)) {
        | exception _ => setFahrenheit(_ => "error")
        | newFahrenheit => setFahrenheit(_ => newFahrenheit)
        };
      }}
    />
    {React.string({js|°C = |js})}
    {(fahrenheit == "error" ? fahrenheit : fahrenheit ++ {js| °F|js}) |> React.string}
  </div>;
};
```

What happens if you forget the `| exception _` branch of your switch expression?
Your program will crash when invalid input is entered. The compiler won't warn
you to add an exception branch because it doesn't keep track of which functions
throw exceptions. So a better way is to simply not use functions that can fail!

We're going to refactor our switch expression to use `float_of_string_opt`
instead. This function has the type signature `string => option(float)`. It
takes a `string` argument and returns `Some(result)` if it succeeded and `None`
if it failed. Let's see what that looks like:

```reasonml
switch (float_of_string_opt(newCelsius)) {
| None => setFahrenheit(_ => "error")
| Some(newFahrenheit) =>
  setFahrenheit(_ => newFahrenheit |> convert |> Js.Float.toFixedWithPrecision(~digits=2))
};
```

In terms of functionality, this does exactly what the previous version did. But
the critical difference is that if you comment out the `| None` branch, the
compiler will refuse to accept it:

```
File "src/CelsiusConverter.re", lines 16-20, characters 8-10:
16 | ........switch (float_of_string_opt(newCelsius)) {
17 |         // | None => setFahrenheit(_ => "error")
18 |         | Some(newFahrenheit) =>
19 |           setFahrenheit(_ => newFahrenheit |> convert |> Js.Float.toFixedWithPrecision(~digits=2))
20 |         };
Error (warning 8 [partial-match]): this pattern-matching is not exhaustive.
Here is an example of a case that is not matched:
None
```

You would get a similar error if you left off the `| Some(_)` branch. Having an
`option` value be the input for a switch expression means that you can't forget
to handle the failure case, much less the success case. There's another
advantage: The `| Some(newFahrenheit)` branch gives you access to the `float`
that was successfully converted from the `string``, and *only this branch* has
access to that value. So you can be reasonably sure that the success case is
handled here and not somewhere else.

You might be thinking that it's a shame we had to give up the long chain of
function calls once we switched to using `float_of_string_opt`:

```reasonml
newCelsius |> float_of_string |> convert |> Js.Float.toFixedWithPrecision(~digits=2)
```

Actually, we can still use this chain, we just have to make a couple of small
changes:

```reasonml
newCelsius
|> float_of_string_opt
|> Option.map(convert)
|> Option.map(Js.Float.toFixedWithPrecision(~digits=2))
```

`Option.map` takes a function and an `option` value, and only invokes the
function if the `option` was `Some(_)`. Hovering over it, you can see that its
type signature is:

```
('a => 'b, option('a)) => option('b)
```

Here `'a` and `'b` mean "any type", because `option` can wrap around any type,
e.g. `option(string)`, `option(int)`, etc. The implementation of `Option.map` is
quite simple, consisting of a single switch expression:

```reasonml
let map = (f, o) =>
  switch (o) {
  | None => None
  | Some(v) => Some(f(v))
  };
```

As you might expect, there are many more helper functions related to `option` in
the [Option module](todo).

At this point, your switch expression might look like this:

```reasonml
switch (
  newCelsius
  |> float_of_string_opt
  |> Option.map(convert)
  |> Option.map(Js.Float.toFixedWithPrecision(~digits=2))
) {
| None => setFahrenheit(_ => "error")
| Some(newFahrenheit) => setFahrenheit(_ => newFahrenheit)
};
```

Notice that we call `setFahrenheit` in both branches. This isn't really
necessary, since switch expressions always return a value, meaning you could
rewrite it to call `setFahrenheit` only once:

```reasonml
let newFahrenheit =
  switch (
    newCelsius
    |> float_of_string_opt
    |> Option.map(convert)
    |> Option.map(Js.Float.toFixedWithPrecision(~digits=2))
  ) {
  | None => "error"
  | Some(newFahrenheit) => newFahrenheit
  };
setFahrenheit(_ => newFahrenheit);
```

We've already improved the switch expression by swapping `float_of_string` out
for `float_of_string_opt`, but this component can still be improved by the use
of `option`! We can change the `fahrenheit` state value from `string` to
`option(string)`, setting it to `None` when it doesn't have a valid value. We
start by initializing it to `None`:

```reasonml
let (fahrenheit, setFahrenheit) = React.useState(() => None);
```

We continue the refactor by changing the switch expression to return
`option(string)`  instead of `string`:

```reasonml
let newFahrenheit =
  switch (
    newCelsius
    |> float_of_string_opt
    |> Option.map(convert)
    |> Option.map(Js.Float.toFixedWithPrecision(~digits=2))
  ) {
  | None => None
  | Some(newFahrenheit) => Some(newFahrenheit)
  };
```

Actually, note that the two branches don't change the return value of the switch
expression in any way, meaning we can eliminate the switch entirely:

```reasonml
let newFahrenheit =
  newCelsius
  |> float_of_string_opt
  |> Option.map(convert)
  |> Option.map(Js.Float.toFixedWithPrecision(~digits=2));
```

The ternary expression that rendered `fahrenheit` needs to use a switch
expression now, since ternary expressions have no way to access the value inside
`Some(_)`:

```reasonml
{(
  switch (fahrenheit) {
  | None => "error"
  | Some(fahrenheit) => fahrenheit ++ {js| °F|js}
  }
)
|> React.string}
```

Note that `fahrenheit` has type `string` inside the `Some(_)` branch and it
shadows `fahrenheit` which has type `option(string)` in the scope above. This is
an OCaml convention and generally isn't a problem in practice.

After it compiles, you'll notice that it now renders "error" when the input is
blank, but for this case we'd like to continue rendering "? °F" as it did
before. One way is to add the `celsius` state value to the input of the switch
expression:

```reasonml
switch (celsius, fahrenheit) {
| ("", _) => {js|? °F|js}
| (_, None) => "error"
| (_, Some(fahrenheit)) => fahrenheit ++ {js| °F|js}
}
```
