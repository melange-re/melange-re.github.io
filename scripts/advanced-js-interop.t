This test file is automatically generated from its corresponding markdown
file. To update the tests, run `dune build @extract-code-blocks`.

  $ cat > dune-project <<EOF
  > (lang dune 3.21)
  > (using melange 1.0)
  > EOF

  $ cat > dune <<EOF
  > (melange.emit
  >  (emit_stdlib false)
  >  (target output)
  >  (libraries melange.belt melange.dom melange.node)
  >  (preprocess (pps melange.ppx)))
  > EOF

  $ cat > input.ml <<\EOF
  > let default = 10
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let print name = "Hello" ^ name
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type person = private {
  >   name : string;
  >   age : int;
  > }
  > [@@deriving getSet]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type person = {
  >   name : string;
  >   mutable age : int;
  > }
  > [@@deriving jsProperties, getSet]
  > 
  > let alice = person ~name:"Alice" ~age:20
  > 
  > let () = ageSet alice 21
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type person = {
  >   name : string;
  >   age : int;
  > }
  > [@@deriving jsProperties, getSet { light }]
  > 
  > let alice = person ~name:"Alice" ~age:20
  > let aliceName = name alice
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > type person = {
  >   name : string;
  >   age : int option; [@mel.optional]
  > }
  > [@@deriving jsProperties, getSet]
  > let alice = person ~name:"Alice" ~age:20 ()
  > let bob = person ~name:"Bob" ()
  > 
  > let twenty = ageGet alice
  > 
  > let bob = nameGet bob
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type person = {
  >   name : string;
  >   age : int option; [@mel.optional]
  > }
  > [@@deriving jsProperties, getSet]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type person = {
  >   name : string;
  >   age : int option; [@mel.optional]
  > }
  > [@@deriving getSet]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > type person = {
  >   name : string;
  >   age : int option; [@mel.optional]
  > }
  > [@@deriving jsProperties]
  > 
  > let alice = person ~name:"Alice" ~age:20 ()
  > let bob = person ~name:"Bob" ()
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type person
  > 
  > external person : name:string -> ?age:int -> unit -> person = "person"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type person = {
  >   name : string;
  >   age : int option; [@mel.optional]
  > }
  > [@@deriving jsProperties]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type person = {
  >   name : string;
  >   age : int option;
  > }
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type pet = { name : string } [@@deriving accessors]
  > let name (param : pet) = param.name
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type pet = { name : string } [@@deriving accessors]
  > 
  > let pets = [| { name = "Brutus" }; { name = "Mochi" } |]
  > 
  > let () = pets |. Belt.Array.map name |. Js.Array.join ~sep:"&" |. Js.log
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > (* type signature *)
  > type action
  > type abs_action
  > 
  > val actionToJs : action -> abs_action
  > 
  > val actionFromJs : abs_action -> action
  > EOF

  $ dune build @melange
  File "input.ml", line 6, characters 0-37:
  6 | val actionToJs : action -> abs_action
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Error: Value declarations are only allowed in signatures
  [1]

  $ cat > input.ml <<\EOF
  > type action =
  >   [ `Click
  >   | `Submit [@mel.as "submit"]
  >   | `Cancel
  >   ]
  > [@@deriving jsConverter { newType }]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > (* type signature *)
  > type action
  > 
  > val actionToJs : action -> string
  > 
  > val actionFromJs : string -> action option
  > EOF

  $ dune build @melange
  File "input.ml", line 5, characters 0-33:
  5 | val actionToJs : action -> string
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Error: Value declarations are only allowed in signatures
  [1]

  $ cat > input.ml <<\EOF
  > type action =
  >   [ `Click
  >   | `Submit [@mel.as "submit"]
  >   | `Cancel
  >   ]
  > [@@deriving jsConverter]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > (* type signature *)
  > type action
  > 
  > val actionToJs : action -> int
  > 
  > val actionFromJs : int -> action option
  > EOF

  $ dune build @melange
  File "input.ml", line 5, characters 0-30:
  5 | val actionToJs : action -> int
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Error: Value declarations are only allowed in signatures
  [1]

  $ cat > input.ml <<\EOF
  > type action =
  >   | Click [@mel.as "click"]
  >   | Submit [@mel.as "submit"]
  >   | Cancel [@mel.as "cancel"]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type action =
  >   | Click
  >   | Submit of string
  >   | Cancel
  > 
  > let click = (Click : action)
  > let submit param = (Submit param : action)
  > let cancel = (Cancel : action)
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type action =
  >   | Click
  >   | Submit of string
  >   | Cancel
  > [@@deriving accessors]
  > EOF

  $ dune build @melange

