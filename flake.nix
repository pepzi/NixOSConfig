{
  description = "NixOS System Flake Configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nix-doom-emacs, nixos-hardware, ... }: 
  let
    user = "robert";
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit nixpkgs inputs user system home-manager nix-doom-emacs nixos-hardware; 
      }
    );
  };
}
