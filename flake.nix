{
  description = "NixOS System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      flake = false;
    };

    doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.emacs-overlay.follows = "emacs-overlay";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, doom-emacs, ... }: 
    let
      user = "robert";
      location = "$HOME/.setup";
    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager user location doom-emacs;
        }
      );
    };
}
