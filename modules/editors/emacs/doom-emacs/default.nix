{ config, pkgs, location, ... }:

{
  services.emacs.enable = true;

  system.userActivationScripts = {               # Installation script every time nixos-rebuild is run. So not during initial install.
    doomEmacs = {
      text = ''
        source ${config.system.build.setEnvironment}
        EMACS="$HOME/.emacs.d"

        if [ ! -d "$EMACS" ]; then
          ${pkgs.git}/bin/git clone https://github.com/hlissner/doom-emacs.git $EMACS
          yes | $EMACS/bin/doom install
          rm -r $HOME/.doom.d
          ln -s ${location}/modules/editors/emacs/doom-emacs/doom.d $HOME/.doom.d
          $EMACS/bin/doom sync
        else
          $EMACS/bin/doom sync
        fi
      '';                                        # It will always sync when rebuild is done. So changes will always be applied.
    };
  };

  environment.systemPackages = with pkgs; [
    ripgrep
    coreutils
    fd
  ];
}
