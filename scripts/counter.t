This test file is automatically generated from its corresponding markdown
file. To update the tests, run `dune build @extract-code-blocks`.

  $ cat > dune-project <<EOF
  > (lang dune 3.8)
  > (using melange 0.1)
  > EOF

  $ cat > dune <<EOF
  > (melange.emit
  >  (emit_stdlib false)
  >  (target output)
  >  (libraries melange.dom melange.node reason-react)
  >  (preprocess (pps melange.ppx reason-react-ppx)))
  > EOF

  $ cat > input.re <<\EOF
  > 
  > let (counter, setCounter) = React.useState(() => 0);
  > let _ = 
  > 
  > <div
  >   style={ReactDOMStyle.make(
  >     ~padding="1em",
  >     ~display="grid",
  >     ~gridGap="1em",
  >     ~gridTemplateColumns="25px fit-content(20px) 25px",
  >     (),
  >   )}>
  >   <button onClick={_evt => setCounter(v => v - 1)}> {React.string("-")} </button>
  >   <span> {counter |> Int.to_string |> React.string} </span>
  >   <button onClick={_evt => setCounter(v => v + 1)}> {React.string("+")} </button>
  > </div>
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let (counter, setCounter) = React.useState(() => 0);
  > let _ = 
  > 
  > {counter |> Int.to_string |> React.string}
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > module Counter = {
  >   [@react.component]
  >   let make = () => {
  >     let (counter, setCounter) = React.useState(() => 0);
  > 
  >     <div>
  >       <button onClick={_evt => setCounter(v => v - 1)}> {React.string("-")} </button>
  >       {React.string(Int.to_string(counter))}
  >       <button onClick={_evt => setCounter(v => v + 1)}> {React.string("+")} </button>
  >     </div>;
  >   };
  > }
  > 
  > module App = {
  >   [@react.component]
  >   let make = () => <Counter />;
  > };
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > [@react.component]
  > let make = () => {
  >   let (counter, setCounter) = React.useState(() => 0);
  > 
  >   <div>
  >     <button onClick={_evt => setCounter(v => v - 1)}> {React.string("-")} </button>
  >     {React.string(Int.to_string(counter))}
  >     <button onClick={_evt => setCounter(v => v + 1)}> {React.string("+")} </button>
  >   </div>;
  > };
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > module App = {
  >   [@react.component]
  >   let make = () => <div> {React.string("welcome to my app")} </div>;
  > };
  > 
  > let node = ReactDOM.querySelector("#root");
  > switch (node) {
  > | Some(root) => ReactDOM.render(<App />, root)
  > | None => Js.Console.error("Failed to start React: couldn't find the #root element")
  > };
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > module App = {
  >   [@react.component]
  >   let make = () => <div> {React.string("welcome to my app")} </div>;
  > };
  > EOF

  $ dune build @melange

