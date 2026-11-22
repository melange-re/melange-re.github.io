#!/usr/bin/env bash
set -euo pipefail

library_dir=$(ocamlfind query "$1")
case "$1" in
  melange)
    directories=(
      "$library_dir/__private__/melange_mini_stdlib/melange"
      "$library_dir/js/melange"
      "$library_dir/belt/melange"
      "$library_dir/melange"
      "$library_dir/dom/melange"
    )
    ;;
  reason-react)
    directories=("$library_dir/melange")
    ;;
esac

# --ofs includes the runtime helpers used to decode binary interface files.
runtime_dir=$(mktemp -d)
trap 'rm -rf "$runtime_dir"' EXIT
find "${directories[@]}" \( -name '*.cmi' -o -name '*.cmj' \) -print0 |
  LC_ALL=C sort -z |
  xargs -0 printf -- '--file=%s\0' |
  xargs -0 js_of_ocaml build-runtime -o "$runtime_dir/runtime.js" --ofs "$2"
