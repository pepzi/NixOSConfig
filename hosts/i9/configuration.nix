{ config, pkgs, se_a5, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      ./vm.nix
      ../../modules/desktop/plasma
#      ../../modules/desktop/bspwm
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    supportedFilesystems = [ "ntfs" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
  };

  networking = {
    hostName = "nixos-i9";
    networkmanager.enable = true;
  };


  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services = {
    printing.enable = true;
    openssh.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
   };

    services.xserver = {
    enable = true;

    extraLayouts.se_a5 =  {
      description = "Swedish A5";
      languages = [ "swe" ];
      symbolsFile = se_a5;
    };

    layout = "se_a5";
  };


  # users.users.robert = {
  #   isNormalUser = true;
  #   description = "Robert";
  #   extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  #   packages = with pkgs; [
  #     firefox google-chrome
  #     tmux vscode qbittorrent
  #   ];
  # };

  security = {
    doas.enable = true;
    doas.wheelNeedsPassword = false;
    sudo.wheelNeedsPassword = false;
    };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    htop 
    btop 
    gh 
    gnupg
    unzip 
    zip 
    rar 
    pinentry-curses 
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };

  programs.dconf.enable = true;
  programs.steam.enable = true;
  programs.fish.enable = true;

  system.stateVersion = "22.11";
}
