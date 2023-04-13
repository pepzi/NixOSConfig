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

	plover.dev
    ];
}

