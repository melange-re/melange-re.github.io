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
  >  (preprocess (pps melange.ppx)))
  > EOF

  $ cat > input.re <<\EOF
  > <input value=celsius onChange={evt => setCelsius(_ => getValueFromEvent(evt))} />
  > EOF

  $ dune build @melange
  File "input.re", line 1, characters 13-20:
  1 | <input value=celsius onChange={evt => setCelsius(_ => getValueFromEvent(evt))} />
                   ^^^^^^^
  Error: The function applied to this argument has type
           bytes -> int -> int -> int
  This argument cannot be applied with label ~value
  [1]

  $ cat > input.re <<\EOF
  > let addFive = (+)(5);
  > Js.log(addFive(2));
  > Js.log(addFive(7));
  > Js.log(addFive(10));
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > switch (celsius |> float_of_string |> convert |> Js.Float.toFixedWithPrecision(~digits=2)) {
  > | exception _ => "error"
  > | fahrenheit => fahrenheit ++ {js| °F|js}
  > }
  > EOF

  $ dune build @melange
  File "input.re", line 1, characters 38-45:
  1 | switch (celsius |> float_of_string |> convert |> Js.Float.toFixedWithPrecision(~digits=2)) {
                                            ^^^^^^^
  Error: Unbound value convert
  [1]

  $ cat > input.re <<\EOF
  > celsius |> float_of_string |> convert
  > EOF

  $ dune build @melange
  File "input.re", line 1, characters 30-37:
  1 | celsius |> float_of_string |> convert
                                    ^^^^^^^
  Error: Unbound value convert
  [1]

  $ cat > input.re <<\EOF
  > celsius |> float_of_string |> convert |> string_of_float
  > EOF

  $ dune build @melange
  File "input.re", line 1, characters 30-37:
  1 | celsius |> float_of_string |> convert |> string_of_float
                                    ^^^^^^^
  Error: Unbound value convert
  [1]

  $ cat > input.re <<\EOF
  > switch (celsius |> float_of_string |> convert) {
  > | exception _ => "error"
  > | fahrenheit => Js.Float.toFixedWithPrecision(fahrenheit, ~digits=2) ++ {js| °F|js}
  > };
  > EOF

  $ dune build @melange
  File "input.re", line 1, characters 38-45:
  1 | switch (celsius |> float_of_string |> convert) {
                                            ^^^^^^^
  Error: Unbound value convert
  [1]

  $ cat > input.re <<\EOF
  > {(
  >   if (celsius == "") {
  >     {js|? °F|js};
  >   } else {
  >     switch (celsius |> float_of_string |> convert |> string_of_float) {
  >     | exception _ => "error"
  >     | fahrenheit => fahrenheit ++ {js| °F|js}
  >     };
  >   }
  > )
  > |> React.string}
  > EOF

  $ dune build @melange
  File "input.re", line 11, characters 3-15:
  11 | |> React.string}
          ^^^^^^^^^^^^
  Error: Unbound module React
  [1]

  $ cat > input.re <<\EOF
  > {(
  >     celsius == ""
  >       ? {js|? °F|js}
  >       : (
  >         switch (celsius |> float_of_string |> convert |> string_of_float) {
  >         | exception _ => "error"
  >         | fahrenheit => fahrenheit ++ {js| °F|js}
  >         }
  >       )
  >   )
  >   |> React.string}
  > EOF

  $ dune build @melange
  File "input.re", line 11, characters 5-17:
  11 |   |> React.string}
            ^^^^^^^^^^^^
  Error: Unbound module React
  [1]

  $ cat > input.re <<\EOF
  > | exception (Failure(_)) => "error"
  > EOF

  $ dune build @melange
  File "input.re", line 1, characters 0-1:
  1 | | exception (Failure(_)) => "error"
      ^
  Error: Syntax error
  
  [1]

  $ cat > input.re <<\EOF
  > {(
  >   switch (celsius |> float_of_string |> convert |> string_of_float) {
  >   | exception _ => "error"
  >   | fahrenheit => fahrenheit ++ {js| °F|js}
  >   }
  > )
  > |> React.string}
  > EOF

  $ dune build @melange
  File "input.re", line 7, characters 3-15:
  7 | |> React.string}
         ^^^^^^^^^^^^
  Error: Unbound module React
  [1]

  $ cat > input.re <<\EOF
  > {(celsius |> float_of_string |> convert |> string_of_float) ++ {js| °F|js} |> React.string}
  > EOF

  $ dune build @melange
  File "input.re", line 1, characters 79-91:
  1 | {(celsius |> float_of_string |> convert |> string_of_float) ++ {js| °F|js} |> React.string}
                                                                                     ^^^^^^^^^^^^
  Error: Unbound module React
  [1]

  $ cat > input.re <<\EOF
  > {celsius |> float_of_string |> convert |> string_of_float |> React.string}
  > EOF

  $ dune build @melange
  File "input.re", line 1, characters 61-73:
  1 | {celsius |> float_of_string |> convert |> string_of_float |> React.string}
                                                                   ^^^^^^^^^^^^
  Error: Unbound module React
  [1]

  $ cat > input.re <<\EOF
  > let getValueFromEvent = (evt): string => ReactEvent.Form.target(evt)##value;
  > 
  > // Call it like this:
  > let newValue = getValueFromEvent(evt);
  > EOF

  $ dune build @melange
  File "input.re", line 1, characters 41-63:
  1 | let getValueFromEvent = (evt): string => ReactEvent.Form.target(evt)##value;
                                               ^^^^^^^^^^^^^^^^^^^^^^
  Error: Unbound module ReactEvent
  [1]

  $ cat > input.re <<\EOF
  > let convert = celsius => 9.0 /. 5.0 *. celsius +. 32.0;
  > 
  > [@react.component]
  > let make = () => {
  >   let (celsius, setCelsius) = React.useState(() => "");
  > 
  >   <div>
  >     <input
  >       value=celsius
  >       onChange={evt => {
  >         let newCelsius = ReactEvent.Form.target(evt)##value;
  >         setCelsius(_ => newCelsius);
  >       }}
  >     />
  >     {React.string({js|°C = |js})}
  >     {React.string({js|? °F|js})}
  >   </div>;
  > };
  > EOF

  $ dune build @melange
  File "input.re", line 5, characters 30-44:
  5 |   let (celsius, setCelsius) = React.useState(() => "");
                                    ^^^^^^^^^^^^^^
  Error: Unbound module React
  [1]

