{ pkgs, config, lib, ... }:
with lib;

let
  cfg = config.pepzi.git;
in {
  options.jd.git = {
    enable = mkOption {
      description = "Enable git";
      type = types.bool;
      default = false;
    };

    username = mkOption {
      description = "Name for git";
      type = types.str;
      default = "Robert Sand";
    };

    userEmail = mkOption {
      description = "Email for git";
      type = types.str;
      default = "robert@pepzi.org";
    };
  };

  config = mkIf (cfg.enable) {
    programs.git = {
      enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;
      extraConfig = {
	credential.helper = "${
	  pkgs.git.override { withLibSecret = true; }
	}/bin/git-credential-libsecret";
      };
    };
  };
}
