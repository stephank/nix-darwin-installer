# Unofficial nix-darwin installer

This is a combined installer for [Nix] and [nix-darwin]. It is UNOFFICIAL and
EXPERIMENTAL, so use at your own risk.

```sh
/bin/bash -c "$(curl -fsSL https://stephank.github.io/nix-darwin-installer/install.sh)"
```

Requires macOS 10.14 or higher. [Source code on GitHub]. A basic installation
downloads about 60 MB.

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

## Advanced installation options

To change the location of nix-darwin configuration, set `darwin_config` before
running the installer:

```sh
# This example shows the default location
export darwin_config="$HOME/.nixpkgs/darwin-configuration.nix"
```

And make sure to also set the [`environment.darwinConfig`] option inside
configuration itself.

You can also point this at an existing file to directly activate that
configuration.

## Differences from the official installers

In general, this installer tries to be more opinionated. The goal is to
simplify both installation and maintenance, with the default setup optimized
for systems with just one user.

These are the differences from the official methods of installing Nix and
nix-darwin:

- Combines Nix and nix-darwin in one installation step.

- Assumes you want an (unencrypted) APFS volume for `/nix`. Spotlight indexing
  is automatically disabled for this volume.

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
[Source code on GitHub]: https://github.com/stephank/nix-darwin-installer
[`environment.darwinConfig`]: https://lnl7.github.io/nix-darwin/manual/index.html#opt-environment.darwinConfig
[Jekyll]: https://jekyllrb.com
[Solo]: https://github.com/chibicode/solo
