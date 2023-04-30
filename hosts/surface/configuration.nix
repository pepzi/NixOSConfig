{ config, pkgs, se_a5, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      ./vm.nix
      ../../modules/desktop/plasma
#      ../../modules/desktop/sway
#      ../../modules/desktop/bspwm
    ];

  boot = {
    supportedFilesystems = [ "ntfs" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
  };

  networking = {
    hostName = "surface";
    networkmanager.enable = true;
  };

  microsoft-surface = {
    kernelVersion = "6.1.18";
    surface-control.enable = true;
    ipts.enable = true;
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
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;

  systemd.services = {
    iptsd = {
#      enable = true;
#      description = "Intel Precise Touch & Stylus Daemon";
#      documentation = [ "https://github.com/linux-surface/iptsd" ];
#      after = [ "dev-ipts-0.device" ];
#      wants = [ "dev-ipts-0.device" ];
#      wantedBy = [ "multi-user.target" ];
#      serviceConfig.Type = "simple";
#      path = [ pkgs.iptsd ];
      script = ''
        iptsd $(iptsd-find-hidraw)
      '';
    };
  };

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
    xkbOptions = "caps:swapescape";
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
    binutils
    patchelf
    # remote-utilities-viewer

    # surface things
    iptsd
  ];

  fonts.fonts = with pkgs; [
    source-code-pro
    font-awesome
    fira-code
    fira-code-symbols
    nerdfonts
    roboto
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
