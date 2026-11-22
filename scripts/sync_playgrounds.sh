#!/usr/bin/env bash
set -euo pipefail

site=${1:?Usage: sync_playgrounds.sh SITE_DIRECTORY}
playground="$site/unstable/playground"

if [[ ! -f "$playground/index.html" ]]; then
  echo "Missing playground build: $playground/index.html" >&2
  exit 1
fi

for version in "$site"/v[0-9]*/; do
  [[ -d "$version" ]] || continue
  mkdir -p "${version}playground"
  # A checkout can give different files identical sizes and timestamps.
  rsync -a --checksum --delete "$playground/" "${version}playground/"
done
