{ config, lib, pkgs, user, ... }:

{
    home = {
        username = "robert";
        homeDirectory = "/home/robert";

	stateVersion = "22.11";

        packages = with pkgs; [
            # Terminal
            btop
            pfetch      # minimal fetch

            # Apps
            google-chrome
            
            # File Management
            unzip
	    discord
            unrar
        ];
    };

    nixpkgs.config.allowUnfree = true;

    programs = {
        home-manager.enable = true;
    };


}
