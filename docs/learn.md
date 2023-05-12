# Learn

## New to OCaml?

As a backend for the OCaml compiler, Melange shares many similarities with the
OCaml language. Nevertheless, there are some notable differences between the
two. This documentation aims to clarify these distinctions. For features that
Melange inherits from OCaml, readers will be directed to the main OCaml
documentation.

If you are completely new to OCaml, you might want to get familiar first with
the language, there are [plenty of resources available](https://ocaml.org/docs),
but we recommend the following tutorials from the official OCaml website:

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
time, we can simply get it from your package manager. Otherwise, binaries are
provided for every platform.

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
to be done by hand. It is as simple as adding the name of the package in the
`depends` field.

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
that will allow to use the `bs.raw` extension, in order to get the value of the
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

_TODO: Sections will be something like:_
```
- intro: explain attributes, extensions, and `bs.` backwards compatibility
- `melange.ppx` preprocessor and extensions
- data types
- call javascript from melange:
  - intro to external (link to OCaml docs)
  - bindings with external (to functions, objects or other values)
  - global values
- call melange from javascript
```

## Additions to OCaml
_TODO: pipe first_

## Melange for X users

_TODO: For ReScript users, for OCaml users, for TypeScript/JavaScript users._
