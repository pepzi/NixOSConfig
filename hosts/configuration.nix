{ config, lib, pkgs, inputs, user, nix-doom-emacs, ... }:

{ 
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

    console.keyMap = "sv-latin1";

    fonts.fonts = with pkgs; [
        source-code-pro
        font-awesome
        corefonts
        (nerdfonts.override {
            fonts = [
                "FiraCode"
            ];
        })
    ];

    users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" "kvm" "libvirtd" ];
        shell = pkgs.bash;
    };

    programs.neovim = {
      vimAlias = true;
      viAlias = true;
      enable = true;
      defaultEditor = true;
    };

    nix = {
        settings = {
            auto-optimise-store = true;
	    experimental-features = [ "nix-command" "flakes" ];
        };
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
    };

    environment = {
        variables = {
            EDITOR = "vim";
            VISUAL = "vim";
        };
        systemPackages = with pkgs; [
            neovim 
            git 
            pciutils
	    lsof
            usbutils
            killall
            xterm
            wget 
            file 
	    cached-nix-shell
        ];
    };
}
