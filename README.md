# Melange documentation site

This repository contains the source for Melange public documentation site.

If you are looking for Melange source instead, it can be found in
https://github.com/melange-re/melange.

> **Warning** At the moment, this is a **work in progress**, opened to the
> public. The content and technology used to build the website are being
> developed and the website itself is not hosted yet on its final domain.

## Working locally

After cloning the repository, install the necessary JavaScript packages:

```bash
yarn
```

Then run `make dev` from the folder where the repository lives.

## (Optional) Fetch melange documentation API

Optionally, to fetch the melange odoc documentation and generate markdown into docs/api, you will need the melange package installed into your switch and run:

```bash
make pull-melange-docs SYNTAX="re"
make pull-melange-docs SYNTAX="ml"
```

### (Optional) Tooling for docs generation

Optionally, to run some of the tools to auto-generate parts of the
documentation, you will need an opam switch with the required dependencies. To
set it up, run:

```bash
make init
```

## Writing code snippets

All code snippets should be written in OCaml syntax. A development-time script
is available to automatically generate Reason syntax snippets from the OCaml
ones. Before running this script, you will need to set up an opam switch.
Instructions can be found in the ["Tooling for docs
generation"](#optional-tooling-for-docs-generation) section.

To run the script:

```bash
dune build @re
```

To promote any changes to the original `md` file, one can run:

```bash
dune build @re --auto-promote
```

## Publishing

Publishing is done automatically from GitHub actions:
- Every commit to `master` will publish in the `unstable` folder, i.e.
  https://melange.re/unstable
- Every tag pushed with the `v*` format will publish to a folder with the same
  name as the tag. For example, the branch with tag `v4.0.0` will publish to
  https://melange.re/v4.0.0/.

### Tracking new versions of `melange` in opam

When a new version of `melange` is published in opam, a new release of the docs
and playground should be published. The process is as follows:

- Update `documentation-site.opam` to point `melange` and `melange-playground`
  packages to the commit of the new release (they need to be pinned so that the
  Melange docs can be accessed on a stable path)
- Update versions of the compiler listed in the playground (`app.jsx`)
- In the docs markdown pages, grep for the last version of Melange that was used
  and replace it with the newer one.
- Open a PR with the changes above
- After merging the PR, create a new branch `x.x.x-patches`. This branch will be
  used to publish any patches or improvements to that version of the docs /
  playground
- In that branch, add a new command on the main `Makefile` to publish a new tag,
  e.g.
```Makefile
.PHONY: move-vx.x.x-tag
move-vx.x.x-tag: ## Moves the vx.x.x tag to the latest commit, useful to publish the vx docs
	git push origin :refs/tags/vx.x.x
	git tag -fa vx.x.x
	git push origin --tags
```
- Call the newly created command to create a new version selectable from the
  website: `make move-vx.x.x-tag`
- Update the navigation bar in `docs/.vitepress/config.mts`, under
  `themeConfig.nav` setting, so that the first item is the one of the new
  version, and `unstable` is shown last
- Once the new version is published, we need to make sure other versions remain
  SEO friendly:
  - In `master`: update `add_canonical` to point to the new `vx.x.x`, so that
    the `unstable` version of the docs starts referring to that version as the
    canonical one. To do so:
      - update the version in `add_canonical.ml`
      - run `dune test --auto-promote`
  - In `y.y.y-patches`: update `add_canonical` in version `y.y.y` that was last
    before, to point to `vx.x.x` as well. To do so:
      - update the version in `add_canonical.ml`
      - run `dune test --auto-promote`
      - uncomment the relevant code in `publish-version.yml`
- In the `gh-pages` branch:
  - replace the default version with the new one [in
    index.html](https://github.com/melange-re/melange-re.github.io/blob/gh-pages/index.html#L10)
  - update `robots.txt` to point to the new version sitemap

### Update docs for latest stable version

After making changes in the `master` branch, you may want some or all of those
changes to appear in the latest stable version's docs. As an example, let's say
that the latest stable version is 4.0.0. Then you should:

1. Checkout branch `4.0.0-patches`
1. Cherry pick the commits you want to add
1. Push your changes to the branch
1. Run `make move-v4.0.0-tag` to publish the branch to
   https://melange.re/v4.0.0/
