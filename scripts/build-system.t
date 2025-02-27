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
  > let dir = [%mel.raw "__dirname"]
  > let file = "name.txt"
  > let name = Node.Fs.readFileSync (dir ^ "/" ^ file) `ascii
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > module Lib = struct let name = "" end
  > 
  > let () = Js.log Lib.name
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let name = "Jane"
  > EOF

  $ dune build @melange

