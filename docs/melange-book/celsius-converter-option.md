# Celsius Converter using Option

After all the changes we made in the last chapter, your `CelsiusConverter.re`
might look something like this:

```reasonml
let getValueFromEvent = (evt): string => ReactEvent.Form.target(evt)##value;

let convert = celsius => 9.0 /. 5.0 *. celsius +. 32.0;

[@react.component]
let make = () => {
  let (celsius, setCelsius) = React.useState(() => "");

  <div>
    <input
      value=celsius
      onChange={evt => {
        let newCelsius = getValueFromEvent(evt);
        setCelsius(_ => newCelsius);
      }}
    />
    {React.string({js|°C = |js})}
    {(
       celsius == ""
         ? {js|? °F|js}
         : (
           switch (celsius |> float_of_string |> convert |> Js.Float.toFixedWithPrecision(~digits=2)) {
           | exception _ => "error"
           | fahrenheit => fahrenheit ++ {js| °F|js}
           }
         )
     )
     |> React.string}
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
switch (celsius |> float_of_string_opt) {
| None => "error"
| Some(fahrenheit) => (fahrenheit |> convert |> Js.Float.toFixedWithPrecision(~digits=2)) ++ {js| °F|js}
}
```

In terms of functionality, this does exactly what the previous version did. But
the critical difference is that if you comment out the `| None` branch, the
compiler will refuse to accept it:

```
File "src/CelsiusConverter.re", lines 15-20, characters 11-10:
15 | ...........(
16 |            switch (celsius |> float_of_string_opt) {
17 |            //  | None => "error"
18 |            | Some(fahrenheit) => (fahrenheit |> convert |> Js.Float.toFixedWithPrecision(~digits=2)) ++ {js| °F|js}
19 |            }
20 |          )
Error (warning 8 [partial-match]): this pattern-matching is not exhaustive.
Here is an example of a case that is not matched:
None
```

