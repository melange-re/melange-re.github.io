# API

Melange exposes three libraries:

- A standard library, which mostly replicates that of OCaml for compatibility;
see the docs: the [`Stdlib`](../_html/melange/Stdlib) library
- Bindings to several browser and Node JavaScript APIs in the [`Js`
  library](../_html/melange/Js).
- Data structures and collection types in the [`Belt`
  library](../_html/melange/Belt)

Using one or the other will depend on your application requirements, how much
integration you need with existing JavaScript libraries, or other specific
characteristics of your project. In any case, the three of them can be used in
the same project without issues.
