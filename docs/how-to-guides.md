# How-to guides 

## Migrate a ReScript library to Melange

It is possible to use existing [ReScript](https://rescript-lang.org/) (formerly
BuckleScript) code with Melange, mostly as is. However, as both projects evolve
in different directions over time, it will become more challenging to do so as
time goes by, as some of the most recent features of ReScript might not be
directly convertible to make them work with Melange.

For this reason, the recommendation is to migrate libraries at a time where they
were compatible with past versions of ReScript, for example v9 (or v10 at most).

These are the steps to follow:

- Add an `opam` file
- Add a `dune-project` file
- Replace the `bsconfig.json` file with one or multiple `dune` files
- (Optional) Migrate from ReScript syntax to Reason or OCaml syntaxes
- Make sure everything works: `dune build`
- Final step: remove `bsconfig.json` and adapt `package.json`

Let's go through them in detail:

### Add an `opam` file

To migrate your ReScript library to Melange, you will need some packages.
Melange is designed to be used with [opam](opam.ocaml.org/), the package manager
of OCaml, which is explained in [its own section](./package-management.md).

To get started with the library migration, let's create an `opam` file in your
library's root folder with the minimum set of packages to start working:

```text
opam-version: "2.0"
synopsis: "My Melange library"
description: "A library for Melange"
maintainer: ["<your_name>"]
authors: ["<your_name>"]
license: "XXX"
homepage: "https://github.com/your/project"
bug-reports: "https://github.com/your/project/issues"
depends: [
  "ocaml"
  "dune"
  "melange"
]
dev-repo: "git+https://github.com/your/project.git"
```

If your library was using [Reason syntax](https://reasonml.github.io/en/) (`re`
files), you will need to add `"reason"` to the list of dependencies. If the
library was using ReScript syntax (`res` files), you will need to add
`rescript-syntax` to the list of dependencies. You can read more about how to
migrate from ReScript syntax in the section below.