You would get a similar error if you left off the `| Some(_)` branch. Having an
`option` value be the input for a switch expression means that you can't forget
to handle the failure case, much less the success case. There's another
advantage: The `| Some(fahrenheit)` branch gives you access to the `float`
that was successfully converted from the `string`, and *only this branch* has
access to that value. So you can be reasonably sure that the success case is
handled here and not somewhere else. You are starting to experience the power of
[pattern matching](https://reasonml.github.io/docs/en/pattern-matching) in OCaml.

You might be thinking that it's a shame we had to give up the long chain of
function calls once we switched to using `float_of_string_opt`:

```reasonml
celsius |> float_of_string |> convert |> Js.Float.toFixedWithPrecision(~digits=2)
```

Actually, we can still use a chain of functions if we make a couple of edits:

```reasonml
celsius
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
quite minimal, consisting of a single switch expression:

```reasonml
let map = (f, o) =>
  switch (o) {
  | None => None
  | Some(v) => Some(f(v))
  };
```

As you might expect, there are many more helper functions related to `option` in
the [Option module](https://melange.re/v2.0.0/api/re/melange/Stdlib/Option/).

At this point, your switch expression might look like this:

```reasonml
switch (
  celsius
  |> float_of_string_opt
  |> Option.map(convert)
  |> Option.map(Js.Float.toFixedWithPrecision(~digits=2))
) {
| None => "error"
| Some(fahrenheit) => fahrenheit ++ {js| °F|js}
}
```

What if we wanted to render a message of complaint when the temperature goes
above 212° F and not even bother to render the converted number? It could look
like this:

```reasonml
switch (celsius |> float_of_string_opt |> Option.map(convert)) {
| None => "error"
| Some(fahrenheit) =>
  fahrenheit > 212.0
    ? "Unreasonably hot" : Js.Float.toFixedWithPrecision(fahrenheit, ~digits=2) ++ {js| °F|js}
}
```

Here, we take `Js.Float.toFixedWithPrecision` out of the switch expression input
so that we can do a float comparison inside the `Some(_)` branch. This works,
but OCaml gives you a construct that allows you to do the float comparison
through the switch expression itself:

```reasonml
switch (celsius |> float_of_string_opt |> Option.map(convert)) {
| None => "error"
| Some(fahrenheit) when fahrenheit > 212.0 => "Unreasonably hot"
| Some(fahrenheit) => Js.Float.toFixedWithPrecision(fahrenheit, ~digits=2) ++ {js| °F|js}
}
```

The [when guard](https://reasonml.github.io/docs/en/pattern-matching#when)
allows you to add extra conditions to a switch expression branch, keeping
nesting of conditionals to a minimum and making your code more readable.

Hooray! Our Celsius converter is finally complete. Later, we'll see how to
create a component that can convert back and forth between Celsius and
Fahrenheit. But first, we'll explore Melange's [build system dune](https://melange.re/v2.0.0/build-system/).

## Exercises

<b>1.</b> If you enter a space in the input, it'll unintuitively produce a
Fahrenheit value of 32.00 degrees (because `float_of_string_opt(" ") ==
Some(0.)`). Handle this case correctly by showing "? °F" instead. Hint: Use the
`String.trim` function.

<b>2.</b> Add another branch with a `when` guard that renders "Unreasonably
cold" if the temperature is less than -128.6°F.

<b>3.</b> Use `Js.Float.fromString` instead of `float_of_string_opt` to parse a
string to float. Hint: Use `Js.Float.isNaN` in a `when` guard.

## Overview

- Prefer functions that return `option` over those that throw exceptions.
  - When you the input of a switch expression is `option`, the compiler can
    helpfully remind you to handle the error case.
- `Option.map(function)` is very useful When chaining functions that return `option`.
- You can use a `when` guard to make your switch expression more expressive
  without adding nesting of conditionals.

## Solutions

<b>1.</b> To prevent a space from producing 32.00 degrees Fahrenheit, just add a
call to `String.trim` in your render logic:

```reasonml
{(
  String.trim(celsius) == ""
    ? {js|? °F|js}
    : (
      switch (celsius |> float_of_string_opt |> Option.map(convert)) {
      | None => "error"
      | Some(fahrenheit) when fahrenheit > 212.0 => "Unreasonably hot"
      | Some(fahrenheit) => Js.Float.toFixedWithPrecision(fahrenheit, ~digits=2) ++ {js| °F|js}
      }
    )
)
|> React.string}
```

<b>2.</b> To render "Unreasonably cold" when the temperature is less than
-128.6°F, you can add another `Some(fahrenheit)` branch:

```reasonml
switch (celsius |> float_of_string_opt |> Option.map(convert)) {
| None => "error"
| Some(fahrenheit) when fahrenheit < (-128.6) => "Unreasonably cold"
| Some(fahrenheit) when fahrenheit > 212.0 => "Unreasonably hot"
| Some(fahrenheit) => Js.Float.toFixedWithPrecision(fahrenheit, ~digits=2) ++ {js| °F|js}
}
```

<b>3.</b> To use `Js.Float.fromString` instead of `float_of_string_opt`, you can
define a new helper function that takes a `string` and returns `option`:

```reasonml
let floatFromString = text =>
  switch (Js.Float.fromString(text)) {
  | value when Js.Float.isNaN(value) => None
  | value => Some(value)
  };
```

Then substitute `float_of_string_opt` for `floatFromString` in your switch
expression. You might be tempted to match directly on `Js.Float._NaN`:

```reasonml
let floatFromString = text =>
  switch (Js.Float.fromString(text)) {
  | Js.Float._NaN => None
  | value => Some(value)
  };
```

But this produces a syntax error because you can't do equality checks of
variables in OCaml pattern matching. So the `when` guard is necessary here.

-----

[Source code for this
chapter](https://github.com/melange-re/melange-for-react-devs/blob/develop/src/celsius-converter-option/)
can be found in the [Melange for React Developers
repo](https://github.com/melange-re/melange-for-react-devs).
