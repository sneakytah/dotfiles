# dotfiles

## Install Nix

To Install Nix on your macOS system you can use [DeterminateSystems/nix-installer](https://github.com/DeterminateSystems/nix-installer) or download it from the [official website](https://nixos.org/download.html#nix-install-macos).

## Build flake

> [!IMPORTANT]  
> Make sure to change the hostname to your own.

First time build:

```nix
nix build .#darwinConfigurations.hostname.system \
 	--extra-experimental-features 'nix-command flakes'

 ./result/sw/bin/darwin-rebuild switch --flake .#hostname
```

Subsequent builds:

```nix
./result/sw/bin/darwin-rebuild switch --flake .#hostname
```
