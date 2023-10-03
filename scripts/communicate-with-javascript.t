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
  >  (libraries melange.dom melange.node)
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
  > external replace : substr:string -> newSubstr:string -> string = "replace"
  > [@@mel.send.pipe: string]
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
  > [@@deriving abstract]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type person = {
  >   name : string;
  >   mutable age : int;
  > }
  > [@@deriving abstract]
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
  > [@@deriving abstract { light }]
  > 
  > let alice = person ~name:"Alice" ~age:20
  > let aliceName = name alice
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > type person = {
  >   name : string;
  >   age : int option; [@optional]
  > }
  > [@@deriving abstract]
  > let alice = person ~name:"Alice" ~age:20 ()
  > let bob = person ~name:"Bob" ()
  > 
  > let twenty = ageGet alice
  > 
  > let bob = nameGet bob
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > 
  > type person = {
  >   name : string;
  >   age : int option; [@optional]
  > }
  > [@@deriving abstract]
  > 
  > let alice = person ~name:"Alice" ~age:20 ()
  > let bob = person ~name:"Bob" ()
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type person
  > 
  > val person : name:string -> ?age:int -> unit -> person
  > 
  > val nameGet : person -> string
  > 
  > val ageGet : person -> int option
  > EOF

  $ dune build @melange
  File "input.ml", line 3, characters 0-54:
  3 | val person : name:string -> ?age:int -> unit -> person
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Error: Value declarations are only allowed in signatures
  [1]

  $ cat > input.ml <<\EOF
  > type person = {
  >   name : string;
  >   age : int option; [@optional]
  > }
  > [@@deriving abstract]
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
  > let () = pets |. Belt.Array.map name |. Js.Array2.joinWith "&" |. Js.log
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > val actionToJs : action -> string
  > 
  > val actionFromJs : string -> action option
  > EOF

  $ dune build @melange
  File "input.ml", line 1, characters 17-23:
  1 | val actionToJs : action -> string
                       ^^^^^^
  Error: Unbound type constructor action
  Hint: Did you mean option?
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
  > val actionToJs : action -> abs_action
  > 
  > val actionFromJs : abs_action -> action
  > EOF

  $ dune build @melange
  File "input.ml", line 1, characters 17-23:
  1 | val actionToJs : action -> abs_action
                       ^^^^^^
  Error: Unbound type constructor action
  Hint: Did you mean option?
  [1]

  $ cat > input.ml <<\EOF
  > type action =
  >   | Click
  >   | Submit [@mel.as 3]
  >   | Cancel
  > [@@deriving jsConverter { newType }]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > val actionToJs : action -> int
  > 
  > val actionFromJs : int -> action option
  > EOF

  $ dune build @melange
  File "input.ml", line 1, characters 17-23:
  1 | val actionToJs : action -> int
                       ^^^^^^
  Error: Unbound type constructor action
  Hint: Did you mean option?
  [1]

  $ cat > input.ml <<\EOF
  > type action =
  >   | Click
  >   | Submit [@mel.as 3]
  >   | Cancel
  > [@@deriving jsConverter]
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

  $ cat > input.ml <<\EOF
  > type element
  > type document
  > external get_by_id : document -> string -> element option = "getElementById"
  >   [@@mel.send] [@@mel.return nullable]
  > 
  > let test document =
  >   let elem = get_by_id document "header" in
  >   match elem with
  >   | None -> 1
  >   | Some _element -> 2
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type x
  > external x : x = "x"
  > external set_onload : x -> ((x -> int -> unit)[@mel.this]) -> unit = "onload"
  >   [@@mel.set]
  > external resp : x -> int = "response" [@@mel.get]
  > let _ =
  >   set_onload x
  >     begin
  >       fun [@mel.this] o v -> Js.log (resp o + v)
  >     end
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let add x y = x + y
  > let _ = map [||] [||] add
  > EOF

  $ dune build @melange
  File "input.ml", line 2, characters 8-11:
  2 | let _ = map [||] [||] add
              ^^^
  Error: Unbound value map
  Hint: Did you mean max?
  [1]

  $ cat > input.ml <<\EOF
  > external map :
  >   'a array -> 'b array -> (('a -> 'b -> 'c)[@mel.uncurry]) -> 'c array = "map"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let add = fun [@u] x y -> x + y
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let add x y = x + y
  > let _ = map [||] [||] add
  > EOF

  $ dune build @melange
  File "input.ml", line 2, characters 8-11:
  2 | let _ = map [||] [||] add
              ^^^
  Error: Unbound value map
  Hint: Did you mean max?
  [1]

  $ cat > input.ml <<\EOF
  > external map : 'a array -> 'b array -> (('a -> 'b -> 'c)[@u]) -> 'c array
  >   = "map"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let add x = let partial y = x + y in partial
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external map : 'a array -> 'b array -> ('a -> 'b -> 'c) -> 'c array = "map"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let add x y = x + y
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external process_on_exit : (_[@mel.as "exit"]) -> (int -> unit) -> unit
  >   = "process.on"
  > 
  > let () =
  >   process_on_exit (fun exit_code ->
  >     Js.log ("error code: " ^ string_of_int exit_code))
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type readline
  > 
  > external on :
  >   readline ->
  >   ([ `close of unit -> unit | `line of string -> unit ][@mel.string]) ->
  >   readline = "on"
  >   [@@mel.send]
  > 
  > let register rl =
  >   rl |. on (`close (fun event -> ())) |. on (`line (fun line -> Js.log line))
  > EOF

  $ dune build @melange
  File "input.ml", line 10, characters 24-29:
  10 |   rl |. on (`close (fun event -> ())) |. on (`line (fun line -> Js.log line))
                               ^^^^^
  Error (warning 27 [unused-var-strict]): unused variable event.
  [1]

  $ cat > input.ml <<\EOF
  > external test_int_type :
  >   ([ `on_closed | `on_open [@mel.as 20] | `in_bin ][@mel.int]) -> int
  >   = "testIntType"
  > 
  > let value = test_int_type `on_open
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type document
  > type style
  > 
  > external document : document = "document"
  > external get_by_id : document -> string -> Dom.element = "getElementById"
  > [@@mel.send]
  > external style : Dom.element -> style = "style" [@@mel.get]
  > external transition_timing_function :
  >   style ->
  >   ([ `ease
  >    | `easeIn [@mel.as "ease-in"]
  >    | `easeOut [@mel.as "ease-out"]
  >    | `easeInOut [@mel.as "ease-in-out"]
  >    | `linear ]
  >   [@mel.string]) ->
  >   unit = "transitionTimingFunction"
  > [@@mel.set]
  > 
  > let element_style = style (get_by_id document "my-id")
  > let () = transition_timing_function element_style `easeIn
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external read_file_sync :
  >   name:string -> ([ `utf8 | `ascii ][@mel.string]) -> string = "readFileSync"
  >   [@@mel.module "fs"]
  > 
  > let _ = read_file_sync ~name:"xx.txt" `ascii
  > EOF

  $ dune build @melange
  File "input.ml", line 2, characters 18-36:
  2 |   name:string -> ([ `utf8 | `ascii ][@mel.string]) -> string = "readFileSync"
                        ^^^^^^^^^^^^^^^^^^
  Alert redundant: [@mel.string] is redundant here, you can safely remove it

  $ cat > input.ml <<\EOF
  > external padLeft:
  >   string
  >   -> ([ `Str of string
  >       | `Int of int
  >       ] [@mel.unwrap])
  >   -> string
  >   = "padLeft"
  > 
  > let _ = padLeft "Hello World" (`Int 4)
  > let _ = padLeft "Hello World" (`Str "Message from Melange: ")
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external drawCat : unit -> unit = "draw" [@@mel.module "MyGame"]
  > external drawDog : giveName:string -> unit = "draw" [@@mel.module "MyGame"]
  > external draw : string -> useRandomAnimal:bool -> unit = "draw"
  >   [@@mel.module "MyGame"]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type hide = Hide : 'a -> hide [@@unboxed]
  > 
  > external join : hide array -> string = "join" [@@mel.module "path"] [@@mel.variadic]
  > 
  > let v = join [| Hide "a"; Hide 2 |]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external join : string array -> string = "join"
  >   [@@mel.module "path"] [@@mel.variadic]
  > let v = join [| "a"; "b" |]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > (* Abstract type for the `document` global *)
  > type document
  > 
  > external document : document = "document"
  > external get_by_id : string -> Dom.element = "getElementById"
  >   [@@mel.send.pipe: document]
  > external get_by_classname : string -> Dom.element = "getElementsByClassName"
  >   [@@mel.send.pipe: Dom.element]
  > 
  > let el = document |> get_by_id "my-id" |> get_by_classname "my-class"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > (* Abstract type for the `document` global *)
  > type document
  > 
  > external document : document = "document"
  > external get_by_id : document -> string -> Dom.element = "getElementById"
  >   [@@mel.send]
  > external get_by_classname : Dom.element -> string -> Dom.element
  >   = "getElementsByClassName"
  >   [@@mel.send]
  > 
  > let el = document |. get_by_id "my-id" |. get_by_classname "my-class"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > (* Abstract type for the `document` global *)
  > type document
  > 
  > external document : document = "document"
  > external get_by_id : string -> Dom.element = "getElementById"
  >   [@@mel.send.pipe: document]
  > 
  > let el = get_by_id "my-id" document
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > (* Abstract type for the `document` global *)
  > type document
  > 
  > external document : document = "document"
  > external get_by_id : document -> string -> Dom.element = "getElementById"
  >   [@@mel.send]
  > 
  > let el = get_by_id document "my-id"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external draw : x:int -> y:int -> ?border:bool -> unit -> unit = "draw"
  >   [@@module "MyGame"]
  > let () = draw ~x:10 ~y:20 ()
  > let () = draw ~y:20 ~x:10 ()
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external draw : x:int -> y:int -> ?border:bool -> unit -> unit = "draw"
  >   [@@module "MyGame"]
  > 
  > let () = draw ~x:10 ~y:20 ~border:true ()
  > let () = draw ~x:10 ~y:20 ()
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type t
  > 
  > external create : unit -> t = "GUI"
  >   [@@mel.new] [@@mel.scope "default"] [@@mel.module "dat.gui"]
  > 
  > let gui = create ()
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external imul : int -> int -> int = "imul" [@@mel.scope "Math"]
  > 
  > let res = imul 1 2
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type t
  > 
  > external back : t = "back"
  >   [@@mel.module "expo-camera"] [@@mel.scope "Camera", "Constants", "Type"]
  > 
  > let camera_type_back = back
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type param
  > external executeCommands : string -> param array -> unit = ""
  >   [@@mel.scope "commands"] [@@mel.module "vscode"] [@@mel.variadic]
  > 
  > let f a b c = executeCommands "hi" [| a; b; c |]
  > EOF

  $ dune build @melange
  File "input.ml", lines 2-3, characters 0-67:
  2 | external executeCommands : string -> param array -> unit = ""
  3 |   [@@mel.scope "commands"] [@@mel.module "vscode"] [@@mel.variadic]
  Alert fragile: executeCommands : the external name is inferred from val name is unsafe from refactoring when changing value name

  $ cat > input.ml <<\EOF
  > external dirname : string -> string = "dirname" [@@mel.module "path"]
  > let root = dirname "/User/github"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > (* Abstract type for `document` *)
  > type document
  > 
  > external document : document = "document"
  > let document = document
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > (* Abstract type for `timeoutId` *)
  > type timeoutId
  > external setTimeout : (unit -> unit) -> int -> timeoutId = "setTimeout"
  > external clearTimeout : timeoutId -> unit = "clearTimeout"
  > 
  > let id = setTimeout (fun () -> Js.log "hello") 100
  > let () = clearTimeout id
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type t
  > external book : unit -> t = "Book" [@@mel.new] [@@mel.module]
  > let myBook = book ()
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type t
  > external create_date : unit -> t = "Date" [@@mel.new]
  > let date = create_date ()
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type t
  > external create : int -> t = "Int32Array" [@@mel.new]
  > external get : t -> int -> int = "" [@@mel.get_index]
  > external set : t -> int -> int -> unit = "" [@@mel.set_index]
  > 
  > let () =
  >   let i32arr = (create 3) in
  >   set i32arr 0 42;
  >   Js.log (get i32arr 0)
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > (* Abstract type for the `document` value *)
  > type document
  > 
  > external document : document = "document"
  > 
  > external set_title : document -> string -> unit = "title" [@@mel.set]
  > external get_title : document -> string = "title" [@@mel.get]
  > 
  > let current = get_title document
  > let () = set_title document "melange"
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let homeRoute = route ~_type:"GET" ~path:"/" ~action:(fun _ -> Js.log "Home") ()
  > EOF

  $ dune build @melange
  File "input.ml", line 1, characters 16-21:
  1 | let homeRoute = route ~_type:"GET" ~path:"/" ~action:(fun _ -> Js.log "Home") ()
                      ^^^^^
  Error: Unbound value route
  [1]

  $ cat > input.ml <<\EOF
  > external route :
  >   _type:string ->
  >   path:string ->
  >   action:(string list -> unit) ->
  >   ?options:< .. > ->
  >   unit ->
  >   _ = ""
  >   [@@mel.obj]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let name_extended obj = obj##name ^ " wayne"
  > 
  > let one = name_extended [%mel.obj { name = "john"; age = 99 }]
  > let two = name_extended [%mel.obj { name = "jane"; address = "1 infinite loop" }]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let john = [%mel.obj { name = "john"; age = 99 }]
  > let t = john##name
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type t = {
  >   foo : int; [@mel.as "0"]
  >   bar : string; [@mel.as "1"]
  > }
  > 
  > let value = { foo = 7; bar = "baz" }
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type action = {
  >   type_ : string [@mel.as "type"]
  > }
  > 
  > let action = { type_ = "ADD_USER" }
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > type person = {
  >   name : string;
  >   friends : string array;
  >   age : int;
  > }
  > 
  > external john : person = "john" [@@mel.module "MySchool"]
  > let john_name = john.name
  > EOF

  $ dune build @melange

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

  $ cat > input.ml <<\EOF
  > let r = [%mel.re "/b/g"]
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > let () = React.useEffect2 (fun () -> None) (foo, bar)
  > EOF

  $ dune build @melange
  File "input.ml", line 1, characters 9-25:
  1 | let () = React.useEffect2 (fun () -> None) (foo, bar)
               ^^^^^^^^^^^^^^^^
  Error: Unbound module React
  [1]

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

