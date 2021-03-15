#!/usr/bin/env bash

nixos-rebuild switch --show-trace --option extra-builtins-file /etc/nixos/extra-builtins.nix
