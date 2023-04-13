{ config, pkgs, se_a5, ... }: {

    services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

}
