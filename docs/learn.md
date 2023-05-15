# Learn

[TOC]

## New to OCaml?

As a backend for the OCaml compiler, Melange shares many similarities with the
OCaml language. Nevertheless, there are some notable differences between the
two. This documentation aims to clarify these distinctions. For features that
Melange inherits from OCaml, readers will be directed to the main OCaml
documentation.

If you are completely new to OCaml, it's recommended to familiarize yourself
with the language first. [Learn OCaml](https://ocaml.org/docs) is a good
starting point. but we recommend the following tutorials from the official OCaml
website:

- [A First Hour With OCaml](https://ocaml.org/docs/first-hour)
- [OCaml Exercises](https://ocaml.org/problems)

## Package management

Melange uses a dual approach to package management:

- For Melange libraries and bindings, use [opam](https://opam.ocaml.org/).
- For JavaScript packages required by Melange bindings, use
  [npm](https://docs.npmjs.com/cli/) (or [any of its
  alternatives](https://npmtrends.com/@microsoft/rush-vs-bolt-vs-pnpm-vs-rush-vs-yarn)).

This dual approach has some obvious downsides, such as forcing Melange
applications to have both an `<app_name>.opam` and a `package.json` file.
However, it unlocks the advantages of both ecosystems. As we will see below,
opam has been designed for the OCaml language, which makes the developer
experience fundamentally different from npm in the way it handles and installs
dependencies.

In the following sections, we will go through the details of how to use opam to
define the dependencies of our application, as well as how to publish packages
in the public opam repository. However, this documentation is not exhaustive and
only covers what we believe are the most important parts for Melange developers.
If you want to learn more about opam, please refer to the [opam
manual](https://opam.ocaml.org/doc/Manual.html) and [FAQ
page](https://opam.ocaml.org/doc/FAQ.html).

### opam for Melange developers

Before diving into specifics about using opam, there are the two relevant
differences between opam and npm that are worth mentioning.

**1. One version of each package**

At any given time, any opam switch can only *at most* a single version of a
package. This is known as a flat dependency graph, and some package managers in
other languages (like [Bower](https://bower.io/)) follow a similar approach.

A flat dependency graph means that, for example, it is impossible to have two
versions of [`reason-react`](https://github.com/reasonml/reason-react/)
installed in the same project. This avoids some headaches when one inadvertently
installs two versions of a dependency. Also, and specifically for Melange, it
helps keep the resulting JavaScript bundle lean and reduce page load for
browser-based applications.

On the other hand, upgrading your project dependencies to more recent versions
might become tricky. Due to the restriction where only one version of a package
can be installed, there is a higher chance for conflicts between the constraints
of the transitive dependencies. If opam cannot find a solution, these conflicts
need to be solved manually. This generally involves updating the conflicting
dependency to make it compatible with a newer version of Melange or a transient
dependency.

**2. A source-based package manager for a compiled language**

opam distributes just the source code of the packages and leaves the compilation
step to a build phase that runs when consuming them, after they have been
fetched. As the package manager for a compiled language like OCaml, opam has
first-class support for this build step. Every package must tell opam how it
should be built, and the way to do this is by using the [`build`
field](https://opam.ocaml.org/doc/Manual.html#opamfield-build) in the package
`.opam` file.

This is different from how npm handles packages. Because npm has been designed
for JavaScript (an interpreted language) having a build step makes no sense.
Whenever any project or community tries to use npm to distribute software that
includes code written in compiled languages, the burden to distribute pre-built
binaries is imposed on library authors, like [the node-sass
example](https://github.com/sass/node-sass/issues/1589) shows.

As Melange relies heavily on OCaml packages for the compilation step (either
PPXs, linters, instrumentation, or any other build-time package), using opam
provides access to these tools without library authors having to care about
creating and distributing pre-built versions of their packages.

---

Let’s go now through the most common actions with opam when working on Melange
projects. The following guide is based on the amazing [opam for npm/yarn
users](http://ocamlverse.net/content/opam_npm.html) guide by Louis
([@khady](https://github.com/Khady)).

#### Initial configuration

The first thing to do is to install opam. There is an [official documentation
page](https://opam.ocaml.org/doc/Install.html) on installation. Most of the
time, we can get it from your package manager. Otherwise, binaries are provided
for every platform.

There is a necessary first step before using opam:

```bash
opam init -a
```

Here is what the documentation of the `opam init` command says:

> The init command initialises a local "opam root" (by default, `~/.opam/`) that
> holds opam’s data and packages. This is a necessary step for normal operation
> of opam. The initial software repositories are fetched, and an initial
> 'switch' can also be installed, according to the configuration and options.
> These can be afterwards configured using opam switch and opam repository.

> Additionally, this command allows to customise some aspects of opam’s shell
> integration, when run initially (avoiding the interactive dialog), but also at
> any later time.

The interesting parts are:

- The opam root is at `~/.opam`
- opam uses shell integration to make our life easier
- opam uses the concept of a *switch*

A switch is the equivalent of the `node_modules` folder in npm’s world. It
contains all the packages that are installed. There are local switches and
global switches, in the same way we can have a `node_modules` folder local to
our project or install global dependencies using `yarn global` or `npm install
-g`. Global switches can be handy sometimes, but to avoid confusion, the
recommendation is to avoid them.

The default settings can be changed if the `-a` option is omitted while calling
`opam init`.

#### Minimal `app.opam` file

The equivalent to `package.json` is an `app.opam` file, where `app` is the name
of the package. It is possible to have multiple opam files in the same directory
or project.

There is no opam command to manipulate the opam file. A command similar to `npm
init` or `yarn add` does not exist in opam, so the updates in `.opam` files have
to be done by hand.

A minimal `.opam` file looks like this:

```
opam-version: "2.0"
name: "my-app"
authors: "Louis"
homepage: "https://github.com/khady/example"
maintainer: "ex@ample.com"
dev-repo: "git+ssh://git@github.com:khady/example.git"
bug-reports: "https://github.com/khady/example/issues"
version: "0.1"
build: [
  [ "dune" "subst" ] {pinned}
  [ "dune" "build" "-p" name "-j" jobs ]
]
depends: [
  "dune" {build}
]
```

`build:` tells opam that `dune` is needed only to build the project.

#### Installing packages

The first thing we need is a local switch in the current project. To verify if a
switch exists already, we can look for a `_opam` directory at the root of the
project or use the `opam switch` command to identify if a switch already exists
in the project folder.

If it does not exist, we can create it with:

```bash
opam switch create . 4.14.1 --deps-only
```

If it exists, we can install the dependencies of the project with:

```bash
opam install . --deps-only
```

#### Add new packages

To add a new package to the opam switch, we can do:

```bash
opam install <package_name>
```

But opam will not modify the `app.opam` file during the installation, this has
to be done by hand, by adding the name of the package in the `depends` field.

#### Linking packages for development

This can be achieved with `opam pin`. For example, to pin a package to a
specific commit on GitHub:

```bash
opam pin add reason-react.dev https://github.com/reasonml/reason-react.git#61bfbfaf8c971dec5152bce7e528d30552c70bc5
```

Branch names can also be used.

```bash
opam pin add reason-react.dev https://github.com/reasonml/reason-react.git#feature
```

A shortcut to get the latest version of a package is to use the `--dev-repo`
flag, e.g.

```bash
opam pin add reason-react.dev --dev-repo
```

To remove the pinning for any package, use `opam unpin <package_name>` or `opam
pin remove <package_name>`.

For other options, the command is well described in [the official
documentation](https://opam.ocaml.org/doc/Usage.html#opam-pin).

#### Upgrading packages

To upgrade the installed packages to the latest version, run:

```bash
opam upgrade <package_name>
```

`opam upgrade` is also able to upgrade *all* the packages of the local switch if
no package name is given.

There is one big difference compared to npm: opam stores a local copy of the
opam repository, like `apt-get` does in Debian. So we often want to update this
copy before requesting an upgrade:

```bash
opam update && opam upgrade <package_name>
```

#### Dev dependencies

You can use the [`with-dev-setup`
field](https://opam.ocaml.org/doc/Manual.html#pkgvar-with-dev-setup) to define
dependencies that are only required at development time. For example:

```
depends: [
  "ocamlformat" {with-dev-setup}
]
```

This has to be combined with the `--with-dev-setup` flag when installing
dependencies, e.g. `opam install --deps-only --with-dev-setup`.

#### Lock files

Lock files are also not common yet in the opam world, but they can be used as
follows:

- Using `opam lock` to generate the lock file when needed (basically after each
  `opam install` or `opam upgrade`).
- Adding `--locked` to all the `opam install --deps-only` and `opam switch
  create .` commands.


#### Bindings and package management

When writing Melange libraries that bind to existing JavaScript packages, the
users of the Melange library will have to make sure to install those JavaScript
packages manually.

This is similar to how OCaml bindings to system libraries work, see examples
like
[`ocaml-mariadb`](https://github.com/andrenth/ocaml-mariadb/blob/9db2e4d8dec7c584213d0e0f03d079a36a35d9d5/README.md?plain=1#L18-L20)
or
[`ocurl`](https://github.com/ygrek/ocurl/blob/f0c6f47d6f3d25282648439dc4ade5810a993710/README.md?plain=1#L16).

The advantage of this approach —as opposed to vendoring the JavaScript packages
inside the bindings— is that it gives users of the bindings complete flexibility
over the way these JavaScript packages are downloaded and bundled.

## Build system

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
section](#package-management):

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
JavaScript"](#communicate-with-javascript), it you want to learn more about how
bindings work.

So, let’s add a new file `name.txt` inside `lib` folder, that just contains the
name `Jane`.

Then, adapt the `lib/dune` file. We will need to add the `melange.runtime_deps`
field, as well as a [`preprocessing`
field](https://dune.readthedocs.io/en/stable/reference/preprocessing-spec.html)
that will allow to use the `bs.raw` extension (more about these extensions
[below](#communicate-with-javascript)), in order to get the value of the
`__dirname` environment variable:

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

## Communicate with JavaScript

Melange interoperates very well with JavaScript, and provides a wide array of
features to consume foreign JavaScript code. To learn about these techniques, we
will first map the OCaml type system to JavaScript runtime types, then we will
see the OCaml language extensions that allow these techniques to exist. Finally,
we will provide a variety of use cases with examples to show how to communicate
to and from JavaScript.

### Data types and runtime representation

This is how each Melange type is converted into JavaScript values:

Melange | JavaScript
---------------------|---------------
int | number
nativeint | number
int32 | number
float | number
string | string
array | array
tuple `(3, 4)` | array `[3, 4]`
bool | boolean
Js.Nullable.t | `null` / `undefined`
Option.t `None` | `undefined`
Option.t `Some( Some .. Some (None))` | internal representation
Option.t `Some 2` | `2`
record `{x: 1; y: 2}` | object `{x: 1, y: 2}`
int64 | array of 2 elements `[high, low]` high is signed, low unsigned
char | `'a'` -> `97` (ascii code)
bytes | number array
list `[]` | `0`
list `[x, y]` | `{ hd: x, tl: { hd: y, tl: 0 } }`
list `[1, 2, 3]` | `{ hd: 1, tl: { hd: 2, tl: { hd: 3, tl: 0 } } }`
variant | See below
polymorphic variant | See below

Variants with a single non-nullary constructor:

```ocaml
type tree = Leaf | Node of int * tree * tree
(* Leaf -> 0 *)
(* Node(7, Leaf, Leaf) -> { _0: 7, _1: 0, _2: 0 } *)
```

Variants with more than one non-nullary constructor:

```ocaml
type t = A of string | B of int
(* A("foo") -> { TAG: 0, _0: "Foo" } *)
(* B(2) -> { TAG: 1, _0: 2 } *)
```

Polymorphic Variant:

```ocaml
let u = `Foo (* "Foo" *)
let v = `Foo(2) (* { NAME: "Foo", VAL: "2" } *)
```

> **_NOTE:_** Relying on runtime representations by reading or writing them
manually from JavaScript code that communicates with Melange code might lead to
runtime errors, as these representations might be changed in the future. In
general, it is safer to leave the Melange compiler deal with the manipulation of
these runtime values and interact with them from Melange code using bindings.

Let’s see now some of these types in detail.

### Shared types

The following are types that can be shared between Melange and JavaScript almost
"as is". Specific caveats are mentioned on the sections where they apply.

#### Strings

JavaScript strings are immutable sequences of UTF-16 encoded Unicode text. OCaml
strings are immutable sequences of bytes and nowadays assumed to be UTF-8
encoded text when interpreted as textual content. This is problematic when
interacting with JavaScript code, because if one tries to use some unicode
characters, like:

```ocaml
let () = Js.log "你好"
```

It will lead to some cryptic console output. To rectify this, Melange allows to
define [quoted string
literals](https://v2.ocaml.org/manual/lex.html#sss:stringliterals) using the
`js` identifier, for example:

```ocaml
let () = Js.log {js|你好，
世界|js}
```

For convenience, Melange exposes another special quoted string identifier: `j`.
It is similar to JavaScript’ string interpolation, but for variables only (not
arbitrary expressions):

```ocaml
let world = {j|世界|j}
let helloWorld = {j|你好，$world|j}
```

You can surround the interpolation variable in parentheses too: `{j|你
好，$(world)|j}`.

To work with strings, the Melange standard library provides some utilities in
the [`Stdlib.String` module](todo-fix-me.md). The bindings to the native
JavaScript functions to work with strings are in the [`Js.String`
module](todo-fix-me.md).

#### Float

Melange floats are JavaScript numbers, and vice-versa. The Melange standard
library provides a [`Stdlib.Float` module](todo-fix-me.md). The bindings to the
JavaScript APIs that manipulate float values can be found in the
[`Js.Float`](todo-fix-me.md) module.

#### Int

**Ints are 32-bits**, because bitwise operations in JavaScript [convert the
operands to
fixed-width](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#fixed-width_number_conversion).
Melage integers compile to JavaScript numbers, but treating both as the same
might lead to unexpected behavior, because of the differences in precision: even
if bitwise operations are limited to 32 bits, integers themselves have a [max
depth of 53
bits](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#number_encoding).
When working with large numbers, it is better to use floats. For example, the
bindings in `Js.Date` use floats. The Melange standard library provides a
[`Stdlib.Int` module](todo-fix-me.md). The bindings to work with JavaScript
integers are in the [`Js.Int`](todo-fix-me.md) module.

#### Array

Melange arrays compile to JavaScript arrays. But note that unlike JavaScript
arrays, all the values in a Melange array need to have the same type. 

Another difference is that OCaml arrays are fix-sized, but on Melange side this
constraint is relaxed. You can change an array’s length using functions like
`Js.Array.push`, available in the bindings to the JavaScript APIs in
[`Js.Array`](todo-fix-me.md).

Melange standard library also has a module to work with arrays, available in
`Stdlib.Array`(todo-fix-me.md) module.

#### Tuple

OCaml tuples are compiled to JavaScript arrays. This is convenient when writing
bindings that will use a JavaScript array with heterogeneous values, but that
happens to have a fixed length.

As a real world example of this can be found in
[ReasonReact](https://github.com/reasonml/reason-react/), the Melange bindings
for [React](https://react.dev/). In these bindings, component effects
dependencies are represented as OCaml tuples, so they get compiled cleanly to
JavaScript arrays by Melange.

For example, some code like this:

```ocaml
let () = React.useEffect2 (fun () -> None) (foo, bar)
```

Will produce:

```javascript
React.useEffect(function () {}, [foo, bar]);
```

#### Bool

Values of type `bool` compile to JavaScript booleans.

#### Records

Melange records map directly to JavaScript objects. If the record fields include
non-shared data types (like variants), these values should be transformed
separately, and not be directly used in JavaScript.

Extensive documentation about interfacing with JavaScript objects using records
can be found in [the section below](#bind-to-js-object).

### Non-shared data types

The following types differ too much between Melange and JavaScript, so while
they can always be manipulated from JavaScript, it is recommended to transform
them before doing so.

- Variants and polymorphic variants: Better transform them into readable
  JavaScript values before manipulating them from JavaScript, Melange provides
  [some helpers](todo-fix-me.md) to do so.
- Exceptions
- Option (a variant type): Better use the `Js.Nullable.fromOption` and
  `Js.Nullable.toOption` functions in the [`Js.Nullable` module](todo-fix-me.md)
  to transform them into either `null` or `undefined` values.
- List (also a variant type): use `Array.of_list` and `Array.to_list` in the
  [`Array` module](todo-fix-me.md).
- Character
- Int64
- Lazy values

### Language extensions

In order to interact with JavaScript, Melange needs to extend the language to
provide blocks that express these interactions.

One approach could be to introduce new syntactic constructs (keywords and such)
to do so, for example:

```ocaml
javascript add : int -> int -> int = "function(x,y){
  return x + y
}
```

But this would break compatibility with OCaml, which is one of the main goals of
Melange.

Fortunately, OCaml provides mechanisms to extend its language without breaking
compatibility with the parser or the language. These mechanisms are composed by
two parts:
- First, some syntax additions to define parts of the code that will be extended
  or replaced
- Second, compile-time OCaml native programs called [PPX
  rewriters](https://ocaml.org/docs/metaprogramming), that will read the syntax
  additions defined above and proceed to extend or replace them

The syntax additions come in two flavors, called [extensions
nodes](https://v2.ocaml.org/manual/extensionnodes.html) and
[attributes](https://v2.ocaml.org/manual/attributes.html).

Extension nodes are blocks that are supposed to be replaced by a specific type
of PPX rewriters called extenders. Extension nodes use the `%` character to be
identified. Extenders will take the extension node and replace it with a valid
OCaml AST (abstract syntax tree).

An example where Melange uses extensions to communicate with JavaScript is to
produce "raw" JavaScript inside a Melange program: 

```ocaml
[%%bs.raw "var a = 1; var b = 2"]
let add = [%bs.raw "a + b"]
```

Which will generate the following JavaScript code:

```js
var a = 1; var b = 2
var add = a + b
```

The difference between one and two `%` characters is detailed in the [OCaml
documentation](https://v2.ocaml.org/manual/extensionnodes.html).

Attributes are "decorations" applied to specific parts of the code to provide
additional information. Melange uses attributes in various ways to enhance
communication with JavaScript code. For instance, it introduces the `bs.as`
attribute, which allows renaming of fields in a record on the generated
JavaScript code:

```ocaml
type t = {
  foo : int; [@bs.as "foo_for_js"]
  bar : string;
}

let t = { foo = 2; bar = "b" }
```

This will generate the following JavaScript code:

```js
var t = {
  foo_for_js: 2,
  bar: "b"
};
```

To learn more about preprocessors, attributes and extension nodes, check the
[section about PPX
rewriters](https://ocaml.org/docs/metaprogramming#ppx-rewriters) in the OCaml
docs.

### List of attributes and extensions

> **_NOTE:_** All these attributes and extensions are prefixed with `bs.` for
> backwards compatibility. They will be updated to `mel.` in the future.

**Attributes:**

Used to annotate `external` definitions:

- [`bs.get`](#bind-to-object-properties): read JavaScript object properties
  statically by name
- [`bs.get_index`](#bind-to-object-properties): read a JavaScript object’s
  properties dynamically by using the bracket notation `[]`
- [`bs.module`](#using-functions-from-other-javascript-modules): bind to a value
  from a JavaScript module
- [`bs.new`](#javascript-classes): bind to a JavaScript class constructor
- [`bs.obj`](#using-jst-objects): create JavaScript object
- [`bs.return`](#wrapping-returned-nullable-values): automate conversion from
  nullable values to `Option.t` values
- [`bs.send`](#calling-an-object-method): call a function that is a JavaScript
  object property
- [`bs.set`](#bind-to-object-properties): set JavaScript object properties
  statically by name
- [`bs.set_index`](#bind-to-object-properties): set JavaScript object properties
  dynamically by using the bracket notation `[]`
- [`bs.scope`](todo-fix-me.md): reach to deeper properties inside a JavaScript
  object
- [`bs.val`](#bind-to-global-javascript-functions): bind to global JavaScript
  functions
- [`bs.variadic`](#variadic-function-arguments): bind to a function taking
  variadic arguments from an array

Used to annotate arguments in `external` definitions:

- [`bs`](#binding-to-callbacks): define function arguments as uncurried (manual)
- [`bs.int`](#using-polymorphic-variants-to-bind-to-enums-and-string-types):
  compile function argument to an int
- [`bs.string`](#using-polymorphic-variants-to-bind-to-enums-and-string-types):
  compile function argument to a string
- [`bs.this`](#modeling-this-based-callbacks): bind to `this` based callbacks
- [`bs.uncurry`](#binding-to-callbacks): define function arguments as uncurried
  (automated)
- [`bs.unwrap`](#approach-2-polymorphic-variant-bsunwrap): unwrap variant values

Used in other places like records, fields, parameters, functions...:

- `bs.as`: redefine the name generated in the JavaScript output code. Used in
  [constant function arguments](#constant-values-as-arguments),
  [variants](todo-fix-me.md), [polymorphic
  variants](#using-polymorphic-variants-to-bind-to-enums-and-string-types) and
  [record fields](#objects-with-static-shape-record-like).
- [`bs.deriving`](todo-fix-me.md): generate getters and setters for some types
- [`bs.inline`](todo-fix-me.md): forcefully inline constant values
- [`bs.optional`](todo-fix-me.md): omit fields in a record (combines with
  `bs.deriving`)

**Extensions:**

In order to use any of these extensions, you will have to add the melange PPX
preprocessor to your project. To do so, add the following to the `dune` file:

```bash
(library
 (name lib)
 (modes melange)
 (preprocess
   (pps melange.ppx)))
```

The same field `preprocess` can be added to `melange.emit`.

Here is the list of all extensions supported by Melange:

- `bs.debugger`: insert `debugger` statements
- `bs.external`: read global values
- `bs.obj`: create JavaScript object literals
- `bs.raw`: write raw JavaScript code
- `bs.re`: insert regular expressions

### Foreign function interface

Most of the system that Melange exposes to communicate with JavaScript is built
on top of an OCaml language construct called `external`.

`external` is a keyword for declaring a value in OCaml that will [interface with
C code](https://v2.ocaml.org/manual/intfc.html):

```ocaml
external my_c_function : int -> string = "someCFunctionName"
```

It is like a `let` binding, except that the body of an external is a string.
That string has a specific meaning depending on the context. For native OCaml,
it usually refers to a C function with that name. For Melange, it refers to the
functions or values that exist in the runtime JavaScript code, and will be used
from Melange.

Melange externals are always decorated with certain `[@bs.xxx]` attributes.
These attributes are listed [above](#list-of-attributes-and-extensions), and
will be further explain in the next sections.

Once declared, one can use an `external` as a normal value.

Melange external functions are turned into the expected JavaScript values,
inlined into their callers during compilation, and completely erased afterwards.
They don’t appear in the JavaScript output, so there are no costs on bundling
size.

**Note**: it is recommended to use external functions and the `[@bs.xxx]`
attributes in the interface files as well, as this allows some optimizations
where the resulting JavaScript values can be directly inlined at the call sites.

#### Special identity external

One external worth mentioning is the following one:

```ocaml
type foo = string
type bar = int
external danger_zone : foo -> bar = "%identity"
```

This is a final escape hatch which does nothing but convert from the type `foo`
to `bar`. In the following sections, if you ever fail to write an `external`,
you can fall back to using this one. But try not to.

Let’s now see all the ways to use JavaScript from Melange.

### Generate raw JavaScript

It is possible to directly write JavaScript code from a Melange file. This is
unsafe, but it can be useful for prototyping or as an escape hatch.

To do it, we will use the `bs.raw`
[extension](https://v2.ocaml.org/manual/extensionnodes.html):

```ocaml
let add = [%bs.raw {|
  function(a, b) {
    console.log("hello from raw JavaScript!");
    return a + b;
  }
|}]

let () = Js.log (add 1 2)
```

The `{||}` strings are called ["quoted
strings"](https://ocaml.org/manual/lex.html#quoted-string-id). They are similar
to JavaScript’s template literals, in the sense that they are multi-line, and
there is no need to escape characters inside the string.

Using one percentage sign (`[%bs.raw <string>]`) is useful to define expressions
(function bodies, or other values) where the implementation is directly
JavaScript. This is useful as we can attach the type signature already in the
same line, to make our code safer. For example:

```ocaml
[%%bs.raw "var a = 1"]

let f : unit -> int = [%bs.raw "function() {return 1}"]
```

Using two percentage signs (`[%%bs.raw <string>]`) is reserved for definitions
in a
[structure](https://v2.ocaml.org/manual/moduleexamples.html#s:module:structures)
or [signature](https://v2.ocaml.org/manual/moduleexamples.html#s%3Asignature).

For example:

```ocaml
[%%bs.raw "var a = 1"]
```

### Debugger

Melange allows to inject a `debugger;` expression using the `bs.debugger`
extension:

```ocaml
let f x y =
  [%bs.debugger];
  x + y
```

Output:

```javascript
function f (x,y) {
  debugger; // JavaScript developer tools will set a breakpoint and stop here
  x + y;
}
```

### Detect global variables

Melange provides a relatively type safe approach to use globals that might be
defined either in the JavaScript runtime environment: `bs.external`.

`[%bs.external id]` will check if the JavaScript value `id` is `undefined` or
not, and return an `Option.t` value accordingly.

For example:

```ocaml
let () = match [%bs.external __DEV__] with
| Some _ -> Js.log "dev mode"
| None -> Js.log "production mode"
```

Another example:

```ocaml
let () = match [%bs.external __filename] with
| Some f -> Js.log f
| None -> Js.log "non-node environment"
```

### Bind to JavaScript objects

JavaScript objects are used in a variety of use cases:

- As a fixed shape
  [record](https://en.wikipedia.org/wiki/Record_(computer_science)).
- As a map or dictionary.
- As a class.
- As a module to import/export.

Melange separates the binding methods for JavaScript objects based on these four
use cases. This section documents the first three. Binding to JavaScript module
objects is described in the ["Using functions from other JavaScript
modules"](#using-functions-from-other-javascript-modules) section.

<!-- TODO: mention scope here too? -->

#### Objects with static shape (record-like)

##### Using OCaml records

If your JavaScript object has fixed fields, then it’s conceptually like an
[OCaml
record](https://v2.ocaml.org/manual/coreexamples.html#s%3Atut-recvariants).
Since Melange compiles records into JavaScript objects, the most common way to
bind to JavaScript objects is using records.

```ocaml
type person = {
  name : string;
  friends : string array;
  age : int;
}

external john : person = "john" [@@bs.module "MySchool"]
let john_name = john.name
```

This is the generated JavaScript:

```js
var MySchool = require("MySchool");

var john_name = MySchool.john.name;
```

External functions are documented in the ["Foreign function
interface"](#foreign-function-interface) section. The `bs.module` attribute is
documented [here](#using-functions-from-other-javascript-modules).

If you want or need to use different field names on the Melange and the
JavaScript sides, you can use the `bs.as` decorator:

```ocaml
type action = {
  type_ : string [@bs.as "type"]
}

let action = { type_ = "ADD_USER" }
```

Which generates the JavaScript code:

```js
var action = {
  type: "ADD_USER"
};
```

This is useful to map to JavaScript attribute names that cannot be expressed in
Melange, for example, where the JavaScript name we want to generate is a
[reserved keyword](https://v2.ocaml.org/manual/lex.html#sss:keywords).

It is also possible to map a Melange record to a JavaScript array by passing
indices to the `bs.as` decorator:

```ocaml
type t = {
  foo : int; [@bs.as "0"]
  bar : string; [@bs.as "1"]
}

let value = { foo = 7; bar = "baz" }
```

And its JavaScript generated code:

```js
var value = [
  7,
  "baz"
];
```

##### Using `Js.t` objects

Alternatively to records, Melange offers another type that can be used to
produce JavaScript objects. This type is `'a Js.t`, where `'a` is an [OCaml
object](https://v2.ocaml.org/manual/objectexamples.html).

The advantage of objects versus records is that no type declaration is needed in
advanced, which can be helpful for prototyping or quickly generating JavaScript
object literals.

Melange provides some ways to create `Js.t` object values, as well as accessing
the properties inside them. To create values, the `[%bs.obj]` extension is used,
and the `##` infix operator allows to read from the object properties:

```ocaml
let john = [%bs.obj { name = "john"; age = 99 }]
let t = john##name
```

Which generates:

```js
var john = {
  name: "john",
  age: 99
};

var t = john.name;
```

Note that type inference with objects is more lenient than with records. For
example, one can create a function that operates in all the object types that
include a field `name` that is of type string, e.g.:

```ocaml
let name_extended obj = obj##name ^ " wayne"

let one = name_extended [%bs.obj { name = "john"; age = 99 }]
let two = name_extended [%bs.obj { name = "jane"; address = "1 infinite loop" }]
```

This is possible thanks to [objects
polymorphism](https://v2.ocaml.org/manual/objectexamples.html#s%3Apolymorphic-methods),
and is a characteristic shared by some types in OCaml, like objects and
polymorphic variants. The book Real World OCaml has [a good
introduction](https://dev.realworldocaml.org/objects.html) to object
polymorphism.

##### Bind to object properties

If you need to bind only to the property of a JavaScript object, you can use
`bs.get` and `bs.set`:

```ocaml
type textarea
external set_name : textarea -> string -> unit = "name" [@@bs.set]
external get_name : textarea -> string = "name" [@@bs.get]
```

You can also use `bs.get_index` and `bs.set_index` to access a dynamic property
or an index:

```ocaml
type t
external create : int -> t = "Int32Array" [@@bs.new]
external get : t -> int -> int = "get" [@@bs.get_index]
external set : t -> int -> int -> unit = "set" [@@bs.set_index]

let () =
  let i32arr = (create 3) in
  set i32arr 0 42;
  Js.log (get i32arr 0)
```

Which generates:

```js
var i32arr = new Int32Array(3);
i32arr[0] = 42;
console.log(i32arr[0]);
```

#### Objects with dynamic shape (dictionary-like)

If you are binding to a JavaScript object that:

- might or might not add or remove keys
- contains only values that are of the same type

Then it’s not really an object, it’s a dictionary or map. Use
[Js.Dict](api/js/dict), which contains operations like `get`, `set`, etc. and
compiles to a JavaScript object.

#### JavaScript classes

JavaScript classes are special kinds of objects. To interact with classes,
Melange exposes `bs.new` to emulate e.g. `new Date()`:

```ocaml
type t
external create_date : unit -> t = "Date" [@@bs.new]
let date = create_date ()
```

Which generates:

```js
var date = new Date();
```

You can chain `bs.new` and `bs.module` if the JavaScript class you want to work
with is in a separate JavaScript module:

```ocaml
type t
external book : unit -> t = "Book" [@@bs.new] [@@bs.module]
let myBook = book ()
```

Which generates:

```js
var Book = require("Book");
var myBook = new Book();
```

### Bind to global JavaScript functions

Binding to a JavaScript function makes use of `external`, like with objects. If
we want to bind to a function available globally, Melange offers the `bs.val`
attribute:

```ocaml
external imul : int -> int -> int = "Math.imul" [@@bs.val]
```

Or for `document`:

```ocaml
(* Abstract type for the `document` value *)
type document

external document : document = "document" [@@bs.val]
```

#### Using functions from other JavaScript modules

`bs.module` is like the `bs.val` attribute, but it accepts a string with the
name of the module, or the relative path to it.

```ocaml
external dirname : string -> string = "dirname" [@@bs.module "path"]
let root = dirname "/User/github"
```

Generates:

```js
var Path = require("path");
var root = Path.dirname("/User/github");
```

#### Labeled arguments

OCaml has [labeled arguments](https://v2.ocaml.org/manual/lablexamples.html),
which can also be optional, and work with `external` as well.

Labeled arguments can be useful to provide more information about the arguments
of a JavaScript function that is called from Melange.

Let’s say we have the following JavaScript function, that we want to call from
Melange:

```js
// MyGame.js

function draw(x, y, border) {
  // let’s assume `border` is optional and defaults to false
}
draw(10, 20)
draw(20, 20, true)
```

When writing Melange bindings, we can add labeled arguments to make things more
clear:

```ocaml
external draw : x:int -> y:int -> ?border:bool -> unit -> unit = "draw"
  [@@module "MyGame"]

let () = draw ~x:10 ~y:20 ~border:true ()
let () = draw ~x:10 ~y:20 ()
```

Generates:

```js
var MyGame = require("MyGame");

MyGame.draw(10, 20, true);
MyGame.draw(10, 20, undefined);
```

The generated JavaScript function is the same, but now the usage in Melange is
much clearer.

**Note**: in this particular case, a final param of type unit, `()` must be
added after `border`, since `border` is an optional argument at the last
position. Not having the last param `unit` would lead to a warning, which is
explained in detail [in the OCaml
documentation](https://ocaml.org/docs/labels#warning-this-optional-argument-cannot-be-erased).

Note that you can freely reorder the labels on the Melange side, they will
appear in the right order on the JavaScript output:

```ocaml
external draw : x:int -> y:int -> ?border:bool -> unit -> unit = "draw"
  [@@module "MyGame"]
let () = draw ~x:10 ~y:20 ()
let () = draw ~y:20 ~x:10 ()
```

Generates:

```js
var MyGame = require("MyGame");

MyGame.draw(10, 20, undefined);
MyGame.draw(10, 20, undefined);
```

#### Calling an object method

If we need to call a JavaScript method, Melange provides the attribute
`bs.send`:

```ocaml
(* Abstract type for the `document` global *)
type document

external document : document = "document" [@@bs.val]
external get_by_id : document -> string -> Dom.element = "getElementById"
  [@@bs.send]

let el = get_by_id document "my-id"
```

```js
var el = document.getElementById("my-id");
```

When using `bs.send`, the first argument will be the object that holds the
property with the function we want to call. In the example above, we are binding
to the JavaScript object `document` using an abstract type, a very useful
technique for bindings but also in other use cases. The "Encapsulation" section
[in the OCaml Cornell
textbook](https://cs3110.github.io/textbook/chapters/modules/encapsulation.html)
provides a great overview to understand what abstract types are and when they
are useful.

##### Chaining

It is common to find this kind of API in JavaScript: `foo().bar().baz()`. This
kind of API can be designed with Melange externals and the `bs.send` attribute,
in combination with the [the pipe operator](todo-fix-me.md).

#### Variadic function arguments

Sometimes JavaScript functions take an arbitrary amount of arguments. For this
cases, Melange provides the `bs.variadic` attribute, which can be attached to
the `external` declaration. However, there is one caveat: all the variadic
arguments need to belong to the same type.

```ocaml
external join : string array -> string = "join"
  [@@bs.module "path"] [@@bs.splice]
let v = join [| "a"; "b" |]
```

Generates:

```js
var Path = require("path");
var v = Path.join("a", "b");
```

#### Bing to a polymorphic function

Some JavaScript libraries will define functions that where the arguments can
vary on both type and shape.There are two approaches to bind to those, depending
on how dynamic they are.

##### Approach 1: Multiple external functions

If it is possible to enumerate the many forms an overloaded JavaScript function
can take, a flexible approach is to bind to each form individually:

```ocaml
external drawCat : unit -> unit = "draw" [@@bs.module "MyGame"]
external drawDog : giveName:string -> unit = "draw" [@@bs.module "MyGame"]
external draw : string -> useRandomAnimal:bool -> unit = "draw"
  [@@bs.module "MyGame"]
```

Note how all three externals bind to the same JavaScript function, `draw`.

##### Approach 2: Polymorphic variant + `bs.unwrap`

In some cases, the function has a constant number of arguments but the type of
the argument can vary. For cases like this, we can model the argument as a
variant and use the `bs.unwrap` attribute in the external.

Let’s say we want to bind to the following JavaScript function:

```js
function padLeft(value, padding) {
  if (typeof padding === "number") {
    return Array(padding + 1).join(" ") + value;
  }
  if (typeof padding === "string") {
    return padding + value;
  }
  throw new Error(`Expected string or number, got '${padding}'.`);
}
```

Here, `padding` can be modeled as a polymorphic variant.

```ocaml
external padLeft:
  string
  -> ([ `Str of string
      | `Int of int
      ] [@bs.unwrap])
  -> string
  = "padLeft" [@@bs.val]

let _ = padLeft "Hello World" (`Int 4)
let _ = padLeft "Hello World" (`Str "Message from Melange: ")
```

Which produces the following JavaScript:

```js
padLeft("Hello World", 4);
padLeft("Hello World", "Message from Melange: ");
```

As we saw in the [Non-shared data types](#non-shared-data-types) section, we
should rather avoid passing variants directly to the JavaScript side. By using
`bs.unwrap` we get the best of both worlds: from Melange we can use variants,
while JavaScript gets the raw values inside them.

#### Using polymorphic variants to bind to enums and string types

Some JavaScript APIs take a limited subset of values as input. For example,
Node’s `fs.readFileSync` second argument. It can only take a few given string
values: `"ascii"`, `"utf8"`, etc.

One could still bind it just as a string, but this would not prevent from using
unsupported values. Let’s see how we can use polymorphic variants and the
`bs.string` attribute to avoid runtime errors:

```ocaml
external read_file_sync :
  name:string -> ([ `utf8 | `ascii ][@bs.string]) -> string = "readFileSync"
  [@@bs.module "fs"]

let _ = read_file_sync ~name:"xx.txt" `ascii
```

Which generates:

```js
var Fs = require("fs");
Fs.readFileSync("xx.txt", "ascii");
```

Attaching `bs.string` to the polymorphic variant type makes its constructor
compile to a string of the same name. This technique can be combined with the
`bs.as` attributes to modify the strings produced from the polymorphic variant
values, we will see an example of this just below.

Aside from producing string values, Melange also offers `bs.int` to produce
integer values:

```ocaml
external test_int_type :
  ([ `on_closed | `on_open [@bs.as 20] | `in_bin ][@bs.int]) -> int
  = "testIntType"
  [@@bs.val]

let value = test_int_type `on_open
```

In this example, `on_closed` will be encoded as 0, `on_open` will be 20 due to
the attribute `bs.as` and `in_bin` will be 21.

This code generates:

```js
var value = testIntType(20);
```

#### Using polymorphic variants to bind to event listeners

Polymorphic variants can also be used to wrap event listeners, or any other kind
of callback, for example:

```ocaml
type readline

external on :
  readline ->
  ([ `close of unit -> unit | `line of string -> unit ][@bs.string]) ->
  readline = "on"
  [@@bs.send]

let register rl =
  rl |. on (`close (fun event -> ())) |. on (`line (fun line -> Js.log line))
```

This generates:

```js
function register(rl) {
  return rl
    .on("close", function($$event) {})
    .on("line", function(line) {
      console.log(line);
    });
}
```

#### Constant values as arguments

Sometimes we want to call a JavaScript function and make sure one of the
arguments is always constant. For this, the `[@bs.as]` attribute can be combined
with the wildcard pattern `_`:

```ocaml
external process_on_exit : (_[@bs.as "exit"]) -> (int -> unit) -> unit
  = "process.on"
  [@@bs.val]

let () =
  process_on_exit (fun exit_code ->
    Js.log ("error code: " ^ string_of_int exit_code))
```

This generates:

```js
process.on("exit", function (exitCode) {
  console.log("error code: " + exitCode.toString());
});
```

The `bs.as "exit"` and the wildcard `_` pattern together will tell Melange to
compile the first argument of the JavaScript function to the string `"exit"`.

You can also use any JSON literal by passing a quoted string to `bs.as`: `bs.as
{json|true|json}` or `bs.as {json|{"name": "John"}|json}`.

#### Binding to callbacks

In OCaml, all functions have arity 1. This means that if you define a function
like this:

```ocaml
let add x y = x + y
```

Its type will be `int -> int -> int`. This means that one can partially apply
`add` by calling `add 1`, which will return another function expecting the
second argument of the addition. This kind of functions are called "curried"
functions, more information about currying in OCaml can be found in [this
chapter](https://cs3110.github.io/textbook/chapters/hop/currying.html) of the
"OCaml Programming: Correct + Efficient + Beautiful" book.

Currying is problematic when binding to JavaScript, let’s say we have a function
like this:

```javascript
function map (a, b, f){
  var i = Math.min(a.length, b.length);
  var c = new Array(i);
  for(var j = 0; j < i; ++j){
    c[j] = f(a[i],b[i])
  }
  return c ;
}
```

A naive external function declaration could be as below:

```ocaml
external map : 'a array -> 'b array -> ('a -> 'b -> 'c) -> 'c array = "map"
  [@@bs.val]
```

Unfortunately, this is not completely correct. The issue is in the callback
function, with type `'a → 'b → 'c`. This means that `map` will expect a function
like `add` described above. But as we said, in OCaml, having two arguments means
just to have two functions that take one argument.

Let’s rewrite `add` to make the problem a bit more clear:

```ocaml
let add x = let partial y = x + y in partial
```

This will be compiled to:

```javascript
function add(x) {
  return (function (y) {
    return x + y | 0;
  });
}
```

Now if we ever used our external function `map` with our `add` function by
calling `map arr1 arr2 add` it would not work as expected. JavaScript function
application does not work the same as in OCaml, so the function call in the
`map` implementation, `f(a[i],b[i])`, would be applied over the outer JavaScript
function `add`, which only takes one argument `x`, and `b[i]` would be just
discarded. The value returned from the operation would not be the addition of
the two numbers, but rather the inner anonymous callback.

To solve this mismatch between OCaml and JavaScript functions and their
application, Melange provides a special attribute `@bs` that can be used with
external functions.

In the example above:

```ocaml
external map : 'a array -> 'b array -> (('a -> 'b -> 'c)[@bs]) -> 'c array
  = "map"
  [@@bs.val]
```

Here `('a → 'b → 'c [@bs])` will be interpreted as having arity 2, in general,
`'a0 → 'a1 …​ 'aN → 'b0 [@bs]` is the same as `'a0 → 'a1 …​ 'aN → 'b0` except
the former’s arity is guaranteed to be N while the latter is unknown.

If we try now to call `map` using `add`:

```ocaml
let add x y = x + y
let _ = map [||] [||] add
```
We will get an error:

```bash
let _ = map [||] [||] add
                      ^^^
This expression has type int -> int -> int
but an expression was expected of type ('a -> 'b -> 'c) Js.Fn.arity2
```

To solve this, we add `@bs` in the function definition as well:

```ocaml
let add = fun [@bs] x y -> x + y
```

Annotating function definitions can be quite cumbersome when writing a lot of
externals.

To work around the verbosity, Melange offers another attribute called
`bs.uncurry`.

Let’s see how we could use it in the previous example. We just need to replace
`bs` with `bs.uncurry`:

```ocaml
external map :
  'a array -> 'b array -> (('a -> 'b -> 'c)[@bs.uncurry]) -> 'c array = "map"
  [@@bs.val]
```

Now if we try to call `map` with a regular `add` function:

```ocaml
let add x y = x + y
let _ = map [||] [||] add
```

Everything works fine now, without having to attach any attributes to `add`.

The main difference between `bs` and `bs.uncurry` is that the latter only works
with externals. `bs.uncurry` is the recommended option to use for bindings,
while `bs` remains useful for those use cases where performance is crucial and
we want the JavaScript functions generated from OCaml ones to not be applied
partially.

#### Modeling `this`-based Callbacks

Many JavaScript libraries have callbacks which rely on the [`this`
keyword](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/this),
for example:

```js
x.onload = function(v) {
  console.log(this.response + v)
}
```

Inside the `x.onload` callback, `this` would be pointing to `x`. It would not be
correct to declare `x.onload` of type `unit -> unit`. Instead, Melange
introduces a special attribute, `bs.this`, which allows to type `x` as this:

```ocaml
type x
external x : x = "x" [@@bs.val]
external set_onload : x -> ((x -> int -> unit)[@bs.this]) -> unit = "onload"
  [@@bs.set]
external resp : x -> int = "response" [@@bs.get]
let _ =
  set_onload x
    begin
      fun [@bs.this] o v -> Js.log (resp o + v)
    end
```

Which generates:

```javascript
x.onload = function (v) {
  var o = this;
  console.log((o.response + v) | 0);
};
```

Note that the first argument will be reserved for `this`.

#### Wrapping returned nullable values

For JavaScript functions that return a value that can be `undefined` or `null`,
Melange provides `bs.return`. Using this attribute will have Melange generated
code automatically convert the value returned by the function to an `option`
type that can be used safely from Melange side, avoiding the need to use manual
conversion functions like `Js.Nullable.toOption` and such.

```ocaml
type element
type document
external get_by_id : document -> string -> element option = "getElementById"
  [@@bs.send] [@@bs.return nullable]

let test document =
  let elem = document |. get_by_id "header" in
  match elem with
  | None -> 1
  | Some _element -> 2
```

Which generates:

```js
function test($$document) {
  var elem = $$document.getElementById("header");
  if (elem == null) {
    return 1;
  } else {
    return 2;
  }
}
```

The `bs.return` attribute takes an attribute payload, as seen with `[@@bs.return
nullable]` above. Currently 4 directives are supported: `null_to_opt`,
`undefined_to_opt`, `nullable` and `identity`.

`nullable` is encouraged, as it will convert from `null` and `undefined` to
`option` type.

<!-- When the return type is unit: the compiler will append its return value with an OCaml unit literal to make sure it does return unit. Its main purpose is to make the user consume FFI in idiomatic OCaml code, the cost is very very small and the compiler will do smart optimizations to remove it when the returned value is not used (mostly likely). -->

`identity` will make sure that compiler will do nothing about the returned
value. It is rarely used, but introduced here for debugging purpose.


TODO:
- link from all attrs and extensions to their section
- generators (do it per type? or all of them in a section?)

## Additions to OCaml
_TODO: pipe first, unicode support_

## Melange for X users

_TODO: For ReScript users, for OCaml users, for TypeScript/JavaScript users._
