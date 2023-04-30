{ config, lib, pkgs, user, home-manager, ... }:

{
    home.packages = with pkgs; [
        # Video/Audio
        feh         # image viewer
        mpv
        pavucontrol # Audio control
        vlc

        # Apps
        google-chrome

        alacritty
	vscode
	freecad
	blender

	binutils

	plover.dev
	oh-my-fish

	tmux
	emacs

	# doom dependencies
	binutils       # native-comp needs 'as', provided by this

	git
	(ripgrep.override {withPCRE2 = true;})
	gnutls              # for TLS connectivity

	## Optional dependencies
	fd                  # faster projectile indexing
	#imagemagick         # for image-dired
        pinentry_emacs   # in-emacs gnupg prompts
        zstd                # for undo-fu-session/undo-tree compression
	shellcheck
  ];

  services.mako = {
    enable = true;
    defaultTimeout = 4000;
  };

  home.sessionPath = 
    [
      "~/.config/emacs/bin"
    ];

  home.file.".config/alacritty".source = ./configs/alacritty;
  home.file.".config/tmux".source = ./configs/tmux;
  home.file.".config/sway".source = ./configs/sway;
  home.file.".config/swaynag".source = ./configs/swaynag;
  home.file.".config/waybar".source = ./configs/waybar;
  home.file.".config/wofi".source = ./configs/wofi;
  home.file.".config/vimrc".source = ./configs/vimrc;
}

