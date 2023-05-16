# Build system

Melange is deeply integrated with [Dune](https://dune.build/), the most widely
used build system for OCaml. This integration enables developers to create a
single project with both OCaml native executables and frontend applications that
are built with Melange, and even share code between both platforms in an easy
manner.

The way Dune and Melange work with each other is as follows: Dune orchestrates
and plans the work needed to compile a project, copies files when needed, and
prepares everything so that Melange takes OCaml source files and convert them
into JavaScript code.

Let’s now dive into the Melange compilation model and go through a brief guide
on how to work with Dune in Melange projects.

### Compilation model

Melange compiles a single source file (either `.ml` or `.re` for
[Reason](https://reasonml.github.io/en/) syntax) to a single JavaScript module.
This simplifies debugging the produced JavaScript code and allows to import
assets like CSS files and fonts in the same way as one would do in a JavaScript
project. Even if Melange does not handle the bundling of JavaScript code for web
applications, its compilation model allows integration with tools such as
[Webpack](https://webpack.js.org/), or [other
alternatives](https://npmtrends.com/@vercel/ncc-vs-esbuild-vs-parcel-vs-rollup).

The [Melange opam template](https://github.com/melange-re/melange-opam-template)
can be used as reference, as it provides an example of how to integrate Melange
with Webpack.

### Dune for Melange developers

Dune is an OCaml build system that Melange projects can use to specify libraries
and applications. It’s optimized for monorepos and makes project maintenance
easier. This section provides an overview of Dune’s features and explains how to
use it to build Melange applications.

#### Features

Dune is designed with OCaml in mind, which makes it an ideal tool for Melange
developers. It provides several benefits, including:

- Easy specification of libraries and executables.
- Optimized for monorepos: no need for `npm link` or similar solutions.
- Easy project maintenance, as one can rearrange folders without updating the
  paths to libraries.
- Hygiene is maintained in Dune by never writing in source folders by default,
  unless explicitly configured to do so. All the compilation artifacts are
  placed in a separate `_build` folder.
- Dune provides a variety of additional features including [cram
  tests](https://dune.readthedocs.io/en/stable/tests.html), integration with
  [Odoc](https://dune.readthedocs.io/en/stable/documentation.html), Melange,
  [Js_of_ocaml](https://dune.readthedocs.io/en/stable/jsoo.html), [watch
  mode](https://dune.readthedocs.io/en/stable/usage.html#watch-mode), Merlin/LSP
  integration for editor support, [cross
  compilation](https://dune.readthedocs.io/en/stable/cross-compilation.html),
  and [generation of `opam`
  files](https://dune.readthedocs.io/en/stable/opam.html#generating-opam-files).

#### Creating a new project

To understand how to use Dune, let’s create a small Melange application using
it.

First of all, create an opam switch, like shown in the [package management
section](package-management.md):

```bash
opam switch create . 4.14.1 --deps-only
```

Install Dune and Melange in the switch:

```bash
opam install dune melange
```

Create a file named `dune-project`. This file will tell Dune a few things about
our project configuration:

```bash
(lang dune 3.8)

(using melange 0.1)
```

The first line `(lang dune 3.8)` tells Dune which version of the "Dune language"
(the language used in `dune` files) we want to use. Melange is only compatible
with versions of the Dune language equal or greater than 3.8.

The second line `(using melange 0.1)` tells Dune we want to use the [Melange
extension of the Dune
language](https://dune.readthedocs.io/en/stable/dune-files.html#using).

#### Adding a library

Next, create a folder `lib`, and a `dune` file inside. Put the following content
inside the `dune` file:

```bash
(library
 (name lib)
 (modes melange))
```

Create a file `lib.ml` in the same folder:

```ml
let name = "Jane"
```

The top level configuration entries —like the `library` one that appears in the
`dune` file— are referred to as _stanzas_, and the inner ones —like `name` and
`modes`— are referred to as _fields_ of the stanza.

All stanzas are well covered in the Dune documentation site, where we can find
the reference for the [`library`
stanza](https://dune.readthedocs.io/en/stable/dune-files.html#library).

Dune is designed to minimize changes in configuration when the project folder
structure changes, so one can move around the `lib` folder to another place
inside the project, and all build commands will still keep working without any
changes in Dune configuration. Very handy!

#### Entry points with `melange.emit`

Libraries are useful to encapsulate behavior and logical components of our
application, but they won’t produce any JavaScript artifacts on their own.

To generate JavaScript code, we need to define an entry point of our
application. In the root folder, create another `dune` file:

```bash
(melange.emit
 (target app)
 (libraries lib))
```

And an `app.ml` file:

```
let () = Js.log Lib.name
```

The `melange.emit` stanza is the one that tells Dune to generate JavaScript
files from a set of libraries and modules. In-depth documentation about this
stanza can be found on the [Dune
docs](https://dune.readthedocs.io/en/latest/melange.html).

The file structure of the app should look something like this:

```bash
project_name/
├── _opam
├── lib
│   ├── dune
│   └── lib.ml
├── dune-project
├── dune
└── main.ml
```

#### Building the project

We can build the project now, which will produce the JavaScript code from our
sources using the Melange compiler:

```bash
$ dune build @melange
```

This command tells dune to build all the targets that have an alias `melange`
attached to them.
[Aliases](https://dune.readthedocs.io/en/stable/overview.html#term-alias) are
build targets that don’t produce any file and have configurable dependencies.

By default, all the targets in a `melange.emit` stanza and the libraries it
depends on are attached to the `melange` alias. We can define explicit aliases
though, as we will see below.

If everything went well, we should be able to run the resulting JavaScript with
Node. As we mentioned while going through its features, Dune places all
artifacts inside the `_build` folder to not pollute any source folders. So we
will point Node to the script placed in that folder, to see the expected output:

```bash
$ node _build/default/app/app.js
Jane
```

One thing to note is that we have to look for the `app.js` file inside an `app`
folder, but we don’t have any such folder in our sources. The reason why this
folder is created is to support multiple `melange.emit` stanzas in the same
folder. To support this scenario, Dune will use the `target` field defined in
the `melange.emit` to place the artifacts generated from a `melange.emit` stanza
in the following folder:

```bash
_build/default/$path_to_melange_emit_stanza_directory/$target
```

This allows to have two or more `melange.emit` stanzas in the same folder
without conflicts or overrides between each other.

#### Using aliases

The default `melange` alias is useful for prototyping or when working on small
projects, but larger projects might define multiple entry points or
`melange.emit` stanzas. In these cases, it is useful to have a way to build
individual stanzas. To do so, one can define explicit aliases for each one of
them by using the `alias` field.

Let’s define a custom alias `app` for our `melange.emit` stanza: 

```bash
(melange.emit
 (target app)
 (alias app)
 (libraries lib))
```

Now, when building with Dune, we can refer to this new alias:

```bash
$ dune build @app
```

Note that if we try to build again using the default `melange` alias, Dune will
return an error, as there are no more targets attached to it.

```bash
$ dune build @melange
Error: Alias "melange" specified on the command line is empty.
It is not defined in . or any of its descendants.
```

#### Handling assets

The last topic we will go through in this demo project is asset handling.
Sometimes we want to use CSS files, fonts, or other assets in our Melange
projects. Due to the way Dune works, our assets will have to be copied to the
`_build` folder as well. To make this process as easy as possible, the Melange
integration with Dune provides two ways to do this:

- For `library` stanzas, a field `melange.runtime_deps`
- For `melange.emit` stanzas, a field `runtime_deps`

Both fields are documented in the [Melange
page](https://dune.readthedocs.io/en/latest/melange.html) of the Dune
documentation site.

For the sake of learning how to work with assets in a Melange project, let’s say
that we want to read the string in `Lib.name` from a text file. We will combine
the field `melange.runtime_deps` with some bindings to Node that Melange
provides. Check the next section, ["Communicate with
JavaScript"](communicate-with-javascript.md), it you want to learn more about
how bindings work.

So, let’s add a new file `name.txt` inside `lib` folder, that just contains the
name `Jane`.

Then, adapt the `lib/dune` file. We will need to add the `melange.runtime_deps`
field, as well as a [`preprocessing`
field](https://dune.readthedocs.io/en/stable/reference/preprocessing-spec.html)
that will allow to use the `bs.raw` extension (more about these extensions in
the ["Communicate with JavaScript"](communicate-with-javascript.md) section), in
order to get the value of the `__dirname` environment variable:

```bash
(library
 (name lib)
 (modes melange)
 (melange.runtime_deps name.txt)
 (preprocess (pps melange.ppx)))
```

Finally, update `lib/lib.ml` to read from the recently added file:

```ocaml
let dir = [%bs.raw "__dirname"]
let file = "name.txt"
let name = Node.Fs.readFileSync (dir ^ "/" ^ file) `ascii
```

After these changes, once we build the project, we should still be able to run
the application file with Node:

```bash
$ dune build @app
$ node _build/default/app/app.js
Jane
```

The same approach could be used to copy fonts, CSS or SVG files, or any other
asset in your project. Note that Dune offers great flexibility to copy runtime
assets using wildcards or globs, so one can simplify the configuration when
there are a lot of runtime dependencies, for example:

```bash
(melange.runtime_deps
 (glob_files styles/*.css)
 (glob_files images/*.png)
 (glob_files static/*.{pdf,txt}))
```

See the documentation for [glob
dependencies](https://dune.readthedocs.io/en/latest/concepts/dependency-spec.html#glob)
to learn more about it.

With runtime dependencies, we have reached the end of this Dune guide for
Melange developers. For further details about how Dune works and its integration
with Melange, check the [Dune documentation](https://dune.readthedocs.io/), and
the [Melange opam
template](https://github.com/melange-re/melange-opam-template).

