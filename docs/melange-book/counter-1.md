# Counter, Part 1

We're going build the classic starter app, the counter, using
[ReasonReact](https://reasonml.github.io/reason-react/). Let's clone the
tutorial template and initialize it:

    git clone https://github.com/melange-re/melange-tutorial
    cd melange-tutorial
    make init

To start webpack, run `make serve`. The app will be served at
http://localhost:8081/. In another terminal window, start the Reason compiler in
watch mode by running `make watch`.

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
meaning it takes no arguments and returns an object of type `React.element`.

A little bit further down, we'll use the `App` component:

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
constructor. The `switch` expression is only remotely related to the JavaScript
construct of the same name, and allows you to succinctly express:

- If `node` is `Some(Dom.element)`, render the `App` component to the DOM
- Otherwise if `node` is `None`, log an error message

Don't worry if this doesn't quite make sense yet, we'll talk more about `option`
and other [variant types](something.com) in the next section.

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
familiar if you've made hook-based components in React.

Now let's modify `App` so that it uses our new `Counter` component:

```reason
module App = {
  [@react.component]
  let make = () => <Counter />;
};
```

To display the number of the counter, we wrote
`{React.string(Int.to_string(counter))}`, which converts an integer to a string,
and then converts that string to `React.element`. But in Reason, there's a
better way:

```reason
{counter->Int.to_string->React.string}
```

This uses the [pipe first
operator](https://melange.re/v1.0.0/communicate-with-javascript/#pipe-first),
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
  <span> {React.string(Int.to_string(counter))} </span>
  <button onClick={_evt => setCounter(v => v + 1)}> {React.string("+")} </button>
</div>
```

Surprisingly, the `style` prop in ReasonReact doesn't take a string, instead it
takes an object of type `ReactDOMStyle.t`. (what's the reason for this?)
Obviously, this isn't an ideal way to style our app--we'll learn a better way to
do it in a later section.

Congratulations! You've created your first ReasonReact app. We'll enhance this
app in the coming sections.

## Exercises

1. There aren't any runtime errors in our app right now. But what happens if you
   try to remove the `| None` branch of the `switch (node)` expression?
1. The pipe first operator isn't only useful for chaining function calls.
   Convert the `{React.string("-")}` expression to use the pipe first invocation
   style. What happens after the file is formatted?
1. What happens if you rename the `_evt` variable inside the button callback to
   `evt`?
