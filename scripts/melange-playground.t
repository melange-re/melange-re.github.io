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
  > [@react.component]
  > let make = () => {
  >   let (counter, setCounter) = React.useState(() => 0.0);
  > 
  >   <div
  >     style={ReactDOMStyle.make(
  >       ~padding="1em",
  >       ~display="flex",
  >       ~gridGap="1em",
  >       (),
  >     )}>
  >     <button onClick={_evt => setCounter(v => v -. 0.5)}>
  >       {React.string("-")}
  >     </button>
  >     <span> {counter |> Float.to_string |> React.string} </span>
  >     <button onClick={_evt => setCounter(v => v +. 1.5)}>
  >       {React.string("+")}
  >     </button>
  >   </div>;
  > };
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > let baz = 42_000_000_000L; // int64
  > Js.log(baz);
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > let foo = 42;   // int
  > let bar = 42.0; // float
  > Js.log(Js.typeof(foo)); // prints "number"
  > Js.log(Js.typeof(bar)); // prints "number"
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > Js.log(42.0 +. 16.0); // prints 58
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let foo = 42;
  > let bar = 42.0;
  > 
  > Js.log(Float.of_int(foo) == bar);
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let foo = 42;
  > let bar = 42.0;
  > 
  > Js.log(foo == Int.of_float(bar));
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > let foo = 42;   // int
  > let bar = 42.0; // float
  > Js.log(foo == bar);
  > EOF

  $ dune build @melange
  File "input.re", line 3, characters 14-17:
  3 | Js.log(foo == bar);
                    ^^^
  Error: This expression has type float but an expression was expected of type
           int
  [1]

  $ cat > input.re <<\EOF
  > let bar: int = 42.1;
  > EOF

  $ dune build @melange
  File "input.re", line 1, characters 15-19:
  1 | let bar: int = 42.1;
                     ^^^^
  Error: This expression has type float but an expression was expected of type
           int
  [1]

  $ cat > input.re <<\EOF
  > let foo = 42;   // int
  > let bar = 42.1; // float
  > Js.log(foo);
  > Js.log(bar);
  > EOF

  $ dune build @melange

