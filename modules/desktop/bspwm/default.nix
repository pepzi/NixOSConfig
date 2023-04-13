{ config, pkgs, se_a5, ... }: {

services.xserver = {
    displayManager.lightdm.enable = true;
    desktopManager.xfce = {
        enable = true;
        enableXfwm = false;
    };
    desktopManager.xterm.enable = false;
    windowManager.bspwm.enable = true;
  };

  environment.systemPackages = with pkgs; [
    sxhkd nitrogen picom dmenu
  ];

}