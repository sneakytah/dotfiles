{
  description = "Nix for macOS configuration";

  # the nixConfig here only affects the flake itself, not the system configuration 
  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.05-darwin";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  # The `outputs` function will return all the build results of the flake. 
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names. 
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = inputs@{ self, nixpkgs, darwin, ... }:{
    darwinConfigurations.nova = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./modules/core.nix
        ./modules/system.nix
        ./modules/apps.nix
        ./modules/host-users.nix
      ];
    };

    # nix code formatter
    formatter.aarch64-darwin = nixpkgs.legacyPackages.x86_64-darwin.alejandra;
  };
}
