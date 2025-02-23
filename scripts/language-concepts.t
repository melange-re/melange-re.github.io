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
  >  (libraries melange.belt melange.dom melange.node)
  >  (preprocess (pps melange.ppx)))
  > EOF

  $ cat > input.ml <<\EOF
  > 
  > (* not expected to type check *)
  > let sum = List.fold_left ( + ) 0
  > let square x = x * x
  > 
  > let sum_sq =
  >   [ 1; 2; 3 ]
  >   |. Belt.List.map String.cat
  >   |. sum
  > EOF

  $ dune build @melange
  File "input.ml", line 8, characters 19-29:
  8 |   |. Belt.List.map String.cat
                         ^^^^^^^^^^
  Error: The value String.cat has type string -> string -> string
         but an expression was expected of type int -> 'a
         Type string is not compatible with type int
  [1]

  $ cat > input.ml <<\EOF
  > 
  > let sum = List.fold_left ( + ) 0
  > let square x = x * x
  > 
  > let sum_sq =
  >   [ 1; 2; 3 ]
  >   |. Belt.List.map square
  >   |. sum
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > (* not expected to type check *)
  > let sum = List.fold_left ( + ) 0
  > 
  > let sum_sq =
  >   [ 1; 2; 3 ]
  >   |> List.map String.cat
  >   |> sum
  > EOF

  $ dune build @melange
  File "input.ml", line 6, characters 4-5:
  6 |   [ 1; 2; 3 ]
          ^
  Error: The constant 1 has type int but an expression was expected of type
           string
  [1]

  $ cat > input.ml <<\EOF
  > 
  > let square x = x * x
  > 
  > let sum = List.fold_left ( + ) 0
  > 
  > let sum_sq =
  >   [ 1; 2; 3 ]
  >   |> List.map square (* [1; 4; 9] *)
  >   |> sum             (* 1 + 4 + 9 *)
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > let square x = x * x
  > 
  > let ten = 3 |> square |> succ
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > let square x = x * x
  > 
  > let ten = succ (square 3)
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let square x = x * x
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let ( |> ) f g = g f
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type document
  > 
  > external document : document = "document"
  > external set_title : document -> string -> unit = "title" [@@mel.set]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type document
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type foo = string
  > type bar = int
  > external danger_zone : foo -> bar = "%identity"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external my_c_function : int -> string = "someCFunctionName"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type document
  > external setTitleDom : document -> string -> unit = "title" [@@mel.set]
  > 
  > type t = {
  >   age : int; [@mel.as "a"]
  >   name : string; [@mel.as "n"]
  > }
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type name =
  >   | Name of string [@@unboxed]
  > let student_name = Name "alice"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > [%%mel.raw "var a = 1; var b = 2"]
  > let add = [%mel.raw "a + b"]
  > EOF

  $ dune build @melange

