# Unofficial nix-darwin installer

This is a combined installer for [Nix] and [nix-darwin]. It is UNOFFICIAL and
EXPERIMENTAL, so use at your own risk.

```sh
/bin/bash -c "$(curl -fsSL https://stephank.github.io/nix-darwin-installer/install.sh)"
```

Requires macOS 10.14 or higher. [Source code on GitHub].

## Post-install

At the very end of installation, you may see warnings about files in `/etc` it
has refused to replace. These need to be fixed manually. For example,
`/etc/bashrc` should be a symlink to `/etc/static/bashrc`, or else Bash won't
have the correct `PATH` and `NIX_PATH`. (Future updates of macOS itself may
also reset these files again.)

## Maintaining the installation

To apply changes after editing `darwin-configuration.nix`:

```sh
darwin-rebuild switch
```

To keep your system up-to-date:

```sh
nix-channel --update
darwin-rebuild switch
```

To clean up old generations of your system:

```sh
sudo nix-collect-garbage -d
```

## Differences from the official installers

In general, this installer tries to be more opinionated. To goal is to simplify
both installation and maintenance. These are the differences from the official
methods of installing Nix and nix-darwin:

- Combines Nix and nix-darwin in one installation step.

- Assumes you want an (unencrypted) APFS volume for `/nix` by default.
  Spotlight indexing is automatically disabled for this volume.

- Configures all channels (including Nixpkgs) only for the regular user that
  runs the installer.

Technically, the installer package is similar to the regular Nix installer, but
bundles a complete nix-darwin base system instead. It also relies on the
nix-darwin `activate` script to setup nix-daemon and the build users.

## Acknowledgements

The installer is based on code from the official [Nix] installer. (LGPL 2.1)

The site is built with [Jekyll], and based on the [Solo] theme. (MIT)

[Nix]: https://nixos.org/
[nix-darwin]: https://github.com/LnL7/nix-darwin
[Jekyll]: https://jekyllrb.com
[Solo]: https://github.com/chibicode/solo
[Source code on GitHub]: https://github.com/stephank/nix-darwin-installer
