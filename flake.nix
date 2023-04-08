{
  description = "NixOS System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ { nixpkgs, ... }:
    let
      user = "robert";
      location = "$HOME/.setup";
    in {
      nixosConfigurations = (
        import ./hosts {
	  inherit (nixpkgs) lib;
	  inherit inputs nixpkgs user location;
	}
      );
    };
}
