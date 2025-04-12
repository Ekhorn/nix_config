{ ... }:

{
  programs.virt-manager.enable = true;

  #services.qemuGuest.enable = true;
  #services.spice-vdagentd.enable = true;

  users.groups.libvirtd.members = [ "koen" ];

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
