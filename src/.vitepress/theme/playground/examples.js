const examples = [
  {
    name: "Tree sum",
    ml: `type tree = Leaf | Node of int * tree * tree

let rec sum item =
  match item with
  | Leaf -> 0
  | Node (value, left, right) -> value + sum left + sum right

let myTree =
  Node
    ( 1,
      Node (2, Node (4, Leaf, Leaf), Node (6, Leaf, Leaf)),
      Node (3, Node (5, Leaf, Leaf), Node (7, Leaf, Leaf)) )

let () = Js.log (sum myTree)`,
    re: `type tree =
  | Leaf
  | Node(int, tree, tree);

let rec sum = item =>
  switch (item) {
  | Leaf => 0
  | Node(value, left, right) => value + sum(left) + sum(right)
  };

let myTree =
  Node(
    1,
    Node(2, Node(4, Leaf, Leaf), Node(6, Leaf, Leaf)),
    Node(3, Node(5, Leaf, Leaf), Node(7, Leaf, Leaf)),
  );

let () = Js.log(sum(myTree));`,
  },
  {
    name: "Factorial",
    ml: `(* Based on https://rosettacode.org/wiki/Factorial#Recursive_50 *)
let rec factorial n =
  match n <= 0 with
  | true -> 1
  | false -> n * factorial (n - 1)

let _ = Js.log (factorial 6)
`,
    re: `/* Based on https://rosettacode.org/wiki/Factorial#Recursive_50 */
let rec factorial = (n) =>
  n <= 0
  ? 1
  : n * factorial(n - 1);

Js.log(factorial(6));`,
  },
  {
    name: "Random numbers",
    ml: `(* Based on https://rosettacode.org/wiki/Random_numbers#OCaml *)
let pi = 4. *. atan 1.

let random_gaussian () =
  1.
  +. (sqrt (-2. *. log (Random.float 1.)) *. cos (2. *. pi *. Random.float 1.))

let _ =
  Belt.Array.makeBy 42 (fun _ -> random_gaussian ())
  |. Belt.Array.forEach Js.log`,
    re: `/* Based on https://rosettacode.org/wiki/Random_numbers#OCaml */
let pi = 4. *. atan(1.);

let random_gaussian = () =>
  1.
  +. sqrt((-2.) *. log(Random.float(1.)))
  *. cos(2. *. pi *. Random.float(1.));

Belt.Array.makeBy(42, _ => random_gaussian())->(Belt.Array.forEach(Js.log));`,
  },
  {
    name: "React Greeting",
    ml: `module Greeting = struct
  let make () = (button ~children:[ React.string "Hello!" ] () [@JSX])
  [@@react.component]
end

let element = ReactDOM.querySelector "#preview"

let () =
  match element with
  | Some element ->
      let root = ReactDOM.Client.createRoot element in
      ReactDOM.Client.render root
        (Greeting.createElement ~children:[] () [@JSX])
  | None ->
      Js.Console.error
        "Failed to start React: couldn't find the #preview element"`,
    re: `module Greeting = {
  [@react.component]
  let make = () => <button> {React.string("Hello!")} </button>;
};

let element = ReactDOM.querySelector("#preview");

let () =
  switch (element) {
  | Some(element) =>
    let root = ReactDOM.Client.createRoot(element);
    ReactDOM.Client.render(root, <Greeting />);
  | None =>
    Js.Console.error(
      "Failed to start React: couldn't find the #preview element",
    )
  };`,
  },
];

export default examples;

