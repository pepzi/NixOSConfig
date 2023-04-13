{ config, lib, pkgs, user, ... }:

{
    home = {
        username = "${user}";
        homeDirectory = "/home/${user}";

        packages = with pkgs; [
            # Terminal
            btop
            pfetch      # minimal fetch

            # Apps
            google-chrome
            
            # File Management
            unzip
            unrar
        ];
    };

    nixpkgs.config.allowUnfree = true;

    programs = {
        home-manager.enable = true;
    };


}