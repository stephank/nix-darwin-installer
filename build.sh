#!/bin/bash
set -xeuo pipefail

cd "$(dirname "$0")"

# Remove previous output files. Many of these may not have write permissions,
# which prevents us from deleting them. That's why we chmod.
if [ -d output ]; then
  chmod -R u+w output
  rm -fr output
fi

# Add the local checkout of nix-darwin to NIX_PATH. This is setup by GitHub
# Actions. If it doesn't exist, we simply assume the channel is already present
# on the system, making local builds easy.
if [ -d nix-darwin ]; then
  export NIX_PATH="darwin=${PWD}/nix-darwin:${NIX_PATH}"
fi

# Add the base system configuration to NIX_PATH.
export NIX_PATH="darwin-config=${PWD}/support/base-system-config.nix:${NIX_PATH}"

# Build the nix-darwin system from the dummy config.
sys_build="$(nix-build '<darwin>' --attr system --no-out-link)"

# Get the closure for the entire system.
sys_closure="$(nix-store --query --requisites "${sys_build}")"

# Prepare the output directory.
mkdir -p output/store
cp -r support/static/* output/

# Create a Nix database dump for the closure.
nix-store --dump-db ${sys_closure} > output/.reginfo

# Copy the closure to the output directory.
cp -R ${sys_closure} output/store/

# Build the installer script.
sed -e "s|@@sys@@|${sys_build}|g" \
  < support/install-from-closure.sh.in \
  > output/install.sh
chmod a+x output/install.sh

# Create the output tarball.
tar --create --auto-compress --numeric-owner --uid 0 --gid 0 \
  --file "nix-darwin-installer.tar.xz" \
  -s '/^output/nix-darwin-installer/' \
  output
