#!/bin/sh
set -eu
cd "$(dirname "$0")"

out="$(mktemp --dry-run)"
nix build --out-link "$out" nixpkgs#shared-mime-info
echo '[' > mime-types.nix
sed "$out/share/mime/types" \
    -e 's/^/  "/' \
    -e 's/$/"/' >> mime-types.nix
echo ']' >> mime-types.nix
