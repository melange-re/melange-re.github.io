---
title: Unlocking Universal Libraries in Dune
date: 2024-04-10
author: Antonio Monteiro
gravatar: 45c2052f50f561b9dc2cae59c777aecd794f57269fa317f9c9c3365c2e00d16f
twitter: '@_anmonteiro'
---

I recently shared a [2024 progress
update](whats-2024-brought-to-melange-so-far) about our work on Melange. In
that message, I briefly wrote about "universal libraries" in Dune, the ability
to write a shared OCaml / Melange codebase while varying specific module
implementations, flags, preprocessing steps, etc. according to the compilation
target.

I also promised to dive deeper into what "universal libraries" are all about,
and the new use cases that they unlock in Dune. Keep reading for an in-depth
look at the history behind this new feature rolling out in Dune 3.16.

---

## The Bird's-eye View

Let's walk backwards from our end-goal: having a shared OCaml / Melange
codebase that can render React.js components on the server, such that the
[Ahrefs](https://ahrefs.com) website can be rendered on the server without
JavaScript. And, finally, having React.js hydrate the server-rendered HTML in
the browser. [Dave](https://twitter.com/davesnx) explains the motivation behind
this goal in more depth [in his blog
](https://sancho.dev/blog/server-side-rendering-react-in-ocaml).

To look at a specific example, we'll start with a Melange codebase already
using [`reason-react`](https://github.com/reasonml/reason-react). Our goal is
to get those `reason-react` components to compile server-side with the OCaml
compiler, where we'll use
[`server-reason-react`](https://github.com/ml-in-barcelona/server-reason-react)
as a drop-in replacement for `reason-react`.


What gets in our way is that:

- not everything is supported on both sides: some Melange modules use APIs that
  don't exist in OCaml (and extensive shimming is undesirable).
  - vice-versa on the Melange side; especially code that calls into C bindings.
- we can't vary what implementation to use inside a module or conditionally
  apply different preprocessing steps and/or flags.

In summary, we would like to to vary specific module implementations across the
same library, based on their compilation target. If we try to use it in a
real-world codebase, we'll also find the need to vary preprocessing
definitions, compilation flags, the set of modules belonging to the library –
effectively most fields in the `(library ..)` stanza.

## A First ~~Hack~~ Approach

We concluded that it would be desirable to write two library definitions. That
would allow us to configure each `(library ..)` stanza field separately,
achieving our goal.

But Dune doesn't allow you to have two libraries with the same name. How could
it? If Dune derives the artifact directory for libraries from their `(name ..)`
field, two conflicting names compete for the same artifact directory.

So we first tried to work around that, and set up:

- unwrapped (`(wrapped false)`) Dune libraries with different names
    - with unwrapped libraries, we could share modules across compilation
      targets, e.g. `react.ml` originating from both `reason-react` and
      `server-reason-react`;
- defined in different directories;
- `(copy_files ..)` from one of the directories into the other, duplicating
  shared modules.
    - Modules with the same name and different implementations, specifc to each
      directory.

```clj
;; native/dune
(library
 (name native_lib)
 (wrapped false)
 (modules a b c))

;; melange/dune
(library
 (name melange_lib)
 (wrapped false)
 (modes melange)
 (modules a b c))

;; Copy modules `A` and `B` from `../native`
(copy_files# ../native
 (files {a,b}.ml{,i}))

;; module `C` has a specific Melange implementation
(rule
 (with-stdout-to c.ml
  (echo "let backend = \"melange\"")))
```

This worked until it didn't: we quickly ran into a limitation in `(copy_files
..)` ([dune#9709](https://github.com/ocaml/dune/issues/9709)). Because this
stanza operates in the build directory, it was impossible to exclude some of
build artifacts that get generated with `.ml{,i}` extensions from the copy glob
– Dune uses extensions such as `.pp.ml` and `.re.pp.ml` as targets of its
[dialect](https://dune.readthedocs.io/en/stable/overview.html#term-dialect) and
[preprocessing](https://dune.readthedocs.io/en/stable/reference/preprocessing-spec.html)
phases.

## Limiting `(copy_files ..)` to source-files only

What we would want from `copy_files` in our scenario is the ability to limit
copying only to files that are present in source. That way we can address all
the `.re{,i}` and `.ml{,i}` files in source directories without worrying about
polluting our target directories with some intermediate Dune targets.

In [dune#9827](https://github.com/ocaml/dune/pull/9827), we added a new option
to `copy_files` that allows precisely that: if the field `(only_sources
<optional_boolean_language>)` is present, Dune will only match files in the
source directory, and won't apply the glob to the targets of rules.

After this change, our Dune file just needs to contemplate one more line:

```diff
 ;; Copy modules `A` and `B` from `../native`
 (copy_files# ../native
+ (only_sources)
  (files {a,b}.ml{,i}))
```


## Checkpoint

Our Dune file allows us to move forward. We were now able to define multiple
libraries that share common implementations across native code and Melange.
Though library names still need to be different. And, overall, we still face
some other glaring limitations:

- The `(wrapped false)` requirement makes it impossible to namespace these
  libraries;
- Defining libraries in different directories and using `copy_files` places
  extra separation between common implementations, and adds extra build
  configuration overhead;
- Publishing a library with `(modes :standard melange)` adds a non-optional
  dependency on Melange, which should really be optional for native-only
  consumers.

## Testing a New Solution

We became intentful on removing these limitations, and realized at some point
that our use case is somewhat similar to cross-compilation, which Dune [already
supports well](https://dune.readthedocs.io/en/stable/cross-compilation.html).
The key insight, which we shared in a Dune proposal
([dune#10222](https://github.com/ocaml/dune/issues/10222)), is that we could
share library names as long as they resolved to a single library per [build
context](https://dune.readthedocs.io/en/stable/reference/dune-workspace/context.html).

After making the proposed changes to Dune
([dune#10220](https://github.com/ocaml/dune/pull/10220),
[dune#10307](https://github.com/ocaml/dune/pull/10307),
[dune#10354](https://github.com/ocaml/dune/pull/10354),
[dune#10355](https://github.com/ocaml/dune/pull/10355)) we found ourselves
having implemented support for:

- Dune libraries with the same name;
- which may be defined in the same directory;
- as long as they don't conflict in the same context.
    - to achieve that, we use e.g. `(enabled_if (= %{context_name} melange))`.

Putting it all together, our example can be adapted to look like:

```clj
;; src/dune
(library
 (name a)
 (modules a b c)
 (enabled_if
  (= %{context_name} default)))

(library
 (name a)
 (modes melange)
 (modules a b c)
 (enabled_if
  (= %{context_name} melange)))
```

In other words, we define two libraries named `a`, each in their own build
context (with build artifacts ending up in `_build/default` and
`_build/melange`). In the `melange` context, the library has `(modes melange)`.

Both libraries contain modules `A`, `B` and `C` like before. Their
corresponding source files can live in a single directory, no copying required.
If we need to vary `C`'s implementation, we can express that in Dune rules:

```clj
(rule
 (target c.ml)
 (deps c.native.ml)
 (action
  (with-stdout-to
   %{target}
   (echo "let backend = \"OCaml\"")))
 (enabled_if
  (= %{context_name} default)))

(rule
 (target c.ml)
 (deps c.melange.ml)
 (action
  (with-stdout-to
   %{target}
   (echo "let backend = \"Melange\"")))
 (enabled_if
  (= %{context_name} melange)))
```

In short, both libraries get a module `C`. `c.ml`'s contents vary according to
the build context.

## Missing Pieces

We proved that compiling libraries with the same name in different contexts can
work after migrating some of the libraries to the new configuration.

Before deploying such a major change at scale, we need to get the developer
experience right. To illustrate some examples:

- [Dune](https://github.com/ocaml/dune/pull/10324) and
  [`ocaml-lsp`](https://github.com/ocaml/ocaml-lsp/pull/1238) must support
  selecting the context to know where to look for compiled artifacts;
- Editor plugins must have commands or configuration associating certain files
  with their respective context;
- Dune can do better to [show the
  context](https://github.com/ocaml/dune/issues/10378) to which errors belong

We will need some additional time to let all pieces fall in their right places
before we can start recommending compiling Melange code in a separate Dune
context. Before that happens, we wanted to share the problems we faced, how we
ended up lifting some interesting limitations in a composable way, and the new
constructs that will be available in Dune 3.16.

