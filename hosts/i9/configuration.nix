{ config, pkgs, se_a5, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      ./vm.nix
#      ../../modules/desktop/plasma
      ../../modules/desktop/sway
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
    hostName = "i9";
    networkmanager.enable = true;
    nat = {
      enable = true;
      internalInterfaces = [ "virbr0" ];
      externalInterface = "enp4s0";
    };
  };


  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services = {
    printing.enable = true;
    openssh.enable = true;
    openssh.settings.permitRootLogin = "yes";

    plex.enable = true;
    plex.user = "robert";
    plex.openFirewall = true;
    tautulli.enable = true;
    tautulli.openFirewall = true;

    transmission.enable = true;
    transmission.openFirewall = true;

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
    wireguard-tools
    btop 
    gh 
    gnupg
    unzip 
    zip 
    rar 
    pinentry-curses 
    binutils
    patchelf
    # remote-utilities-viewer
    nixfmt
    virtualbox
    ctags
  ];

  fonts.fonts = with pkgs; [
    source-code-pro
    font-awesome
    fira-code
    fira-code-symbols
    nerdfonts
    roboto
    emacs-all-the-icons-fonts
  ];


  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };

  programs.dconf.enable = true;
  programs.steam.enable = true;
  programs.fish.enable = true;
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];

  system.stateVersion = "22.11";
}
