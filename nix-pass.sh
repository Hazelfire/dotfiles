#!/usr/bin/env bash

# nix-pass.sh

set -euo pipefail

f=$(mktemp)
trap "rm $f" EXIT
gpg --pinentry-mode loopback -d "$1/$2.gpg" > $f
nix-instantiate --eval -E "builtins.readFile $f"
