{ lib, inputs, nixpkgs, system, home-manager, user, nix-doom-emacs, nixos-hardware, ... }:

let
  se_a5 = pkgs.writeText "se-a5" ''
    xkb_symbols "a5" {

    include "se(basic)"

    name[Group1]="Swedish (A5)";


    key <AE01> { [ 1,          exclam,     none,                none ] };
    key <AE02> { [ 2,          quotedbl,   at,                  none ] };
    key <AE03> { [ 3,          numbersign, sterling,            none ] };
    key <AE04> { [ 4,          dollar,     dollar,              none ] };
    key <AE05> { [ 5,          percent,    none,                none ] };
    key <AE06> { [ 6,          ampersand,  none,                none ] };
    key <AE07> { [ 7,          slash,      braceleft,           none ] };
    key <AE08> { [ 8,          parenleft,  bracketleft,         none ] };
    key <AE09> { [ 9,          parenright, bracketright,        none ] };
    key <AE10> { [ 0,          equal,      braceright,          none ] };
    key <AE11> { [ plus,       question,   backslash,           none ] };
    key <AE12> { [ dead_acute, dead_grave, none,                none ] };

    key <AD01> { [ q,          Q,          braceleft,           none ] };
    key <AD02> { [ w,          W,          braceright,          none ] };
    key <AD03> { [ e,          E,          bracketleft,         none ] };
    key <AD04> { [ r,          R,          bracketright,        none ] };
    key <AD05> { [ t,          T,          dollar,              none ] };
    key <AD06> { [ y,          Y,          quotedbl,            none ] };
    key <AD07> { [ u,          U,          question,            none ] };
    key <AD08> { [ i,          I,          ampersand,           none ] };
    key <AD09> { [ o,          O,          less,                none ] };
    key <AD10> { [ p,          P,          greater,             none ] };
    key <AD11> { [ aring,      Aring,      none,                none ] };
    key <AD12> { [ dead_diaeresis, dead_circumflex, dead_tilde, asciicircum ]};

    key <AC01> { [ a,          A,          semicolon,           none ] };
    key <AC02> { [ s,          S,          slash,               none ] };
    key <AC03> { [ d,          D,          parenleft,           none ] };
    key <AC04> { [ f,          F,          parenright,          none ] };
    key <AC05> { [ g,          G,          bar,                 none ] };
    key <AC06> { [ h,          H,          numbersign,          none ] };
    key <AC07> { [ j,          J,          asciicircum,         none ] };
    key <AC08> { [ k,          K,          numbersign,          none ] };
    key <AC09> { [ l,          L,          quotedbl,            none ] };
    key <AC10> { [ odiaeresis, Odiaeresis, asciitilde,          none ] };
    key <AC11> { [ adiaeresis, Adiaeresis, grave,               none ] };

    key <AB01> { [ z,          Z,          colon,               none ] };
    key <AB02> { [ x,          X,          equal,               none ] };
    key <AB03> { [ c,          C,          at,                  none ] };
    key <AB04> { [ v,          V,          exclam,              none ] };
    key <AB05> { [ b,          B,          backslash,           none ] };
    key <AB06> { [ n,          N,          percent,             none ] };
    key <AB07> { [ m,          M,          mu,                  none ] };
    key <AB08> { [ comma,      semicolon,  none,                none ] };
    key <AB09> { [ period,     colon,      none,                none ] };
    key <AB10> { [ minus,      underscore, none,                none ] };

    key <TLDE> { [ grave,      asciitilde, none,                none ] };
    key <BKSL> { [ apostrophe, asterisk,   asterisk,            none ] };
  };
'';

  

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  i9 = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user se_a5;
    };
    modules = [
      ./i9
      ./configuration.nix # Global configuration for every host

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          home.stateVersion = "22.11";
          imports = [ nix-doom-emacs.hmModule (import ./home.nix) ] ++ [(import ./i9/home.nix)];
        };
      }
    ];
  };
  surface = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user se_a5 nixos-hardware;
    };
    modules = [
      ./surface
      ./configuration.nix # Global configuration for every host
      nixos-hardware.nixosModules.microsoft-surface-pro-intel

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          home.stateVersion = "22.11";
          imports = [ (import ./home.nix) ] ++ [(import ./surface/home.nix)];
        };
      }
    ];
  };
}
