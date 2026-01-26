{ ... }:

{
  users.users.vmtest.isSystemUser = true;
  users.users.vmtest.initialPassword = "test";
  users.users.vmtest.group = "vmtest";
  users.groups.vmtest = { };
  # vmVariant depends on: https://github.com/NixOS/nixpkgs/blob/nixos-25.11/nixos/modules/virtualisation/qemu-vm.nix
  # default qemu: options are set here https://github.com/NixOS/nixpkgs/blob/nixos-25.11/nixos/lib/qemu-common.nix
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 2048;
      cores = 4;
    };
    virtualisation.qemu.options = [
      "-cpu host"
      "-device virtio-rng-pci,rng=rng0"
      "-display gtk,gl=on,grab-on-hover=on,show-cursor=on,zoom-to-fit=on"
      "-enable-kvm"
      "-machine pc,accel=kvm"
      "-object rng-random,id=rng0,filename=/dev/urandom"
      "-vga virtio"
    ];
  };
}
