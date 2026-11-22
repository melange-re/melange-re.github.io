Publish the current playground to existing releases, including releases without
a playground yet. Keep each release's documentation and unrelated sites intact.

  $ mkdir -p site/unstable/playground/assets site/v1.0.0/playground/assets site/v7.0.1 site/blog site/fun-ocaml-playground
  $ printf 'MLX playground\n' > site/unstable/playground/index.html
  $ printf 'current compiler\n' > site/unstable/playground/assets/compiler.js
  $ printf 'old playground\n' > site/v1.0.0/playground/index.html
  $ touch -r site/unstable/playground/index.html site/v1.0.0/playground/index.html
  $ printf 'old compiler\n' > site/v1.0.0/playground/assets/old.js
  $ printf 'v1 documentation\n' > site/v1.0.0/index.html
  $ printf 'v7 documentation\n' > site/v7.0.1/index.html
  $ printf 'default redirect\n' > site/index.html
  $ printf 'blog\n' > site/blog/index.html
  $ printf 'conference playground\n' > site/fun-ocaml-playground/index.html
  $ bash ./sync_playgrounds.sh site
  $ diff -r site/unstable/playground site/v1.0.0/playground
  $ diff -r site/unstable/playground site/v7.0.1/playground
  $ cat site/v1.0.0/index.html site/v7.0.1/index.html site/index.html site/blog/index.html site/fun-ocaml-playground/index.html
  v1 documentation
  v7 documentation
  default redirect
  blog
  conference playground

A repeat run has the same result. A later release publication gets the same
playground, and a subsequent playground build refreshes every version.

  $ bash ./sync_playgrounds.sh site
  $ diff -r site/unstable/playground site/v1.0.0/playground
  $ mkdir -p site/v8.0.0/playground
  $ printf 'release playground\n' > site/v8.0.0/playground/index.html
  $ printf 'new MLX playground\n' > site/unstable/playground/index.html
  $ bash ./sync_playgrounds.sh site
  $ diff -r site/unstable/playground site/v1.0.0/playground
  $ diff -r site/unstable/playground site/v7.0.1/playground
  $ diff -r site/unstable/playground site/v8.0.0/playground

Fail before touching any release if the source playground is missing.

  $ mkdir -p missing/v1.0.0/playground
  $ printf 'keep this playground\n' > missing/v1.0.0/playground/index.html
  $ bash ./sync_playgrounds.sh missing
  Missing playground build: missing/unstable/playground/index.html
  [1]
  $ cat missing/v1.0.0/playground/index.html
  keep this playground
