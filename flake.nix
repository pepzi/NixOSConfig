{
  description = "NixOS System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ...}@inputs:
    let
      inherit (nixpkgs) lib;

      util = import ./lib {
        inherit system pkgs home-manager lib; overlays = (pkgs.overlays);
      };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [];
      };

      system = "x86_64-linux";

    in {
      homeManagerConfigurations = {
        robert = user.mkHMUser {
	  userConfig = {
	    git.enable = true;
	  };
       };
     };

      nixosConfigurations = {
        i9 = host.mkHost {
          name = "i9";
	  NICs = [ "enp4s0" ];
	  kernelPackage = pkgs.linuxPackages;
	  initrdMods = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
	  kernelMods = [ "kvm-intel" ];
	  kernelParams = [];
	  systemConfig = {
            # your abstracted system config
          };
	  users = [{
	    name = "robert";
	    groups = [ "wheel" "networkmanager" "video" ];
	    uid = 1000;
	    shell = pkgs.bash;
	  }];
	  cpuCores = 10;

        };
        #vboxnox = host.mkHost {
          # ...
        #};
      };
    };
}
