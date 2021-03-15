#!/usr/bin/env bash

export NIXPKGS_ALLOW_UNFREE=1
nixos-rebuild switch --show-trace --option extra-builtins-file /etc/nixos/extra-builtins.nix
