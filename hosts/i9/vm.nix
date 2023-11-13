{ config, pkgs, ... }:

{

  # Enable dconf (System Management Tool)
  programs.dconf.enable = true;

  # Add user to libvirtd group
  users.users.robert.extraGroups = [ "libvirtd" "qemu-libvirtd" ];
  users.groups.libvirtd.members = [ "root" "robert" ];
  environment.variables = {
    LIBVIRT_DEFAULT_URI = "qemu:///system";
  };

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice spice-gtk
    spice-protocol
    win-virtio
    looking-glass-client
    win-spice
    gnome.adwaita-icon-theme
  ];

  # Manage the virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  systemd.tmpfiles.rules = 
    [
      "f /dev/shm/looking-glass 0660 robert qemu-libvirtd -"
    ];

}
