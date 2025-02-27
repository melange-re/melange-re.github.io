# Supported syntaxes

Melange supports two syntaxes: [OCaml
syntax](https://ocamlpro.github.io/ocaml-cheat-sheets/ocaml-lang.pdf) (the
default) and [Reason syntax](https://reasonml.github.io/). You can toggle
between them by using the "Syntax" widget in the top left corner of this page.
Try clicking on it now to see the two different versions of the following code
snippet:

```ocaml
module Speech = struct
  type utterance

  external makeUtterance : string -> utterance = "SpeechSynthesisUtterance"
  [@@mel.new]

  external speak : utterance -> unit = "speechSynthesis.speak"
end

module App = struct
  let style =
    ReactDOM.Style.make ~fontSize:"1em" ~border:"1px solid white"
      ~borderRadius:"0.5em" ~padding:"1em" ()

  let make () =
    (button ~style
       ~onClick:(fun _ ->
         "Hello ReasonReact" |> Speech.makeUtterance |> Speech.speak)
       ~children:[ React.string "Say hello" ]
       () [@JSX])
  [@@react.component]
end

let () =
  match ReactDOM.querySelector "#preview" with
  | None -> Js.log "Failed to start React: couldn't find the #preview element"
  | Some root ->
      let root = ReactDOM.Client.createRoot root in
      ReactDOM.Client.render root (App.createElement ~children:[] () [@JSX])
```
```reasonml
module Speech = {
  type utterance;

  [@mel.new]
  external makeUtterance: string => utterance = "SpeechSynthesisUtterance";

  external speak: utterance => unit = "speechSynthesis.speak";
};

module App = {
  let style =
    ReactDOM.Style.make(
      ~fontSize="1em",
      ~border="1px solid white",
      ~borderRadius="0.5em",
      ~padding="1em",
      (),
    );

  [@react.component]
  let make = () =>
    <button
      style
      onClick={_ =>
        "Hello ReasonReact" |> Speech.makeUtterance |> Speech.speak
      }>
      {React.string("Say hello")}
    </button>;
};

let () =
  switch (ReactDOM.querySelector("#preview")) {
  | None =>
    Js.log("Failed to start React: couldn't find the #preview element")
  | Some(root) =>
    let root = ReactDOM.Client.createRoot(root);
    ReactDOM.Client.render(root, <App />);
  };
```

As you can see, Reason syntax resembles JavaScript and supports JSX, so it is
more approachable to JavaScript and TypeScript developers.

## Installation

### Reason syntax

To install Reason syntax support add `reason` to the `depends` section of the
`<project-name>.opam` file in your project's root directory:

```opam
depends: [
  "ocaml"
  "reason" {>= "3.10.0"} # [!code ++]
  "dune" {>= "3.9"}
  "melange" {>= "2.0.0"}
  "reason-react" {>= "0.13.0"}
  "reason-react-ppx"
  "opam-check-npm-deps" {with-dev-setup}
  "ocaml-lsp-server" {with-dev-setup}
  "dot-merlin-reader" {with-setup}
  "odoc" {with-doc}
]
```

On the command line, run[^1]

```bash
opam install -y . --deps-only
```

Note that Reason support is already set up for you in
[melange-opam-template](https://github.com/melange-re/melange-opam-template).

### OCaml syntax

OCaml syntax is supported by default, but to get formatting support, you should
add `ocamlformat` to the `depends` section of the `<project-name>.opam` file in
your project's root directory:

```opam
depends: [
  "ocaml"
  "dune" {>= "3.9"}
  "melange" {>= "2.0.0"}
  "reason-react" {>= "0.13.0"}
  "reason-react-ppx"
  "ocamlformat" {with-dev-setup} # [!code ++]
  "opam-check-npm-deps" {with-dev-setup}
  "ocaml-lsp-server" {with-dev-setup}
  "dot-merlin-reader" {with-setup}
  "odoc" {with-doc}
]
```

On the command line, run[^2]

```bash
opam install -y . --deps-only --with-dev-setup
```

## VS Code configuration

First, make sure you've already [installed and configured OCaml Platform VS Code
extension](getting-started#editor-integration).

### Reason syntax

1. To enable format-on-save in VS Code, open your [User Settings JSON
   file](https://code.visualstudio.com/docs/getstarted/settings#_settingsjson)
   and add this snippet:

   ```json
   "[reason]": {
    "editor.formatOnSave": true
   },
   ```

1. To control how the Reason formatter breaks up long lines, you can also add
   this snippet:

   ```json
   "ocaml.server.extraEnv": {
     "REFMT_PRINT_WIDTH": "120"
   },
   ```

   In the snippet above, the print width is set to 120 characters, but you can
   use any number you prefer. If you don't set this, the default is 80.

### OCaml syntax

1. Add `.ocamlformat` to your project's root directory. If you want to change
   the print width, add this to the file:

   ```ini
   m=120
   ```

   In the snippet above, the print width is set to 120 characters, but you can
   use any number you prefer. If you don't set this, the default is 80.
1. To enable format-on-save in VS Code, open your [User Settings JSON
   file](https://code.visualstudio.com/docs/getstarted/settings#_settingsjson)
   and add this snippet:

   ```json
   "[ocaml]": {
     "editor.formatOnSave": true
   },
   ```

## Other editors

For Reason syntax, check out [Editor
Plugins](https://reasonml.github.io/docs/en/editor-plugins) page from Reason
documentation.

For OCaml syntax, check out the [Editor
Setup](https://ocamlverse.net/content/editor_setup.html) page from OCamlverse.

## Formatters

You can run this command to check the format of all your OCaml source files:

```bash
dune build @fmt
```

If Reason syntax support is installed, it will automatically check the format of
all Reason sources files (`.re` and `.rei`).

To automatically fix the formatting, run this:

```bash
dune build @fmt --auto-promote
```

[^1]: Alternatively, you can first run `opam install -y reason` and then add the
    appropriate entry to your `<project-name>.opam` file.

[^2]: Alternatively, you can first run `opam install -y ocamlformat` and then
    add the appropriate entry to your `<project-name>.opam` file.
