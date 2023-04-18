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

  home.file.".config/alacritty".source = ./configs/alacritty;
  home.file.".config/sway".source = ./configs/sway;
  home.file.".config/swaynag".source = ./configs/swaynag;
  home.file.".config/waybar".source = ./configs/waybar;
  home.file.".config/wofi".source = ./configs/wofi;
  home.file.".config/vimrc".source = ./configs/vimrc;
}

