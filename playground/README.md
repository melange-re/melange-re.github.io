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
