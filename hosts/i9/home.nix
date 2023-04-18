{ config, lib, pkgs, user, ... }:

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

	binutils

	plover.dev
	oh-my-fish

	tmux
  ];

  home.file.".config/waybar".source = ./configs/waybar;
}

