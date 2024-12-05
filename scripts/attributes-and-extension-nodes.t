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
  > external node_env : string = "NODE_ENV" [@@mel.scope "process", "env"]
  > 
  > let development = "development"
  > let () = if node_env <> development then Js.log "Only in Production"
  > 
  > let development_inline = "development" [@@mel.inline]
  > let () = if node_env <> development_inline then Js.log "Only in Production"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let () = match [%mel.external __filename] with
  > | Some f -> Js.log f
  > | None -> Js.log "non-node environment"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let () = match [%mel.external __DEV__] with
  > | Some _ -> Js.log "dev mode"
  > | None -> Js.log "production mode"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let f x y =
  >   [%mel.debugger];
  >   x + y
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > [%%mel.raw "var a = 1"]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let f : unit -> int = [%mel.raw "function() {return 1}"]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let add = [%mel.raw {|
  >   function(a, b) {
  >     console.log("hello from raw JavaScript!");
  >     return a + b;
  >   }
  > |}]
  > 
  > let () = Js.log (add 1 2)
  > EOF

  $ dune build @melange

