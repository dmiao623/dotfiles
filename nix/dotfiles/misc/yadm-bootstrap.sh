#!/bin/sh

system_type=$(uname -s)

if [ "$system_type" = "Darwin" ]; then
  if ! command -v nix >/dev/null 2>&1; then
    sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
    nix --version
  fi

  darwin-rebuild switch --flake ~/nix#dustinm
fi
