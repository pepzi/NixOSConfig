{ config, pkgs, se_a5, ... }: {

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
  };

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      wofi dunst foot waybar
    ];
  };
}
