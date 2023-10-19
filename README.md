# dotfiles

## Build flake

> [!IMPORTANT]  
> Make sure to change the hostname to your own.

First time build

```sh
nix build .#darwinConfigurations.hostname.system \
 	--extra-experimental-features 'nix-command flakes'

 ./result/sw/bin/darwin-rebuild switch --flake .#hostname
```

Subsequent builds

```sh
./result/sw/bin/darwin-rebuild switch --flake .#hostname
```