At this point, we can create a [local opam
switch](https://opam.ocaml.org/blog/opam-local-switches/) to start working on
our library:

```bash
opam switch create . 5.1.0~rc2 -y --deps-only
```

Once this step is done, we can call `dune` from the library folder, but first we
need some configuration files.

### Add a `dune-project` file

Create a file named `dune-project` in the library root folder. This file will
tell Dune a few things about our project configuration:

```text
(lang dune 3.8)

(using melange 0.1)
```

### Replace the `bsconfig.json` file with one or multiple `dune` files

Now, we need to add a `dune` file where we will tell Dune about our library. You
can put this new file next to the library sources, it will look something like
this:

```text
(library
 (name things)
 (modes melange)
 (preprocess (pps melange.ppx)))
```

Let's see how the most common configurations in `bsconfig.json` (or
`rescript.json`) map to `dune` files. You can find more information about these
configurations in the [Rescript
docs](https://rescript-lang.org/docs/manual/latest/build-configuration) and in
the [Dune docs](https://dune.readthedocs.io/en/stable/dune-files.html#library).

#### `name`, `namespace`

These two configurations map to Dune `(wrapped <boolean>)` field in the
`library` stanza. By default, all Dune libraries are wrapped, which means that a
single module with the name of the library is exposed at the top level. So e.g.
of your `bsconfig.json` had `"namespace": false`, you can add `(wrapped false)`
to your library, although wrapped libraries are heavily encouraged to avoid
global namespace pollution.

It's important to note that the permissible character range for naming
conventions differs between ReScript namespaces and Dune libraries. Dune library
names must adhere to the naming criteria set for OCaml modules. For instance, if
your `bsconfig.json` configuration includes a naming scheme like this:

```json
{
  "namespace": "foo-bar"
}
```

It should be converted into something like:

```text
(library
 (name fooBar) # or (name foo_bar)
 (modes melange)
 (preprocess (pps melange.ppx)))
```

#### `sources`

Dune works slightly differently than ReScript when it comes down to including
source folders as part of a library.

By default, when Dune finds a `dune` file with a `library` stanza, it will
include just the files inside that folder to the library itself (unless the
`modules` field is used). If you want to create a library with multiple
subfolders in it, you can use the following combination of stanzas:

- `(include_subdirs unqualified)`
  ([docs](https://dune.readthedocs.io/en/stable/dune-files.html#include-subdirs)):
  This stanza tells Dune to look for sources in all the subfolders of the folder
  where the `dune` file lives.
- `(dirs foo bar)`
  ([docs](https://dune.readthedocs.io/en/stable/dune-files.html#dirs)): This
  stanza tells Dune to only look into `foo` and `bar` subdirectories of the
  current folder.

So for example, if your library had this configuration in its `bsconfig.json`:

```json
{
  "sources": ["src", "helper"]
}
```

You might translate this to a `dune` file with the following configuration:

```text
(include_subdirs unqualified)
(dirs src helper)
(library
 (name things)
 (modes melange)
 (preprocess (pps melange.ppx)))
```

Alternatively, depending on the case, you could place two separate `dune` files,
one in `src` and one in `helper`, and define one `library` on each. In that
case, `include_subdirs` and `dirs` would not be necessary.

Regarding the `"type" : "dev"` configuration in ReScript, the way Dune solves
that is with public and private libraries. If a `library` stanza includes a
`public_name` field, it becomes a public library, and will be installed.
Otherwise it is private and won't be visible by consumers of the package.

#### `bs-dependencies`

Your library might depend on other libraries. To specify dependencies of the
library in the `dune` file, you can use the `libraries` field of the `library`
stanza.

For example, if `bsconfig.json` had something like this:

```json
"bs-dependencies": [
  "reason-react"
]
```

Your `dune` file will look something like:

```text
(library
 (name things)
 (libraries reason-react)
 (modes melange)
 (preprocess (pps melange.ppx)))
```

Remember that you will have to add all dependencies to your library `opam`
package as well.

#### `bs-dev-dependencies`

Most of the times, `bs-dev-dependencies` is used to define dependencies required
for testing. For this scenario, opam provides the `with-test` variable.

Supposing we want to add `melange-jest` as a dependency to use for tests, you
could add this in your library `opam` file:

```text
depends: [
  "melange-jest" {with-test}
]
```

The packages marked with this variable [become
dependencies](https://opam.ocaml.org/doc/Manual.html#opamfield-depends) when
`opam install` is called with the `--with-test` flag.

Once the library `melange-jest` has been installed by opam, it is available in
Dune, so adding `(libraries melange-jest)` to your `library` or `melange.emit`
stanzas would be enough to start using it.

#### `pinned-dependencies`

Dune allows to work inside monorepos naturally, so there is no need for pinned
dependencies.
[Packages](https://dune.readthedocs.io/en/stable/reference/packages.html) can be
defined in the `dune-project` file using the `packages` stanza, and multiple
`dune-project` files can be added across a single codebase to work in a monorepo
setup.

#### `external-stdlib`

There is no direct mapping of this functionality in Melange. If you are
interested in it, or have a use case for it, please share with us on [issue
melange-re/melange#620](https://github.com/melange-re/melange/issues/620).

#### `js-post-build`

You can use Dune rules to perform actions, that produce some targets, given some
dependencies.

For example, if you had something like this in `bsconfig.json`:

```json
{
  "js-post-build": {
    "cmd": "node ../../postProcessTheFile.js"
  }
}
```

This could be expressed in a `dune` file with something like:

```text
(rule 
  (deps (alias melange))
  (action (run node ../../postProcessTheFile.js))
)
```

To read more about Dune rules, check [the
documentation](https://dune.readthedocs.io/en/stable/dune-files.html#rule).

#### `package-specs`

This setting is not configured at the library level, but rather at the
application level, using the `module_systems` field in the `melange.emit`
stanza. To read more about it, check the corresponding [build
system](./build-system.md#commonjs-or-es6-modules) section.

Regarding the `"in-source"` configuration, the corresponding field in Dune would
be the `(promote (until-clean))` configuration, which can be added to a
`melange.emit` stanza. You can read more about it in [the Dune
documentation](https://dune.readthedocs.io/en/stable/dune-files.html#promote).

#### `suffix`

Same as with `package-specs` this configuration is set at the application level,
using the `module_systems` field in the `melange.emit` stanza. Check the
[CommonJS or ES6 modules](./build-system.md#commonjs-or-es6-modules) section to
learn more about it.

#### `warnings` and `bsc-flags`

You can use the [`flags`
field](https://dune.readthedocs.io/en/stable/concepts/ocaml-flags.html) of the
`library` stanza to define flags to pass to Melange compiler.

If you want to define flags only for Melange, you can use
`melange.compile_flags`.

For example, if you had a `bsconfig.json` configuration like this:

```json
{
  "warnings": {
    "number": "-44-102",
    "error": "+5"
  }
}
```

You can define a similar configuration in your library `dune` file like this:

```text
(library
 (name things)
 (modes melange)
 (preprocess (pps melange.ppx))
 (melange.compile_flags :standard -w +5-44-102))
```

The same applies to `bsc-flags`.

### (Optional) Migrate from ReScript syntax to Reason or OCaml syntax

The package `rescript-syntax` allows to translate `res` source files to `ml`.

To use this package, we need to install it first:

```bash
opam install rescript-syntax
```

> Note that the `rescript-syntax` package is only compatible with the version 1
> of `melange`, so if you are using a more recent version of `melange`, you
> might need to downgrade it before installing `rescript-syntax`.

To convert a `res` file to `ml` syntax:

```bash
rescript_syntax myFile.res -print ml > myFile.ml
```

You can use this command in combination with `find` to convert multiple files at
once:

```bash
find src1 src2 -type f -name "*.res" -exec echo "rescript_syntax {} -print ml" \;
```

If you want to convert the files to Reason syntax (`re`), you can pipe the
output of each file to `refmt`.

```bash
rescript_syntax ./myFile.res -print ml | refmt --parse=ml --print re > myFile.re
```

Note that `refmt` is available in the `reason` package, so if your library
modules are written using Reason syntax, remember to install it first using
`opam install reason` before performing the conversion, and also adding it to
your library `opam` file as well.

### Make sure everything works: `dune build`

Once you have performed the above steps, you can test that everything works by
running

```bash
dune build
```

Throughout the process, you might run into some errors, these are the most
common ones:

#### Warning 16 [unerasable-opt-argument] is triggered more often than before

Melange triggers `Warning 16: this optional argument cannot be erased` more
often than before, as the type system in OCaml 4.12 was improved. You can read
more about this in this [OCaml PR](https://github.com/ocaml/ocaml/pull/9783).

**Fix**: either add `()` as final param of the function, or replace one labelled
arg with a positional one.

#### Warning 69 [unused-field] triggered from bindings types

Sometimes, types for bindings will trigger `Warning 69 [unused-field]: record
field foo is never read.` errors.

**Fix**: silence the warning in the type definition, e.g.

```ocaml
type renderOptions = { 
  foo : string
} [@@warning "-69"]
```

#### Destructuring order is changed

Destructuring in `let` patterns in Melange is done on the left side first, while
on ReScript is done on the right side first. You can read more in the [Melange
PR](https://github.com/melange-re/melange/pull/161) with the explanation.

**Fix**: move module namespacing to the left side of the `let` expressions.

#### `Pervasives` is deprecated

This is also another change due to OCaml compiler moving forward.

**Fix**: Use `Stdlib` instead.

#### Runtime assets are missing

In ReScript, building in source is very common. In Melange and Dune, the most
common setup is having all artifacts inside the `_build` folder. If your library
is using some asset such as:

```ocaml
external myImage : string = "default" [@@bs.module "./icons/overview.svg"]
```

**Fix**: You can include it by using the `melange.runtime_deps` field of the
library:

```text
(library
 (name things)
 (modes melange)
 (preprocess (pps melange.ppx))
 (melange.runtime_deps icons/overview.svg))
```

You can read more about this in the [Handling
assets](./build-system.md#handling-assets) section.

### Final step: remove `bsconfig.json` and adapt `package.json`

If everything went well, you can remove the `bsconfig.json` file, and remove any
dependencies needed by Melange from the `package.json`, as they will be
appearing in the `opam` file instead, as it was mentioned in the
[`bs-dependencies` section](#bs-dependencies).

## Migrate

This section contains information about migrating from older versions of Melange
to newer ones.

### To v2 from v1

Melange v2 is only compatible with OCaml 5.1. In order to upgrade, let's update
the local opam switch first, to make sure the local repository gets the versions
v2 of Melange and 5.1 of OCaml:

```bash
opam update
```

Now, update the version of the OCaml compiler in the local switch to 5.1:

```bash
opam install --update-invariant ocaml-base-compiler.5.1.0
```

Finally, we can upgrade all packages to get Melange v2 and the latest version of
all libraries:

```bash
opam upgrade
```

To make sure you have the latest version of Melange, you can use the `opam list`
subcommand:

```bash
opam list --installed melange
# Packages matching: name-match(melange) & installed
# Name  # Installed    # Synopsis
melange 2.0.0          Toolchain to produce JS from Reason/OCaml
```

Before building, we have to update some parts of the configuration to make it
work with v2.

#### `melange.ppx` now includes most syntax transformations

Most of the attributes used to write bindings are now handled by `melange.ppx`.
If you get errors of the kind `Unused attribute`, or type errors in externals
that don't make much sense, then you probably need to add `melange.ppx` to your
`library` or ` melange.emit` stanzas.

```
(library
 ...
 (preprocess
  (pps melange.ppx)))
```

#### Warnings have been turned into alerts

Some warnings were turned into alerts, so they might be visible even if using
`vendored_dirs`. To silence these alerts, either fix the root cause or silence
them using `(preprocess (pps melange.ppx -alert -deprecated))`.

#### Wrapped libraries

Melange libraries like Belt and Js are now wrapped, so the access to modules
inside them need to be adapted. Some examples:

- `Js_string` needs to be replaced with `Js.String`
- `Belt_MapInt` is now `Belt.Map.Int`

#### Changes in `deriving`

The `bs.deriving` attribute is replaced with `deriving`. Also, the payload taken
by this attribute has been adapted to conform to ppxlib requirements. Note that
`mel.deriving` is not accepted.

Let's see how the payload has changed in both OCaml and Reason syntaxes.

In Ocaml syntax:

| Before  | After |
|---------------|---------------|
| `[@@bs.deriving { jsConverter =  newType  }]` | `[@@deriving  jsConverter {  newType }  ]` |
| `[@@deriving { abstract = light }]` | `[@@deriving abstract { light }]` |


In Reason syntax:

| Before  | After |
|---------------|---------------|
| `[@bs.deriving {jsConverter: newType}]` | `[@deriving jsConverter({newType: newType})]`  |
| `[@deriving {abstract: light}]` | `[@deriving abstract({light: light})]`  |

#### `bs.*` attributes and extensions become `mel.*`

All attributes or extension nodes prefixed with `bs` are now prefixed with `mel`
instead.

For example `@bs.as` becomes `@mel.as`, and `%bs.raw` becomes `%mel.raw`.

Note that attributes in the deprecated form (`@bs.*`) are still accepted until
v3, but node extensions (`%bs.*`) are not.

#### `@bs` attribute becomes `@u`

The `@bs` attribute, used for uncurried application (see the ["Binding to
callbacks" section](./communicate-with-javascript.md#binding-to-callbacks)),
becomes `@u`.

#### `@bs.val` is gone

The `@bs.val` attribute is no longer necessary, and can be removed from
`external` definitions. See more information in the ["Using global functions or
values"](./communicate-with-javascript.md#using-global-functions-or-values)
section.

#### `Dom` and `Node` are in their own libraries

The namespaces `Dom` and `Node` are now in the libraries `melange.dom` and
`melange.node` respectively. These libraries are not included by default by
Melange, and will need to be added to the `libraries` field explicitly.

#### Effect handlers 

Although Melange v2 requires OCaml 5.1, it doesn't yet provide a good solution
for compiling effect handlers to JavaScript. Until it does, they are disabled at
the compiler level, and their APIs are not accessible.
