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
  > 
  > external map : 'a array -> 'b array -> (('a -> 'b -> 'c)[@mel.uncurry]) -> 'c array = "map"
  > 
  > let add x y = x + y
  > let _ = map [||] [||] add
  > EOF

  $ dune build @melange

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
  > 
  > external map : 'a array -> 'b array -> (('a -> 'b -> 'c)[@u]) -> 'c array = "map"
  > 
  > let add x y = x + y
  > let _ = map [||] [||] add
  > EOF

  $ dune build @melange
  File "input.ml", line 5, characters 22-25:
  5 | let _ = map [||] [||] add
                            ^^^
  Error: This expression has type int -> int -> int
         but an expression was expected of type ('a -> 'b -> 'c [@u])
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
  >   rl |. on (`close (fun _event -> ())) |. on (`line (fun line -> Js.log line))
  > EOF

  $ dune build @melange

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
  >   name:string -> ([ `utf8 | `ascii ]) -> string = "readFileSync"
  >   [@@mel.module "fs"]
  > 
  > let _ = read_file_sync ~name:"xx.txt" `ascii
  > EOF

  $ dune build @melange

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
  >   [@@mel.module "MyGame"]
  > let () = draw ~x:10 ~y:20 ()
  > let () = draw ~y:20 ~x:10 ()
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external draw : x:int -> y:int -> ?border:bool -> unit -> unit = "draw"
  >   [@@mel.module "MyGame"]
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
  > external executeCommands : string -> param array -> unit = "executeCommands"
  >   [@@mel.scope "commands"] [@@mel.module "vscode"] [@@mel.variadic]
  > 
  > let f a b c = executeCommands "hi" [| a; b; c |]
  > EOF

  $ dune build @melange

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
  > 
  > external route :
  >   _type:string ->
  >   path:string ->
  >   action:(string list -> unit) ->
  >   ?options:'a ->
  >   unit ->
  >   'b = ""
  >   [@@mel.obj]
  > 
  > let homeRoute = route ~_type:"GET" ~path:"/" ~action:(fun _ -> Js.log "Home") ()
  > EOF

  $ dune build @melange

  $ cat > input.ml <<\EOF
  > external route :
  >   _type:string ->
  >   path:string ->
  >   action:(string list -> unit) ->
  >   ?options:'a ->
  >   unit ->
  >   'b = ""
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

