# Package management

Melange can consume packages from both the [npm
registry](https://www.npmjs.com/) and the [opam
repository](https://opam.ocaml.org/packages/).

- For Melange libraries and bindings (compile-time dependencies), use one of
  the package management alternatives described in [Getting
  started](getting-started.md). The rest of this guide assumes you're using
  opam.
- For JavaScript packages required by Melange bindings (runtime dependencies),
  use [npm](https://docs.npmjs.com/cli/) (or [any of its
  alternatives](https://npmtrends.com/@microsoft/rush-vs-bolt-vs-pnpm-vs-rush-vs-yarn)).

Integrating with opam provides Melange projects with a native toolchain. Opam
has been designed for the OCaml language, and it enables Melange projects to
have first-class access to [PPXs](https://ocaml.org/docs/metaprogramming),
compiler libraries, editor integration software and other tools.

In the following sections, we explain in detail how to use opam to define the
dependencies of our application, as well as how to publish packages in the
public opam repository. However, this documentation is not exhaustive and only
covers what we believe are the most important parts for Melange developers. If
you want to learn more about opam, please refer to the [opam
manual](https://opam.ocaml.org/doc/Manual.html) and [FAQ
page](https://opam.ocaml.org/doc/FAQ.html).

## opam for Melange developers

Before diving into specifics about using opam, there are the two relevant
differences between opam and npm that are worth mentioning.

**1. One version of each package**

At any given time, any opam switch can only install *at most* a single version
of a package. This is known as a flat dependency graph, and some package
managers (like [Bower](https://bower.io/)) follow a similar approach.

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
fetched. As a package manager for a compiled language like OCaml, opam has
first-class support for this build step. Every package must tell opam how it
should be built, and the way to do this is by using the [`build`
field](https://opam.ocaml.org/doc/Manual.html#opamfield-build) in the package
`.opam` file. This is different than how npm is used: most published packages in
the npm registry don’t rely on a build step.

As Melange relies on OCaml packages for the compilation step (either PPXs,
linters, instrumentation, or any other build-time package), it’s integrated with
the native toolchain that OCaml programmers are familiar with, which relieves
library authors of the burden of creating and distributing pre-built versions of
their packages.

---

Let’s go now through the most common actions with opam when working on Melange
projects. The following guide is based on the amazing [opam for npm/yarn
users](http://ocamlverse.net/content/opam_npm.html) guide by Louis
([@khady](https://github.com/Khady)).

### Initial configuration

The first thing to do is to install opam. There is an [official documentation
page](https://opam.ocaml.org/doc/Install.html) on installation. Most of the
time, we can get it from your package manager. Otherwise, binaries are provided
for every platform.

There is a necessary first step before using opam:

```text
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

### Minimal `app.opam` file

The equivalent to `package.json` is an `app.opam` file, where `app` is the name
of the package. It is possible to have multiple opam files in the same directory
or project.

There is no opam command to manipulate the opam file. A command similar to `npm
init` or `yarn add` does not exist in opam, so the updates in `.opam` files have
to be done by hand.

A minimal `.opam` file looks like this:

```text
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

### Installing packages

The first thing we need is a local switch in the current project. To verify if a
switch exists already, we can look for a `_opam` directory at the root of the
project or use the `opam switch` command to identify if a switch already exists
in the project folder.

If it does not exist, we can create it with:

```text
opam switch create . 4.14.1 --deps-only
```

If it exists, we can install the dependencies of the project with:

```text
opam install . --deps-only
```

### Add new packages

To add a new package to the opam switch, we can do:

```text
opam install <package_name>
```

But opam will not modify the `app.opam` file during the installation, this has
to be done by hand, by adding the name of the package in the `depends` field.

### Linking packages for development

This can be achieved with `opam pin`. For example, to pin a package to a
specific commit on GitHub:

```text
opam pin add reason-react.dev https://github.com/reasonml/reason-react.git#61bfbfaf8c971dec5152bce7e528d30552c70bc5
```

Branch names can also be used.

```text
opam pin add reason-react.dev https://github.com/reasonml/reason-react.git#feature
```

For packages that are already published in the opam repository, a shortcut to
pin to the latest version is to use the `--dev-repo` flag, e.g.

```text
opam pin add melange.dev --dev-repo
```

To remove the pinning for any package, use `opam unpin <package_name>` or `opam
pin remove <package_name>`.

For other options, the command is well described in [the official
documentation](https://opam.ocaml.org/doc/Usage.html#opam-pin).

### Upgrading packages

There is one big difference compared to npm: opam stores a local copy of the
opam repository, like `apt-get` does in Debian. So before doing any upgrades, we
might want to update this copy before:

```text
opam update
```

Then, to upgrade the installed packages to the latest version, run:

```text
opam upgrade <package_name>
```

`opam upgrade` is also able to upgrade *all* the packages of the local switch if
no package name is given.

### Dev dependencies

You can use the [`with-dev-setup`
field](https://opam.ocaml.org/doc/Manual.html#pkgvar-with-dev-setup) to define
dependencies that are only required at development time. For example:

```text
depends: [
  "ocamlformat" {with-dev-setup}
]
```

This has to be combined with the `--with-dev-setup` flag when installing
dependencies, e.g. `opam install --deps-only --with-dev-setup`.

### Lock files

Lock files aren’t as used in the opam world as somewhere else, but they can be
used as follows:

- Using `opam lock` to generate the lock file when needed (basically after each
  `opam install` or `opam upgrade`).
- Adding `--locked` to all the `opam install --deps-only` and `opam switch
  create .` commands.


### Bindings and package management

When writing Melange libraries that bind to existing JavaScript packages, the
users of the Melange library will have to make sure that those JavaScript
packages are installed.

This is similar to how OCaml bindings to system libraries work, see examples
like
[`ocaml-mariadb`](https://github.com/andrenth/ocaml-mariadb/blob/9db2e4d8dec7c584213d0e0f03d079a36a35d9d5/README.md?plain=1#L18-L20)
or
[`ocurl`](https://github.com/ygrek/ocurl/blob/f0c6f47d6f3d25282648439dc4ade5810a993710/README.md?plain=1#L16).

The advantage of this approach —as opposed to vendoring the JavaScript packages
inside the bindings— is that it gives users of the bindings complete flexibility
over the way these JavaScript packages are downloaded and bundled.

## Finding and using Melange compatible packages

### opam packages

Melange packages are usually available on [opam](https://opam.ocaml.org). Package search is available in the opam CLI via `opam search <package-name>`, e.g. `opam search reason-react`. You can run `opam install <package-name>` to download, build and install opam packages in your switch. Remember that opam won't automatically add the dependency to `<your-project>.opam` file, so it must be added manually:

```text
...
depends: [
  ...
  "reason-react" {>= "0.11.0"}
]
```

To use a library from the installed package, add the library name to the `dune` file under the `libraries` field. For example, if our project structure looks like:

<pre class="text-ocaml"><code class="language-text hljs plaintext">project_name/
├── _opam
├── src
│   ├── dune
│   ├── ReactComponent1.ml
│   ├── ReactComponent2.ml
│   └── lib
│        ├── dune
│        └── data.ml
├── dune-project
├── dune
├── package.json
└── ...</code></pre>
<pre class="text-reasonml"><code class="language-text hljs plaintext">project_name/
├── _opam
├── src
│   ├── dune
│   ├── ReactComponent1.re
│   ├── ReactComponent2.re
│   └── lib
│        ├── dune
│        └── data.re
├── dune-project
├── dune
├── package.json
└── ...</code></pre>

then `reason-react` should be added to the `dune` file under the `src` folder:

```text
(melange.emit
 (target output)
 (alias react)
 (libraries lib reason-react)
 (preprocess
  (pps reactjs-jsx-ppx))
 (module_systems es6))
```

Some libraries will only work after being processed by an accompanying PPX, e.g., `reason-react` requires preprocessing with `reactjs-jsx-ppx`. These preprocessors may be installed together with the library as part of the same package, or they might be part of a different package, in which case they need to be installed separately.

### Unpublished opam packages

opam packages that have not yet been published may be installed with the `opam pin` command. For example, `opam pin add melange-fetch.dev git+https://github.com/melange-community/melange-fetch` will obtain `melange-fetch` from its Git repository and install it on your switch. Your `<your-project>.opam` file should then be updated in two places:

```text
...
depends: [
  ...
  "melange-fetch" {dev}
]
pin-depends: [
  [ "melange-fetch.dev" "git+https://github.com/melange-community/melange-fetch" ]
]
```

Once installed, the libraries included in the package can be added to the `dune` file:

```text
(melange.emit
 (target output)
 (alias react)
 (libraries lib reason-react melange-fetch)
 (preprocess
  (pps reactjs-jsx-ppx))
 (module_systems es6))
```

### npm packages

A number of Melange compatible packages can be found on npm. Many older, but still useful, compatible BuckleScript libraries can be found on npm, e.g., `bs-json`. Run `npm install @glennsl/bs-json` to add the dependency locally and record it in the `package.json` file at the root of our project.

Dune needs to be made aware of the newly installed package. The [`subdir`](https://dune.readthedocs.io/en/stable/dune-files.html#subdir) stanza can be handy in these cases:

```text
(subdir
 node_modules
 (dirs @glennsl)
 (subdir
  @glennsl/bs-json/src
  (library
   (name bs_json)
   (wrapped false)
   (modes melange))))
```

If the `dune` file contains the line `(dirs :standard \ node_modules)`, it should be removed, so that Dune can process the new Melange sources under the `node_modules` folder.

In our project structure above we have the file <code class="text-ocaml">data.ml</code><code class="text-reasonml">data.re</code> under the folder `src/lib`. If we want use the `bs-json` library from within the <code class="text-ocaml">data.ml</code><code class="text-reasonml">data.re</code> file then we need to add the library name to the `dune` file in the same folder, i.e., `src/lib/dune`:

```text
(library
 (name data)
 (libraries bs_json)
 (modes melange))
```

Note that the library `bs-json` was defined as `bs_json` in the `subdir` stanza and is referenced as `bs_json` in the `dune` file. This is necessary as Dune wrapped libraries [will only expose a single top-level module](https://dune.readthedocs.io/en/stable/explanation/ocaml-ecosystem.html#dune-is-opinionated) named after the library, so the library name has to be a valid module name. This is why library names with characters like `-` are not valid.

We can add new `subdir` stanzas for every package we'd like to consume this way. See [this dune file](https://github.com/psb/reason-react-hn-melange/blob/9983b26aebd78b445d5f44d66bb6781eccedc787/dune) for a larger example that uses multiple npm packages.
