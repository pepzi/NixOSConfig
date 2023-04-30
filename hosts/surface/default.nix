{ config, pkgs, user, se_a5, home-manager, ... }:
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
