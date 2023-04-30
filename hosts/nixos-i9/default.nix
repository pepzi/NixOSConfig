# i9 -- my main desktop

{ ... }:
{
  imports = [
    ../home.nix
    ./hardware-configuration.nix
  ];

  modules = {
    editors = {
      default = "nvim";
      vim.enable = true;
    };
    services = {
      ssh.enable = true;
    };
  };

  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  time.timeZone = "Europe/Stockholm";
}
