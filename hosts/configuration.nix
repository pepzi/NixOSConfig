{ config, lib, pkgs, inputs, user, ... }:

{
  imports = 
    (import ../modules/editors);
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "video" "networkmanager"];
    # TODO 
    # shell = pkgs.zsh; 
  };
  security.sudo.wheelNeedsPassword = false;

#  time.timezone = "Europe/Stockholm";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
    };
  }; 

  console = {
    font = "Lat2-Terminus16";
    keyMap = "sv-latin1";
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  environment = {
    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
    systemPackages = with pkgs; [
      killall
      nano
      pciutils
      usbutils
      wget
    ];
  };

  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    openssh = {
      enable = true;
      allowSFTP = true;
      extraConfig = ''
        HostKeyAlgorithms +ssh-rsa
      '';
    };
  };


  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;

  system = {
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.11";
  };
}
