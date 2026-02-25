
# Module `Stdlib.Queue`

First-in first-out queues.

This module implements queues (FIFOs), with in-place modification. See [the example section](./#examples) below.

**Unsynchronized accesses**

Unsynchronized accesses to a queue may lead to an invalid queue state. Thus, concurrent accesses to queues must be synchronized (for instance with a [`Mutex.t`](./Stdlib-Mutex.md#type-t)).

```ocaml
type !'a t
```
```reasonml
type t(!'a);
```
The type of queues containing elements of type `'a`.

```ocaml
exception Empty
```
```reasonml
exception Empty;
```
Raised when [`Queue.take`](./#val-take) or [`Queue.peek`](./#val-peek) is applied to an empty queue.

```ocaml
val create : unit -> 'a t
```
```reasonml
let create: unit => t('a);
```
Return a new queue, initially empty.

```ocaml
val add : 'a -> 'a t -> unit
```
```reasonml
let add: 'a => t('a) => unit;
```
`add x q` adds the element `x` at the end of the queue `q`.

```ocaml
val push : 'a -> 'a t -> unit
```
```reasonml
let push: 'a => t('a) => unit;
```
`push` is a synonym for `add`.

```ocaml
val take : 'a t -> 'a
```
```reasonml
let take: t('a) => 'a;
```
`take q` removes and returns the first element in queue `q`, or raises [`Empty`](./#exception-Empty) if the queue is empty.

```ocaml
val take_opt : 'a t -> 'a option
```
```reasonml
let take_opt: t('a) => option('a);
```
`take_opt q` removes and returns the first element in queue `q`, or returns `None` if the queue is empty.

since 4\.08
```ocaml
val pop : 'a t -> 'a
```
```reasonml
let pop: t('a) => 'a;
```
`pop` is a synonym for `take`.

```ocaml
val peek : 'a t -> 'a
```
```reasonml
let peek: t('a) => 'a;
```
`peek q` returns the first element in queue `q`, without removing it from the queue, or raises [`Empty`](./#exception-Empty) if the queue is empty.

```ocaml
val peek_opt : 'a t -> 'a option
```
```reasonml
let peek_opt: t('a) => option('a);
```
`peek_opt q` returns the first element in queue `q`, without removing it from the queue, or returns `None` if the queue is empty.

since 4\.08
```ocaml
val top : 'a t -> 'a
```
```reasonml
let top: t('a) => 'a;
```
`top` is a synonym for `peek`.

```ocaml
val drop : 'a t -> unit
```
```reasonml
let drop: t('a) => unit;
```
`drop q` removes the first element in queue `q`, or raises [`Empty`](./#exception-Empty) if the queue is empty.

since 5\.3
```ocaml
val clear : 'a t -> unit
```
```reasonml
let clear: t('a) => unit;
```
Discard all elements from a queue.

```ocaml
val copy : 'a t -> 'a t
```
```reasonml
let copy: t('a) => t('a);
```
Return a copy of the given queue.

```ocaml
val is_empty : 'a t -> bool
```
```reasonml
let is_empty: t('a) => bool;
```
Return `true` if the given queue is empty, `false` otherwise.

```ocaml
val length : 'a t -> int
```
```reasonml
let length: t('a) => int;
```
Return the number of elements in a queue.

```ocaml
val iter : ('a -> unit) -> 'a t -> unit
```
```reasonml
let iter: ('a => unit) => t('a) => unit;
```
`iter f q` applies `f` in turn to all elements of `q`, from the least recently entered to the most recently entered. The queue itself is unchanged.

```ocaml
val fold : ('acc -> 'a -> 'acc) -> 'acc -> 'a t -> 'acc
```
```reasonml
let fold: ('acc => 'a => 'acc) => 'acc => t('a) => 'acc;
```
`fold f accu q` is equivalent to `List.fold_left f accu l`, where `l` is the list of `q`'s elements. The queue remains unchanged.

```ocaml
val transfer : 'a t -> 'a t -> unit
```
```reasonml
let transfer: t('a) => t('a) => unit;
```
`transfer q1 q2` adds all of `q1`'s elements at the end of the queue `q2`, then clears `q1`. It is equivalent to the sequence `iter (fun x -> add x q2) q1; clear q1`, but runs in constant time.


## Iterators

```ocaml
val to_seq : 'a t -> 'a Seq.t
```
```reasonml
let to_seq: t('a) => Seq.t('a);
```
Iterate on the queue, in front-to-back order. The behavior is not specified if the queue is modified during the iteration.

since 4\.07
```ocaml
val add_seq : 'a t -> 'a Seq.t -> unit
```
```reasonml
let add_seq: t('a) => Seq.t('a) => unit;
```
Add the elements from a sequence to the end of the queue.

since 4\.07
```ocaml
val of_seq : 'a Seq.t -> 'a t
```
```reasonml
let of_seq: Seq.t('a) => t('a);
```
Create a queue from a sequence.

since 4\.07

## Examples


### Basic Example

A basic example:

```ocaml
# let q = Queue.create ()
val q : '_weak1 Queue.t = <abstr>


# Queue.push 1 q; Queue.push 2 q; Queue.push 3 q
- : unit = ()

# Queue.length q
- : int = 3

# Queue.pop q
- : int = 1

# Queue.pop q
- : int = 2

# Queue.pop q
- : int = 3

# Queue.pop q
Exception: Stdlib.Queue.Empty.
```

### Search Through a Graph

For a more elaborate example, a classic algorithmic use of queues is to implement a BFS (breadth-first search) through a graph.

```ocaml
  type graph = {
    edges: (int, int list) Hashtbl.t
  }

 (* Search in graph [g] using BFS, starting from node [start].
    It returns the first node that satisfies [p], or [None] if
    no node reachable from [start] satisfies [p].
 *)
 let search_for ~(g:graph) ~(start:int) (p:int -> bool) : int option =
   let to_explore = Queue.create() in
   let explored = Hashtbl.create 16 in

   Queue.push start to_explore;
   let rec loop () =
     if Queue.is_empty to_explore then None
     else
       (* node to explore *)
       let node = Queue.pop to_explore in
       explore_node node

   and explore_node node =
     if not (Hashtbl.mem explored node) then (
       if p node then Some node (* found *)
       else (
         Hashtbl.add explored node ();
         let children =
           Hashtbl.find_opt g.edges node
           |> Option.value ~default:[]
         in
         List.iter (fun child -> Queue.push child to_explore) children;
         loop()
       )
     ) else loop()
   in
   loop()

 (* a sample graph *)
 let my_graph: graph =
   let edges =
     List.to_seq [
       1, [2;3];
       2, [10; 11];
       3, [4;5];
       5, [100];
       11, [0; 20];
     ]
     |> Hashtbl.of_seq
   in {edges}

 # search_for ~g:my_graph ~start:1 (fun x -> x = 30)
 - : int option = None

 # search_for ~g:my_graph ~start:1 (fun x -> x >= 15)
 - : int option = Some 20

 # search_for ~g:my_graph ~start:1 (fun x -> x >= 50)
 - : int option = Some 100
```