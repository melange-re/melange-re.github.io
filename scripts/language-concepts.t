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
  > let sum_sq =
  >   [ 1; 2; 3 ]
  >   |. Belt.List.map String.cat
  >   |. sum
  > EOF

  $ dune build @melange
  File "input.ml", line 4, characters 5-8:
  4 |   |. sum
           ^^^
  Error: Unbound value sum
  [1]

  $ cat > input.ml <<\EOF
  > let sum_sq =
  >   [ 1; 2; 3 ]
  >   |. Belt.List.map square
  >   |. sum
  > EOF

  $ dune build @melange
  File "input.ml", line 4, characters 5-8:
  4 |   |. sum
           ^^^
  Error: Unbound value sum
  [1]

  $ cat > input.ml <<\EOF
  > let sum_sq =
  >   [ 1; 2; 3 ]
  >   |> List.map String.cat
  >   |> sum
  > EOF

  $ dune build @melange
  File "input.ml", line 4, characters 5-8:
  4 |   |> sum
           ^^^
  Error: Unbound value sum
  [1]

  $ cat > input.ml <<\EOF
  > let sum = List.fold_left ( + ) 0
  > 
  > let sum_sq =
  >   [ 1; 2; 3 ]
  >   |> List.map square (* [1; 4; 9] *)
  >   |> sum             (* 1 + 4 + 9 *)
  > EOF

  $ dune build @melange
  File "input.ml", line 5, characters 14-20:
  5 |   |> List.map square (* [1; 4; 9] *)
                    ^^^^^^
  Error: Unbound value square
  [1]

  $ cat > input.ml <<\EOF
  > let ten = 3 |> square |> succ
  > EOF

  $ dune build @melange
  File "input.ml", line 1, characters 15-21:
  1 | let ten = 3 |> square |> succ
                     ^^^^^^
  Error: Unbound value square
  [1]

  $ cat > input.ml <<\EOF
  > let ten = succ (square 3)
  > EOF

  $ dune build @melange
  File "input.ml", line 1, characters 16-22:
  1 | let ten = succ (square 3)
                      ^^^^^^
  Error: Unbound value square
  [1]

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

