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
  > let r = [%mel.re "/b/g"]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > let foo, bar = 1, 2
  > module React = struct let useEffect2 _ _ = () end
  > 
  > let () = React.useEffect2 (fun () -> None) (foo, bar)
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let world = {j|世界|j}
  > let helloWorld = {j|你好，$world|j}
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let () = Js.log {js|你好，
  > 世界|js}
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let () = Js.log "你好"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let u = `Foo (* "Foo" *)
  > let v = `Foo(2) (* { NAME: "Foo", VAL: "2" } *)
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type t = A of string | B of int
  > (* A("foo") -> { TAG: 0, _0: "Foo" } *)
  > (* B(2) -> { TAG: 1, _0: 2 } *)
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type tree = Leaf | Node of int * tree * tree
  > (* Leaf -> 0 *)
  > (* Node(7, Leaf, Leaf) -> { _0: 7, _1: 0, _2: 0 } *)
  > EOF

  $ dune build @melange

