{ config, lib, pkgs, nix-doom-emacs, user, ... }:

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

	    irssi
        ];
    };

    nixpkgs.config.allowUnfree = true;

#    imports = [ nix-doom-emacs.hmModule ];

    programs = {
      home-manager.enable = true;
      #doom-emacs = {
        #enable = true;
	#doomPrivateDir = ./dotfiles/doom.d;
      #};
    };

}
