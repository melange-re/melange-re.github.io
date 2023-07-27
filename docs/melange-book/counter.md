# Counter

We're going build the classic frontend starter app, the counter, using
[ReasonReact](https://reasonml.github.io/reason-react/). Let's clone the
tutorial template and initialize it:

    git clone https://github.com/melange-re/melange-tutorial
    cd melange-tutorial
    make init

To start webpack, run `make serve`. The app will be served at
http://localhost:8080/. In another terminal window, start the Melange compiler
in watch mode by running `make watch`.

Open `Index.re` and you'll see this:

```reason
module App = {
  [@react.component]
  let make = () => <div> {React.string("welcome to my app")} </div>;
};
```

This is just about the simplest component you can make. Unlike in normal React,
we must wrap strings inside function calls to convert them to the
`React.element` type. This is exactly what the `React.string` function does--if
you hover over it, you'll see that it displays the type `string =>
React.element`. The `make` function itself has the type `unit => React.element`,
meaning it takes `()` as the only argument and returns an object of type
`React.element`.

What's with the `module` business? OCaml's
[modules](https://cs3110.github.io/textbook/chapters/modules/modules.html) are
somewhat like JavaScript modules, with one (of many) notable differences being
that there can be multiples modules inside a single file. For now, you just need
to know that all components in ReasonReact are modules.

A little bit further down, we make use of the `App` component:

```reason
let node = ReactDOM.querySelector("#root");
switch (node) {
| Some(root) => ReactDOM.render(<App />, root)
| None => Js.Console.error("Failed to start React: couldn't find the #root element")
};
```

`React.querySelector("#root")` returns an `option(Dom.element)`, meaning that if
it doesn't find the element, it returns `None`, and if it does find the element,
it returns `Some(Dom.element)`, i.e. the element wrapped in the `Some`
constructor. The `switch` expression (despite the name, don't confuse it for the
JavaScript construct of the same name), and allows you to succinctly express:

- If `node` is `Some(Dom.element)`, render the `App` component to the DOM
- Otherwise if `node` is `None`, log an error message

Don't worry if this doesn't quite make sense yet, we'll talk more about `option`
and other [variant
types](https://cs3110.github.io/textbook/chapters/data/variants.html)
later.

Let's create a counter component by creating a new file called `Counter.re` in
the same directory, with the following contents:

```reason
[@react.component]
let make = () => {
  let (counter, setCounter) = React.useState(() => 0);

  <div>
    <button onClick={_evt => setCounter(v => v - 1)}> {React.string("-")} </button>
    {React.string(Int.to_string(counter))}
    <button onClick={_evt => setCounter(v => v + 1)}> {React.string("+")} </button>
  </div>;
};
```

This is a component with a single `useState` hook. It should look fairly
familiar if you know about [hooks in React](https://react.dev/reference/react).
Note that we didn't need to manually define a module for `Counter`, because all
files in OCaml are automatically modules, with the name of the module being the
same as the name of the file.

Now let's modify `App` so that it uses our new `Counter` component:

```reason
module App = {
  [@react.component]
  let make = () => <Counter />;
};
```

To display the number of the counter, we wrote
`{React.string(Int.to_string(counter))}`, which converts an integer to a string,
and then converts that string to `React.element`. But in OCaml, there's a
better way:

```reason
{counter |> Int.to_string |> React.string}
```

This uses the [pipe last operator](../communicate-with-javascript#pipe-last),
which is useful for chaining function calls.

Let's add a bit of styling to the root element of `Counter`:

```reason
<div
  style={ReactDOMStyle.make(
    ~padding="1em",
    ~display="grid",
    ~gridGap="1em",
    ~gridTemplateColumns="25px fit-content(20px) 25px",
    (),
  )}>
  <button onClick={_evt => setCounter(v => v - 1)}> {React.string("-")} </button>
  <span> {counter |> Int.to_string |> React.string} </span>
  <button onClick={_evt => setCounter(v => v + 1)}> {React.string("+")} </button>
</div>
```

Unlike in React, the `style` prop in ReasonReact doesn't take a generic object,
instead it takes an object of type `ReactDOMStyle.t` that is created by calling
`ReactDOMStyle.make`. Obviously, this isn't an ideal way to style our app--we'll
learn a better way to do it in a later section.

Congratulations! You've created your first ReasonReact app and component. We'll
create more complex and interesting components in future chapters.

## Exercises

1. There aren't any runtime errors in our app right now. But what happens if you
   try to remove the `| None` branch of the `switch (node)` expression?
1. What happens if you rename the `_evt` variable inside the button callback to
   `evt`?
1. Comment out the `[@react.component]` attribute in `Counter.re`. What happens?

## Overview

What we covered in this section:

- How to create and run a basic ReasonReact app
- ReasonReact components are also modules
- OCaml has an `option` type whose value can be either `None` or `Some(_)`
- The pipe last operator is an alternate way to invoke functions that enables
  easy chaining of function calls
- The `style` prop doesn't take generic objects

## Solutions

1. Removing the `| None` branch will result in a compilation error:
   ```
   Error (warning 8 [partial-match]): this pattern-matching is not exhaustive.
   Here is an example of a case that is not matched:
   None
   ```
   Basically, the compiler is telling you to handle the `None` case if you want
   to ship your app. This is part of what makes OCaml such a type-safe language.
1. Renaming `_evt` to `evt` results in a compilation error:
   ```
   Error (warning 27 [unused-var-strict]): unused variable evt.
   ```
   OCaml wants you to use all the variables you declare, unless they being with
   `_` (underscore).
1. Commenting out `[@react.component]` in `Index.re`, at the place where
   `Counter` is used:
   ```
   File "src/Index.re", line 3, characters 19-27:
   3 |   let make = () => <Counter />;
                          ^^^^^^^^
   Error: Unbound value Counter.makeProps
   ```
   For now, just remember that you need to put the `[@react.component]`
   attribute above your `make` function if you want your component to be usable
   in JSX. We'll explain why later.

