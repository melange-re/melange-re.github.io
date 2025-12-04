# Playground Assets

This directory contains the dune build configuration for the Melange playground's compiler assets.

These assets are used by the playground UI in `src/.vitepress/theme/playground/`.

## Building

The Melange deps are specified in `documentation-site.opam`. To build the playground assets:

```bash
dune build @playground-assets
```

This generates the compiler and runtime files to `_build/default/playground-assets/`.
