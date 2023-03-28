{ config, lib, pkgs, user, ... }:

{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      btop tmux unzip unrar zip git killall vim
    ];
    stateVersion = "22.11";
  };

  programs = {
    home-manager.enable = true;
  };
}
