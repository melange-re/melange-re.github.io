# Build system

Melange is deeply integrated with [Dune](https://dune.build/), the most widely
used build system for OCaml. This integration enables developers to create a
single project with both OCaml native executables and frontend applications that
are built with Melange, and even share code between both platforms in an easy
manner.

Dune orchestrates and plans the work needed to compile a project, copies files
when needed, and prepares everything so that Melange takes OCaml source files
and convert them into JavaScript code.

Let’s now dive into the Melange compilation model and go through a brief guide
on how to work with Dune in Melange projects.

### Compilation model

Melange compiles a single source file to a single JavaScript module. This
compilation model simplifies debugging the produced JavaScript code and allows
to import assets like CSS files and fonts in the same way as one would do in a
JavaScript project. It also facilitates the integration of Melange with
JavaScript module bundlers such as [Webpack](https://webpack.js.org/), or [other
alternatives](https://npmtrends.com/@vercel/ncc-vs-esbuild-vs-parcel-vs-rollup).

As an example of integration with Webpack, you can refer to the [Melange opam
template](https://github.com/melange-re/melange-opam-template). To create a
repository based on this template, follow [this
link](https://github.com/melange-re/melange-opam-template/generate).

### How is Melange integrated into Dune?

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
- Hygiene is maintained in Dune by building out of source: all compilation
  artifacts are placed in a separate `_build` folder. Users can optionally [copy
  them back to the source
  tree](https://dune.readthedocs.io/en/stable/reference/dune/rule.html#promote).
- Dune provides a variety of additional features including [cram
  tests](https://dune.readthedocs.io/en/stable/tests.html), integration with
  [Odoc](https://dune.readthedocs.io/en/stable/documentation.html), Melange,
  [Js\_of\_ocaml](https://dune.readthedocs.io/en/stable/jsoo.html), [watch
  mode](https://dune.readthedocs.io/en/stable/usage.html#watch-mode), Merlin/LSP
  integration for editor support, [cross
  compilation](https://dune.readthedocs.io/en/stable/cross-compilation.html),
  and [generation of `opam`
  files](https://dune.readthedocs.io/en/stable/howto/opam-file-generation.html).

#### Creating a new project

To understand how to use Dune, let’s create a small Melange application.

First of all, create an opam switch, as shown in the [package management
section](package-management.md):

```bash
opam switch create . 5.3.0 --deps-only
```

Install the latest versions of Dune and Melange in the switch:

```bash
opam update
opam install dune melange
```

<div class="text-reasonml">
As we will be using Reason syntax, let’s install the <code>reason</code> package too:

```bash
opam install reason
```
</div>

Create a file named `dune-project`. This file will tell Dune a few things about
our project configuration:

```dune
(lang dune 3.8)

(using melange 0.1)
```

The first line `(lang dune 3.8)` tells Dune which version of the "Dune language"
(the language used in `dune` files) we want to use. Melange support in Dune is
only available from version 3.8.

The second line `(using melange 0.1)` tells Dune we want to use the [Melange
extension of the Dune
language](https://dune.readthedocs.io/en/stable/reference/dune-project/using.html).

#### Adding a library

Next, create a folder `lib`, and a `dune` file inside. Put the following content
inside the `dune` file:

```dune
(library
 (name lib)
 (modes melange))
```

<div class="text-ocaml">
Create a file <code>lib.ml</code> in the same folder:
</div>
<div class="text-reasonml">
Create a file <code>lib.re</code> in the same folder:
</div>

```ocaml
let name = "Jane"
```
```reasonml
let name = "Jane";
```

The top level configuration entries —like the `library` one that appears in the
`dune` file— are referred to as _stanzas_, and the inner ones —like `name` and
`modes`— are referred to as _fields_ of the stanza.

All stanzas are well covered in the Dune documentation site, where we can find
the reference for the [`library`
stanza](https://dune.readthedocs.io/en/stable/reference/dune/library.html).

Dune is designed to minimize the need for configuration changes when modifying
the project folder structure. For example, you can move the `lib` folder to a
different location within the project, and all build commands will continue to
work without requiring any updates to any `dune` file. This feature proves to be
quite convenient.

#### Entry points with `melange.emit`

**Libraries are useful to encapsulate behavior and logical components of our
application**, but they won’t produce any JavaScript artifacts on their own.

To generate JavaScript code, we need to define an entry point of our
application. In the root folder, create another `dune` file:

```dune
(melange.emit
 (target app)
 (libraries lib))
```

<div class="text-ocaml">
  And an <code>app.ml</code> file:
</div>
<div class="text-reasonml">
  And an <code>app.re</code> file:
</div>

<!--#prelude#
module Lib = struct let name = "" end
-->
```ocaml
let () = Js.log Lib.name
```
```reasonml
let () = Js.log(Lib.name);
```

The `melange.emit` stanza tells Dune to generate JavaScript files from a set of
libraries and modules. In-depth documentation about this stanza can be found in
the [Dune
docs](https://dune.readthedocs.io/en/stable/melange.html#melange-emit).

The file structure of the app should look something like this:

<div class="language-text vp-adaptive-theme">
<pre class="text-ocaml shiki shiki-themes github-light github-dark vp-code"><code>project_name/
├── _opam
├── lib
│   ├── dune
│   └── lib.ml
├── dune-project
├── dune
└── app.ml</code></pre>
<pre class="text-reasonml shiki shiki-themes github-light github-dark vp-code"><code>project_name/
├── _opam
├── lib
│   ├── dune
│   └── lib.re
├── dune-project
├── dune
└── app.re</code></pre>
</div>

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
Node.js. As we mentioned above while going through its features, Dune places all
artifacts inside the `_build` folder to not pollute any source folders. So we
will point Node to the script placed in that folder, to see the expected output:

```bash
$ node _build/default/app/app.js
Jane
```

#### JavaScript artifacts layout

In the command above we had to look for the `app.js` file inside an `app`
folder, but we don’t have any such folder in our sources. This folder is the one
declared in the `target` field of the `melange.emit` stanza, which Dune will use
to know where to place the generated JavaScript artifacts.

As a more complex example, consider the following setup:

<div class="language-text vp-adaptive-theme">
<pre class="text-ocaml shiki shiki-themes github-light github-dark vp-code"><code>project_name/
├── dune-project
├── lib
│   ├── dune
│   └── foo.ml
└── emit
    └── dune</code></pre>
<pre class="text-reasonml shiki shiki-themes github-light github-dark vp-code"><code>project_name/
├── dune-project
├── lib
│   ├── dune
│   └── foo.re
└── emit
    └── dune</code></pre>
</div>

With `emit/dune` being:

```dune
(melange.emit
 (target app)
 (libraries lib))
```

And `lib/dune`:

```dune
(library
 (name lib)
 (modes melange))
```

<div class="text-ocaml">
Then, the JavaScript artifacts for `foo.ml` will be placed under:
</div>
<div class="text-reasonml">
Then, the JavaScript artifacts for `foo.re` will be placed under:
</div>

```text
_build/default/emit/app/lib/foo.js
```

More generically:

- For a `melange.emit` stanza defined in a `dune` file located in the relative
  workspace path `$melange-emit-folder`
- Which includes a `target` field named `$target`, like `(target $target)`
- For a source file called <code class="text-ocaml">$name.ml</code><code
  class="text-reasonml">$name.re</code>, placed in the relative workspace path
  `$path-to-source-file`

The path to the generated JavaScript file from <code
  class="text-ocaml">$name.ml</code><code class="text-reasonml">$name.re</code>
  will be:

```text
_build/default/$melange-emit-folder/$target/$path-to-source-file/$name.js
```

#### Guidelines for `melange.emit`

The following recommendations around `melange.emit` have been tested within
large industrial projects, and have proven to be helpful guidelines to deal with
complexity, maintenance and build performance.

- To simplify access to the generated JavaScript files from tools like Webpack,
  it is recommended to place the `dune` files containing the `melange.emit`
  stanzas in the project’s root folder. This ensures that the generated
  JavaScript files are directly placed under the `_build/default/$target` path.
- To minimize the risk of inadvertent increases in bundle size, it is advisable
  to reduce the number of `melange.emit` stanzas to a minimum, ideally just one.
  Having multiple `melange.emit` stanzas may result in multiple copies of
  JavaScript code generated from the same library. By consolidating the
  `melange.emit` stanzas, you can mitigate this issue and ensure more efficient
  bundle sizes.

#### Using aliases

The default `melange` alias is useful for prototyping or when working on small
projects, but larger projects might define multiple entry points or
`melange.emit` stanzas. In these cases, it is useful to have a way to build
individual stanzas. To do so, one can define explicit aliases for each one of
them by using the `alias` field.

Let’s define a custom alias `my-app` for our `melange.emit` stanza:

```dune
(melange.emit
 (target app)
 (alias my-app)
 (libraries lib))
```

Now we can refer to this new alias:

```bash
$ dune build @my-app
```

Note that if we try to build again using the default `melange` alias, Dune will
return an error, as there are no more targets attached to it.

```text
$ dune build @melange
Error: Alias "melange" specified on the command line is empty.
It is not defined in . or any of its descendants.
```

#### Handling assets

Sometimes we want to use CSS files, fonts, or other assets in our Melange
projects. Due to the way Dune works, our assets will have to be copied to the
`_build` folder and installed. To make this process as easy as possible, Dune
provides a way to specify these dependencies, depending on the stanza:

- For `library` stanzas, a field `melange.runtime_deps`
- For `melange.emit` stanzas, a field `runtime_deps`

Both fields are documented in the [Melange
page](https://dune.readthedocs.io/en/stable/melange.html#melange-emit) of the
Dune documentation site.

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

```dune
(library
 (name lib)
 (modes melange)
 (melange.runtime_deps name.txt)
 (preprocess (pps melange.ppx)))
```

<div class="text-ocaml">
Finally, update <code>lib/lib.ml</code> to read from the recently added file:
</div>
<div class="text-reasonml">
Finally, update <code>lib/lib.re</code> to read from the recently added file:
</div>

```ocaml
let dir = [%mel.raw "__dirname"]
let file = "name.txt"
let name = Node.Fs.readFileSync (dir ^ "/" ^ file) `ascii
```
```reasonml
let dir = [%mel.raw "__dirname"];
let file = "name.txt";
let name = Node.Fs.readFileSync(dir ++ "/" ++ file, `ascii);
```

After these changes, once we build the project, we should still be able to run
the application file with Node:

```bash
$ dune build @my-app
$ node _build/default/app/app.js
Jane
```

The same approach could be used to copy fonts, CSS or SVG files, or any other
asset in your project.

Dune offers great flexibility to specify dependencies. Another interesting
feature are globs, that allow to simplify the configuration when depending on
multiple files. For example:

```dune
(library
  ...
  (melange.runtime_deps
    (glob_files styles/*.css)
    (glob_files images/*.png)
    (glob_files static/*.{pdf,txt})))
```

See the [dependency specification
docs](https://dune.readthedocs.io/en/stable/concepts/dependency-spec.html) to
learn more about it.

With runtime dependencies, we have reached the end of this Dune guide for
Melange developers. For further details about how Dune works and its integration
with Melange, check the [Dune documentation](https://dune.readthedocs.io/), and
the [Melange opam
template](https://github.com/melange-re/melange-opam-template).

#### CommonJS or ES6 modules

Melange produces JavaScript modules that export the functions they declare, and
declare imports for the values and modules they depend on.

By default, Melange will produce
[CommonJS](https://en.wikipedia.org/wiki/CommonJS) modules, but it is possible
to configure it to generate
[ES6](https://en.wikipedia.org/wiki/ECMAScript#6th_Edition_-_ECMAScript_2015)
modules.

Use the `module_systems` field in the [`melange.emit`
stanza](https://dune.readthedocs.io/en/stable/melange.html#melange-emit) to emit
ES6 modules:

```dune
(melange.emit
 (target app)
 (alias my-app)
 (libraries lib)
 (module_systems es6))
```

If no extension is specified, the resulting JavaScript files will use `.js`. You
can specify a different extension with a pair `(<module_system> <extension>)`,
e.g. `(module_systems (es6 mjs))`. Multiple module systems can be used in the
same field as long as their extensions are different. For example,
`(module_systems commonjs (es6 mjs))` will produce one set of JavaScript files
using CommonJS and the `.js` extension, and another using ES6 and the `.mjs`
extension.
