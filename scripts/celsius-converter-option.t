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
  > let floatFromString = text =>
  >   switch (Js.Float.fromString(text)) {
  >   | Js.Float._NaN => None
  >   | value => Some(value)
  >   };
  > EOF

  $ dune build @melange
  File "input.re", line 3, characters 13-17:
  3 |   | Js.Float._NaN => None
                   ^^^^
  Error: Syntax error
  
  [1]

  $ cat > input.re <<\EOF
  > let floatFromString = text =>
  >   switch (Js.Float.fromString(text)) {
  >   | value when Js.Float.isNaN(value) => None
  >   | value => Some(value)
  >   };
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
  > switch (celsius |> float_of_string_opt |> Option.map(convert)) {
  > | None => "error"
  > | Some(fahrenheit) when fahrenheit < (-128.6) => "Unreasonably cold"
  > | Some(fahrenheit) when fahrenheit > 212.0 => "Unreasonably hot"
  > | Some(fahrenheit) => Js.Float.toFixedWithPrecision(fahrenheit, ~digits=2) ++ {js| °F|js}
  > }
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
  > {(
  >   String.trim(celsius) == ""
  >     ? {js|? °F|js}
  >     : (
  >       switch (celsius |> float_of_string_opt |> Option.map(convert)) {
  >       | None => "error"
  >       | Some(fahrenheit) when fahrenheit > 212.0 => "Unreasonably hot"
  >       | Some(fahrenheit) => Js.Float.toFixedWithPrecision(fahrenheit, ~digits=2) ++ {js| °F|js}
  >       }
  >     )
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
  > switch (celsius |> float_of_string_opt |> Option.map(convert)) {
  > | None => "error"
  > | Some(fahrenheit) when fahrenheit > 212.0 => "Unreasonably hot"
  > | Some(fahrenheit) => Js.Float.toFixedWithPrecision(fahrenheit, ~digits=2) ++ {js| °F|js}
  > }
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
  > switch (celsius |> float_of_string_opt |> Option.map(convert)) {
  > | None => "error"
  > | Some(fahrenheit) =>
  >   fahrenheit > 212.0
  >     ? "Unreasonably hot" : Js.Float.toFixedWithPrecision(fahrenheit, ~digits=2) ++ {js| °F|js}
  > }
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
  > switch (
  >   celsius
  >   |> float_of_string_opt
  >   |> Option.map(convert)
  >   |> Option.map(Js.Float.toFixedWithPrecision(~digits=2))
  > ) {
  > | None => "error"
  > | Some(fahrenheit) => fahrenheit ++ {js| °F|js}
  > }
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > let map = (f, o) =>
  >   switch (o) {
  >   | None => None
  >   | Some(v) => Some(f(v))
  >   };
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
  > celsius
  > |> float_of_string_opt
  > |> Option.map(convert)
  > |> Option.map(Js.Float.toFixedWithPrecision(~digits=2))
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
  > celsius |> float_of_string |> convert |> Js.Float.toFixedWithPrecision(~digits=2)
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > 
  > let celsius = "1";
  > let convert = x => x;
  > let _ =
  > 
  > switch (celsius |> float_of_string_opt) {
  > | None => "error"
  > | Some(fahrenheit) => (fahrenheit |> convert |> Js.Float.toFixedWithPrecision(~digits=2)) ++ {js| °F|js}
  > }
  > EOF

  $ dune build @melange

  $ cat > input.re <<\EOF
  > let getValueFromEvent = (evt): string => ReactEvent.Form.target(evt)##value;
  > 
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
  >         let newCelsius = getValueFromEvent(evt);
  >         setCelsius(_ => newCelsius);
  >       }}
  >     />
  >     {React.string({js|°C = |js})}
  >     {(
  >        celsius == ""
  >          ? {js|? °F|js}
  >          : (
  >            switch (celsius |> float_of_string |> convert |> Js.Float.toFixedWithPrecision(~digits=2)) {
  >            | exception _ => "error"
  >            | fahrenheit => fahrenheit ++ {js| °F|js}
  >            }
  >          )
  >      )
  >      |> React.string}
  >   </div>;
  > };
  > EOF

  $ dune build @melange

