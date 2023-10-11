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
  > let getValueFromEvent = (evt): string => ReactEvent.Form.target(evt)##value;
  > let (celsius, setCelsius) = React.useState(() => "");
  > let _ =
  > 
  > <input value=celsius onChange={evt => setCelsius(_ => getValueFromEvent(evt))} />
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > let addFive = (+)(5);
  > Js.log(addFive(2));
  > Js.log(addFive(7));
  > Js.log(addFive(10));
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let getValueFromEvent = (evt): string => ReactEvent.Form.target(evt)##value;
  > let (celsius, setCelsius) = React.useState(() => "");
  > let _ =
  > 
  > <input value=celsius onChange={evt => setCelsius(_ => getValueFromEvent(evt))} />
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
  > switch (celsius |> float_of_string |> convert |> Js.Float.toFixedWithPrecision(~digits=2)) {
  > | exception _ => "error"
  > | fahrenheit => fahrenheit ++ {js| °F|js}
  > }
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
  > celsius |> float_of_string |> convert
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
  > celsius |> float_of_string |> convert |> string_of_float
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
  > switch (celsius |> float_of_string |> convert) {
  > | exception _ => "error"
  > | fahrenheit => Js.Float.toFixedWithPrecision(fahrenheit, ~digits=2) ++ {js| °F|js}
  > };
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
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

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
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

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
  > {(
  >   switch (celsius |> float_of_string |> convert |> string_of_float) {
  >   | exception _ => "error"
  >   | fahrenheit => fahrenheit ++ {js| °F|js}
  >   }
  > )
  > |> React.string}
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
  > {(celsius |> float_of_string |> convert |> string_of_float) ++ {js| °F|js} |> React.string}
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
  > {celsius |> float_of_string |> convert |> string_of_float |> React.string}
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let evt: ReactEvent.Form.t = [%mel.raw "null"];
  > 
  > let getValueFromEvent = (evt): string => ReactEvent.Form.target(evt)##value;
  > 
  > // Call it like this:
  > let newValue = getValueFromEvent(evt);
  > EOF

  $ dune build @melange

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

