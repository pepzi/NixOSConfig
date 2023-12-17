{ config, lib, pkgs, user, home-manager, ... }:

{
  home.packages = with pkgs; [
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

