# Melange playground

This is the guts of https://melange.re/unstable/playground.

The Melange deps are specified in `documentation-site.opam`. Before building the playground, we need to download and build these deps.

From the project root:

```bash
make install
dune build @playground-assets
```

Then, can work on the playground with:

```bash
cd playground && yarn dev
```

To build, `yarn build`.

The OCaml tab accepts MLX JSX expressions and uses `ocamlformat-mlx` for
formatting. Its parser produces an OCaml 5.5 AST, which is migrated to the
playground compiler's ppxlib AST before compilation. Keep the pinned formatter
version and the AST conversion in `format.ml` in sync when upgrading.

Run the playground integration tests with `dune build @playground/runtest`.
