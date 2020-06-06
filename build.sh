#!/bin/bash
set -xeuo pipefail

cd "$(dirname "$0")"

# Add the base system config to the start of NIX_PATH.
export NIX_PATH="darwin-config=${PWD}/support/base-system-config.nix:${NIX_PATH}"

# Build the base system.
sys_build="$(nix-build '<darwin>' --attr system --no-out-link)"

# Get the closure for the entire base system.
sys_closure="$(nix-store --query --requisites "${sys_build}")"

# Create a Nix database dump for the closure.
nix-store --dump-db ${sys_closure} > output/.reginfo

# Build the installer script.
sed -e "s|@@sys@@|${sys_build}|g" \
  < support/install-from-closure.sh.in \
  > output/install.sh
chmod a+x output/install.sh

# Create a tarball containing the output plus the closure.
tar --create --auto-compress --numeric-owner --uid 0 --gid 0 \
  --file "nix-darwin-installer.tar.xz" \
  -s '|^/nix|nix-darwin-installer|S' \
  -s '|^output|nix-darwin-installer|' \
  ${sys_closure} output
