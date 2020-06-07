# Unofficial nix-darwin installer

This is a combined installer for [Nix] and [nix-darwin]. It is UNOFFICIAL and
EXPERIMENTAL, so use at your own risk.

```sh
/bin/bash -c "$(curl -fsSL https://stephank.github.io/nix-darwin-installer/install.sh)"
```

Requires macOS 10.14 or higher.

## Differences from the official installers

In general, this installer tries to be more opinionated. These are the
differences from the official methods of installing Nix and nix-darwin:

- This installer assumes you want an (unencrypted) APFS volume for `/nix` by
  default. Spotlight indexing is automatically disabled for this volume.

- All channels (including Nixpkgs) are setup only for the regular user that
  runs the installer. The goal is to minimze having the user do manual `sudo`
  commands to update and maintain the system. (Caveat: old system generations
  can only be cleaned up by root.)

- The installer package is similar to the regular Nix installer, but bundles a
  complete nix-darwin base system instead. It also relies on the nix-darwin
  `activate` script to setup nix-daemon and the build users.

## Acknowledgements

The installer is based on code from the official [Nix] installer. (LGPL 2.1)

The site is built with [Jekyll], and based on the [Solo] theme. (MIT)

[Nix]: https://nixos.org/
[nix-darwin]: https://github.com/LnL7/nix-darwin
[Jekyll]: https://jekyllrb.com
[Solo]: https://github.com/chibicode/solo
