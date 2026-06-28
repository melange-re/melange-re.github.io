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
  > module Foo = struct
  >   type t
  >   external bar : t -> t option = "bar" [@@mel.get] [@@mel.return nullable]
  > end
  > 
  > external foo : Foo.t = "foo"
  > 
  > let _result = match Foo.bar foo with Some _ -> 1 | None -> 0
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > module Foo = struct
  >   type t
  >   external bar : t -> int option = "bar" [@@mel.get]
  > end
  > 
  > external foo : Foo.t = "foo"
  > 
  > let _result = match Foo.bar foo with Some _ -> 1 | None -> 0
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let arr = [|2|]
  > external sort : 'a array -> (('a -> 'a -> int)[@mel.uncurry]) -> 'a array
  >   = "sort"
  > [@@mel.send]
  > 
  > let _ = sort arr compare
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external replace : substr:string -> newSubstr:string -> (string [@mel.this]) -> string = "replace"
  > [@@mel.send]
  > 
  > let str = "goodbye world"
  > let substr = "goodbye"
  > let newSubstr = "hello"
  > let newStr = replace ~substr ~newSubstr str
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > module Foo = struct
  >   type t
  > 
  >   external make : unit -> t = "Foo" [@@mel.new]
  >   external meth : t -> unit = "meth" [@@mel.send]
  > end
  > 
  > let foo = Foo.make ()
  > let () = Foo.meth foo
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > module Foo = struct
  >   type t
  >   external make : unit -> t = "Foo" [@@mel.new]
  >   external setBar : t -> int -> unit = "bar" [@@mel.set]
  > end
  > 
  > let foo = Foo.make ()
  > let () = Foo.setBar foo 1
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > module Foo = struct
  >   type t
  >   external make : unit -> t = "Foo" [@@mel.new]
  >   external bar : t -> int = "bar" [@@mel.get]
  > end
  > 
  > let foo = Foo.make ()
  > let bar = Foo.bar foo
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > module Foo = struct
  >   type t
  >   external make : unit -> t = "Foo" [@@mel.new]
  > end
  > 
  > let foo = Foo.make ()
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > module Foo = struct
  >   type t
  >   external make : unit -> t = "Foo" [@@mel.new]
  >   external bar : t -> unit = "bar" [@@mel.get]
  > end
  > 
  > let foo = Foo.make ()
  > let () = Foo.bar foo
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type person = { id : int; name : string }
  > 
  > let person = { id = 1; name = "Alice" }
  > let { id; name } = person
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > type person = { id : int; name : string }
  > let person = { id = 1; name = "Alice" }
  > 
  > external set_id : person -> int -> unit = "id" [@@mel.set]
  > 
  > let () = set_id person 0
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > type person = { id : int; name : string }
  > let person = { id = 1; name = "Alice" }
  > 
  > let name = person.name
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > let person = [%mel.obj { name = "john"; age = 99 }]
  > 
  > let name = person##name
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type person = { id : int; name : string }
  > let person = { id = 1; name = "Alice" }
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let person = [%mel.obj { id = 1; name = "Alice" }]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external forEach :
  >   start:int -> stop:int -> ((int -> unit)[@mel.uncurry]) -> unit = "forEach"
  > 
  > let () = forEach ~start:1 ~stop:10 Js.log
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type mkdirOptions
  > 
  > external mkdirOptions : ?recursive:bool -> unit -> mkdirOptions = "" [@@mel.obj]
  > external mkdir : string -> ?options:mkdirOptions -> unit -> unit = "mkdir"
  > 
  > let () = mkdir "src" ()
  > let () = mkdir "src/main" ~options:(mkdirOptions ~recursive:true ()) ()
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external range : start:int -> stop:int -> ?step:int -> unit -> int array
  >   = "range"
  > 
  > let nums = range ~start:1 ~stop:10 ()
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external fooString : string -> unit = "foo"
  > external fooBool : bool -> unit = "foo"
  > 
  > let () = fooString ""
  > let () = fooBool true
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external range : start:int -> stop:int -> step:int -> int array = "range"
  > let nums = range ~start:1 ~stop:10 ~step:2
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external join : string array -> string = "join" [@@mel.module "path"] [@@mel.variadic]
  > let dir = join [| "a"; "b" |]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > module Foo = struct
  >   module Bar = struct
  >     external baz : unit -> unit = "baz" [@@mel.module "foo"] [@@mel.scope "bar"]
  >   end
  > end
  > 
  > let () = Foo.Bar.baz ()
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external foo : int -> unit = "default" [@@mel.module "foo"]
  > let () = foo 1
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external foo : int -> unit = "foo" [@@mel.module]
  > let () = foo 1
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external join : string -> string -> string = "join" [@@mel.module "path"]
  > let dir = join "a" "b"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external log : 'a -> unit = "log" [@@mel.scope "console"]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external pi : float = "PI" [@@mel.scope "Math"]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let _ = match [%mel.external window] with
  > | Some _ -> "window exists"
  > | None -> "window does not exist"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external window : Dom.window = "window"
  > EOF

  $ dune build @melange

