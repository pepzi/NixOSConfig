{ config, lib, pkgs, nix-doom-emacs, user, ... }:

{
    home = {
        username = "robert";
        homeDirectory = "/home/robert";

	stateVersion = "22.11";

        packages = with pkgs; [
            # Terminal
            btop
            # pfetch      # minimal fetch
      	    pv		# pipe viewer
	          fzf

            # Apps
#            #google-chrome
#            browserpass
            
            # File Management
            unzip
      	    discord
            unrar

            ctags
	          irssi
        ];
    };

    nixpkgs.config.allowUnfree = true;
#    programs.browserpass.enable = true;

#    imports = [ nix-doom-emacs.hmModule ];

      programs = {
      home-manager.enable = true;
#      doom-emacs = {
#	enable = true;
#	doomPrivateDir = ./dotfiles/doom.d;
#      };
    };

}
