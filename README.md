# Unofficial nix-darwin installer

This is a combined installer for [Nix](https://nixos.org/) and
[nix-darwin](https://github.com/LnL7/nix-darwin). It is UNOFFICIAL and
EXPERIMENTAL, so use at your own risk.

## Usage

- Go to the latest successful build on GitHub Actions, which you'll find in
  [this list](https://github.com/stephank/nix-darwin-installer/actions?query=branch%3Amaster+workflow%3Abuild).

- Download the tarball of that build.

- Unpack it: `tar -xf nix-darwin-installer.tar.xz`

- Run the installer: `./nix-darwin-installer/install.sh`

(TODO: Automate the above steps using a curl one-liner.)
