#!/bin/bash

# Guard against incomplete download.
{

set -euo pipefail

installer_cache="$HOME/.cache/nix-darwin-installer"
package_url="https://stephank.github.io/nix-darwin-installer/nix-darwin-installer.tar.xz"

if [ "$(uname -s)" != "Darwin" ]; then
    echo "error: this script is for macOS only" >&2
    exit 1
fi

if [ $EUID -eq 0 ]; then
    echo "error: please run this script as a regular user, instead of root" >&2
    exit 1
fi

# Prepare the download directory.
mkdir -p "$installer_cache"
cd "$installer_cache"

# Remove previous files. Many of these may not have write permissions,
# which prevents us from deleting them. That's why we chmod.
if [ -d nix-darwin-installer ]; then
    chmod -R u+w nix-darwin-installer
fi
rm -fr nix-darwin-installer nix-darwin-installer.tar.xz.partial

# Download.
if [ -f nix-darwin-installer.tar.xz ]; then
    echo " - Reusing existing download: $PWD/nix-darwin-installer.tar.xz" >&2
    echo "   (Remove this file if you'd like to redownload the installer)" >&2
else
    echo " - Downloading the installer package..." >&2
    curl -fL -o nix-darwin-installer.tar.xz.partial "$package_url"
    mv nix-darwin-installer.tar.xz.partial nix-darwin-installer.tar.xz
fi

# Unpack and run.
echo " - Unpacking the installer package..." >&2
tar -xf nix-darwin-installer.tar.xz
echo " - Starting the installer script..." >&2
exec ./nix-darwin-installer/install.sh

}
