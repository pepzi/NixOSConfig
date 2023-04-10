{ config, pkgs, se_a5, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./vm.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos-i9";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Stockholm";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  services.xserver = {
    enable = true;

    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    # videoDrivers = [ "nvidia" ];

    extraLayouts.se_a5 =  {
      description = "Swedish A5";
      languages = [ "swe" ];
      symbolsFile = se_a5;
    };

    layout = "se_a5";
  };

  console.keyMap = "sv-latin1";

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.robert = {
    isNormalUser = true;
    description = "Robert";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      firefox google-chrome
      tmux vscode qbittorrent
    ];
  };

  security.doas.enable = true;
  security.doas.wheelNeedsPassword = false;
  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
   vim wget file htop btop git gh gnupg
   unzip zip rar pinentry-curses pciutils
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };

  programs.dconf.enable = true;
  programs.steam.enable = true;

  services.openssh.enable = true;

  system.stateVersion = "22.11";
}
