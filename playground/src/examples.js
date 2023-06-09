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
];

export default examples;
