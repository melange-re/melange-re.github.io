# Communicate with JavaScript

Melange interoperates very well with JavaScript, and provides a wide array of
features to create *bindings* to JavaScript code. A binding is a piece of code
that references a JavaScript object or value and makes it available for use in
Melange code. A very basic example of a binding is:

```ocaml
external confirm : string -> bool = "window.confirm"
```
```reasonml
external confirm: string => bool = "window.confirm";
```

The above code binds JavaScript's
[window.confirm](https://developer.mozilla.org/en-US/docs/Web/API/Window/confirm)
function to a Melange function named `confirm`. Note how the binding includes
type annotations so that there's no ambiguity about the types of the arguments
and return value.

---

This section has the following pages:

- [Language concepts](/language-concepts) - Learn about the language features
  that make bindings possible
- [Data types and runtime representations](/data-types-and-runtime-rep) - See
  how Melange types map to JavaScript runtime types
- [Melange attributes and extension nodes](/attributes-and-extension-nodes) - A
  reference of all the built-in attributes and extension nodes that can be used
  to create bindings
- [Working with JavaScript objects and
  values](/working-with-js-objects-and-values) - A rundown of all the common
  scenarios when binding to JavaScript objects and values (including functions)
- [Advanced JavaScript interoperability](/advanced-js-interop.md) - Advanced
  topics such as code generation using `@deriving`
- [Bindings cookbook](/bindings-cookbook) - A collection of recipes that show
  JavaScript snippets and the equivalent code in Melange
