{ lib, inputs, nixpkgs, user, location, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  i9 = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user location;
      host.hostName = "i9";
    };
    modules = [
      ./i9
    ];
  };
}
