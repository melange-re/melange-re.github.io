# Celsius Converter, pt 1

This time, we'll create a widget that take a temperature value in Celsius and
converts it to Fahrenheit. Create a new file called `CelsiusConverter.re`:

```reasonml
let convert = celsius => 9.0 /. 5.0 *. celsius +. 32.0;

[@react.component]
let make = () => {
  let (celsius, setCelsius) = React.useState(() => "");
  let (fahrenheit, setFahrenheit) = React.useState(() => "?");

  <div>
    <input
      value=celsius
      onChange={evt => {
        let newCelsius = ReactEvent.Form.target(evt)##value;
        setCelsius(_ => newCelsius);
      }}
    />
    {React.string({js|°C = |js})}
    {React.string(fahrenheit)}
  </div>;
};
```

Inside the `input`'s `onChange` handler, we get the event target using
`ReactEvent.Form.target`, which has the type `ReactEvent.Form.t => {.. }`. What
is `{.. }`? It's an object whose fields aren't well-defined (is there a specific
term for this?), pretty much the same as a JavaScript object. In OCaml, we use
`##` operator to access fields on an object. Be careful when using objects, as
it subverts OCaml's type system. We could write
`ReactEvent.Form.target(evt)##value + 1`, treating it as if it were an integer,
and we wouldn't get a compilation error.

It's a good idea to put functions that return objects into type-annotated helper
functions. For example:

```reasonml
let getValueFromEvent = (evt): string => ReactEvent.Form.target(evt)##value;

// Call it like this:
let newValue = getValueFromEvent(evt);
```

The `: string` after the argument list tells the compiler that this function
must return a `string`. Using `getValueFromEvent` ensures that the `value` field
can't be used as anything other than a string.

Another thing to note about `onChange` is that after the `evt` argument, the
body of the callback function is surrounded by braces ({}). OCaml functions are
like JavaScript's arrow functions--if they contain more than one line, they need
to be enclosesd by braces.

Let's add some lines to the `onChange` handler to update the Fahrenheit
value:

```reasonml
onChange={evt => {
  let newCelsius = getValueFromEvent(evt);
  setCelsius(_ => newCelsius);
  let newFahrenheit = newCelsius |> float_of_string |> convert |> string_of_float;
  setFahrenheit(_ => newFahrenheit);
}}
```

The pipe last operator (`|>`) is very useful here, allowing us to convert a
string to float, then convert that float to another float (Celsius ->
Fahrenheit), and convert back to string, all in one line.

We should probably put °F after the Fahrenheit value so that it's clear to the
user what unit of measure they're seeing. We can do so using the string
concatenation operator (`++`):

```reasonml
{React.string(fahrenheit ++ {js| °F|js})}

// This would also work:
{fahrenheit ++ {js| °F|js} |> React.string}
```

However, there's a bug in this code: it will crash if you enter anything into
the input that can't be converted to a float. We can remedy this by catching the
exception using a `switch` expression:

```reasonml
switch (newCelsius |> float_of_string |> convert |> string_of_float) {
| exception _ => setFahrenheit(_ => "error")
| newFahrenheit => setFahrenheit(_ => newFahrenheit)
};
```

The `| exception _` branch will execute if there is any exception. The
underscore (`_`) is a wildcard, meaning it will match any exception. If we
wanted to be specific about which exception we want to catch, we could instead
write

```reasonml
| exception (Failure(_)) => ()
```

Note that when an error occurs, we show "error °F" which looks a little weird.
It's nicer sense to just show "error" in that case:

```reasonml
{(fahrenheit == "error" ? fahrenheit : fahrenheit ++ {js| °F|js}) |> React.string}
```

The ternary expression (`condition ? a : b`) works the same as in JavaScript,
but in OCaml, it's just a shorthand for an if-else expression (`if (condition) {
a; } else { b; }`):

```reasonml
{(
  if (fahrenheit == "error") {
    fahrenheit;
  } else {
    fahrenheit ++ {js| °F|js};
  }
)
|> React.string}
```

Unlike in JavaScript, the if-else construct is an expression and always yields a
value. Both branches must return a value of the same type or you'll get a
compilation error.

We have a working component now, but catching exceptions isn't The OCaml Way! In
the next chapter, you'll see how to rewrite the logic using `option`.

## Exercises

1. Try changing `{js|°C = |js}` to `"°C = "`. What happens?
1. tbd
1. tbd

## Overview

- Objects (`{.. }`) can have fields of any name and type
  - You access fields of an object using the `##` operator
  - You can use type annotations to make use of objects safer
- Concatenate strings using the `++` operator
- `switch` expressions can be used to catch exceptions
- Ternary expressions are shorthand for if-else expressions
- The two branches of if-else expressions must return values of the same type

## Solutions

1. tbd
1. tbd
1. tbd
