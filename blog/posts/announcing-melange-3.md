---
title: 'Announcing Melange 3'
date: 2024-02-13
author: Antonio Monteiro
gravatar: 45c2052f50f561b9dc2cae59c777aecd794f57269fa317f9c9c3365c2e00d16f
twitter: '@_anmonteiro'
---

We are excited to announce the release of [Melange
3](https://github.com/melange-re/melange/releases/tag/3.0.0-51), the latest
version of our backend for the OCaml compiler that emits JavaScript.

This new version comes packed with significant changes, improvements, and a few
necessary removals to ensure a more streamlined and efficient experience for our
users. This new version is both leaner and more robust. We focused on fixing
crashes and removing obsolete functionality, improving the developer and
troubleshooting experience, increasing OCaml compatibility and JavaScript FFI
integration.

---

Here's a rundown of the key updates in Melange 3. Check the [Melange
documentation](https://melange.re/v3.0.0/) for further resources.

## Major Changes and Removals

In Melange 3, `Belt` is no longer a dependency for the Melange `Stdlib`.
Libraries that depend on the Belt modules will need to include `(libraries
melange.belt)` in their build configuration.

The `@bs` / `@bs.*` attributes have been replaced. Users of Melange should now
utilize `[@u]` for uncurried application and `[@mel.*]` for FFI attributes.
Additionally:

- `[@mel.val]` has been removed as it was redundant in the Melange FFI​​.
- `[@mel.splice]` was removed in favor of `[@mel.variadic]`

For this release, most modules in the `Js` namespace had their APIs unified,
deduplicated and refactored. In cases such as `Js.Int`, `Js.Date`, `Js.Re`,
`Js.Float`, `Js.String`, some functions were changed from pipe-first to
pipe-last and labeled arguments were added; and incorporating those made others
obsolete, which we removed. Modules such as `Js.List`, `Js.Null_undefined`,
`Js.Option`, `Js.Result` and `Js.Cast` are also no longer present in Melange 3.
Alternatives within `Stdlib` or `Belt` are instead​​ recommended.

## New Features and Enhancements

Melange 3 includes a few interesting new features and enhancements. From syntax
and preprocessing to interop with JavaScript, runtime and error messages, here are some
we chose to highlight:

### Interop

- Modules can be renamed with `@mel.as`
- `@mel.obj` and `%mel.obj` allow renaming the JS object keys with `@mel.as`
- `@mel.new` can now be used alongside `@mel.send` and `@mel.send.pipe`
- `[@@deriving abstract]` is now deprecated and split into its two main
  features:
  - `[@@deriving jsProperties]` derives a JS object creation function that can
    generate a JS object with optional keys (when using `@mel.optional]`)
  - `[@@deriving getSet]` derives getter / setter functions for the JS object
    derived by the underlying record.

### Error messages & Hints

Melange 3 provides more informative error messages originating from both the
`melange.ppx` and the compiler core​​​​.

In this release, we also introduce a new `unprocessed` alert to detect code that
has made it to the Melange compiler without having been processed by the Melange
PPX. Besides hinting users to add `(preprocess (pps melange.ppx))` to their `dune`
file, this alert more explicitly exposes a common failure mode that puzzles
beginners quite often.

Additionally:

- The Melange playground now has improved reporting of PPX alerts.
- Runtime error rendering in the playground renders better error information.
- The JS parser within Melange has been upgraded to Flow v0.225.1.

### Runtime & `Stdlib`

Melange 3 implements more functions in the following modules of the `Stdlib`:
`String`, `Bytes`, `Buffer`, `BytesLabels` and `StringLabels`. Specifically, the
new unicode parsing functions upstream are now available in Melange as well.

Some keys with legacy names have been updated for consistency, such as renaming
`RE_EXN_ID` to `MEL_EXN_ID` and `BS_PRIVATE_NESTED_SOME_NONE` to
`MEL_PRIVATE_NESTED_SOME_NONE`​​ in the Melange generated JS runtime.

The team also took a look at unicode strings in this version of Melange. A few
noteworthy changes:

- `{j| ... |j}` interpolation​​​​ now only allows interpolating strings; other
  usages of interpolation have started to produce type errors.
- Unicode strings such as `{js| … |js}` can now be used as `Format` strings.

## Conclusion

Melange 3 marks a significant step forward in the OCaml-to-JavaScript
compilation process. With these updates, we aim to provide a more robust,
efficient, and user-friendly tool for developers. We encourage users to upgrade
to this new version to take full advantage of the improvements and to adapt to
the breaking changes for a smoother development experience. For a full list of
the changes that made it into this release, feel free to consult the
[changelog](https://github.com/melange-re/melange/blob/main/Changes.md#300-2024-01-28).

Stay tuned for more updates and enhancements as we continue to improve Melange
and support the developer community!
