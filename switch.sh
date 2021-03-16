#!/usr/bin/env bash

export NIX_PLUGINS=$(nix-store -r $(nix-instantiate -E 'with import <nixpkgs> {}; nix-plugins'))
export NIXPKGS_ALLOW_UNFREE=1
nixos-rebuild switch --show-trace --option plugin-files $NIX_PLUGINS/lib/nix/plugins/libnix-extra-builtins.so --option extra-builtins-file /etc/nixos/extra-builtins.nix
