{ config, pkgs, se_a5, ... }:

{
  imports =
    [ ./hardware-configuration.nix
#    ./vm.nix
#      ../../modules/desktop/plasma
#      ../../modules/desktop/sway
#      ../../modules/desktop/bspwm
    ];

  boot = {
    kernelModules = [ "kvm-intel" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ]; # "xhci_pci" ];
    kernelParams = [ "intel_iommu=on" "iommu=pt" ];
    extraModprobeConfig = "options vfio-pci ids=10de:2206,10de:1aef,1987:5012}";
    blacklistedKernelModules = [ "nvidia" "nvidiafb" "nouveau" "nvme" ];

    kernelPackages = pkgs.linuxPackages_latest;

    supportedFilesystems = [ "ntfs" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
  };

  powerManagement.cpuFreqGovernor = "performance";

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
    man.generateCaches = true;
  };

  nix.settings = {
    cores = 5;
  };
  networking = {
    hostName = "i9";
    networkmanager.enable = true;

    firewall = {
      allowedTCPPorts = [ 20 21 8000 2049 ]; # 2049 = NFSv4
      allowedTCPPortRanges = [ { from = 51000; to = 51999; } ]; # vsftpd
      connectionTrackingModules = [ "ftp" ];

        interfaces."virbr0" = {
          allowedTCPPortRanges = [ { from = 1; to = 65535; } ];
          allowedUDPPortRanges = [ { from = 1; to = 65535; } ];
        };
    };


    nat = {
      enable = true;
      internalInterfaces = [ "virbr0" ];
      externalInterface = "enp4s0";
    };
  };

  security.polkit.enable = true;

  systemd = {
    services.on-wakeup-after-hibernate = {
      description = "Change tty to 7 after wakeup. This is a hack for a problem with Hyprland.";
      wantedBy = [ "post-resume.target" ];
      after = [ "post-resume.target" ];
      script = ''
        /run/current-system/sw/bin/chvt 7
      '';
      serviceConfig.Type = "oneshot";
    };
/*    user.services.polkit-gnome-authentication-agent-1 = {
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
*/
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services = {
    printing.enable = true;

    openssh.enable = true;
    openssh.settings.PermitRootLogin = "yes";

    vsftpd = {
      enable = true;
      writeEnable = true;
      localUsers = true;
      userlist = [ "robert" ];
      userlistEnable = true;
      extraConfig = ''
        pasv_enable=Yes
        pasv_min_port=51000
        pasv_max_port=51999
      '';
    };

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

    rpcbind.enable = true;

#    nfs.server = {
#      enable = true;
#      exports = ''
#        /mnt/share  192.168.122.0/24(rw,nohide,insecure,no_subtree_check)
#      '';
#    };

    xserver = {
      enable = true;

      displayManager = {
        lightdm.enable = true;
        defaultSession = "hyprland";
        autoLogin.user = "robert";
        sddm.enable = false;
      };

      extraLayouts.se_a5 =  {
        description = "Swedish A5";
        languages = [ "swe" ];
        symbolsFile = se_a5;
      };

      layout = "se_a5";
      xkbOptions = "caps:swapescape";
    };
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
      lxqt.lxqt-policykit
#      retroarchFull
#      htop
      wireguard-tools
#      btop

#      gh
#      gnupg
      pinentry-curses
#      binutils
#      patchelf
#     remote-utilities-viewer
#      google-chrome
      appimage-run
      nixfmt
#      virtualbox
#      ctags
      eww-wayland
      python311
      wofi
      wl-clipboard
      wdisplays
#      vice
      nordic
      papirus-icon-theme
      xdg-utils
      nix-index
#      lutris
      home-manager
#      (steam.override { extraPkgs = pkgs: [
#        lutris
#        gamescope
#        mangohud
#      ]; }).run
  ];

  fonts = {
    fontconfig = {
      antialias = true;

      hinting = {
        enable = true;
        style = "full";
        autohint = true;
      };

      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
    };

    packages = with pkgs; [
      source-code-pro
        font-awesome
        fira-code
        fira-code-symbols
        nerdfonts
        roboto
        emacs-all-the-icons-fonts
    ];
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
#    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.gamemode.enable = true;

#  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
#    "steam"
#    "steam-original"
#    "steam-runtime"
# ];

  programs.hyprland.enable = true;
  programs.dconf.enable = true;
#  programs.steam = {
#    enable = true;
#    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
#    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
#  };

  programs.fish.enable = true;
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];

  system.stateVersion = "22.11";
}
