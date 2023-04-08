{ config, pkgs, user, se_a5, ... }:
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./vm.nix
  ];
}
