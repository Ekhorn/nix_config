{ lib, pkgs, ... }:

let
  user = "vmtest";
in
{
  # vmVariant depends on: https://github.com/NixOS/nixpkgs/blob/nixos-25.11/nixos/modules/virtualisation/qemu-vm.nix
  # default qemu: options are set here https://github.com/NixOS/nixpkgs/blob/nixos-25.11/nixos/lib/qemu-common.nix
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096; # 2048; # 8192;
      cores = 4;
    };
    virtualisation.qemu.options = [
      "-cpu host"
      "-device virtio-balloon"
      "-device virtio-rng-pci,rng=rng0"
      "-device virtio-vga-gl"
      "-display gtk,gl=on,grab-on-hover=on,show-cursor=on,zoom-to-fit=on"
      "-enable-kvm"
      "-machine q35,accel=kvm"
      "-object rng-random,id=rng0,filename=/dev/urandom"
      # "-nographic"
    ];

    # Guest user
    users.users.guest = {
      group = "guest";
      initialPassword = "guest";
      isSystemUser = true;
      shell = pkgs.zsh;
    };
    users.groups.guest = { };

    # Essential overwrites
    user.username = lib.mkVMOverride user;
    users.users.${user} = {
      initialPassword = lib.mkVMOverride "test";
    };
    home-manager.users.vmtest.home.username = lib.mkVMOverride user;

    # Non-essential overwrites
    services.avahi.enable = lib.mkVMOverride false;
    services.flatpak.enable = lib.mkVMOverride false; # Slow boot times as apps are installing
    services.ollama.enable = lib.mkVMOverride false;
    services.printing.enable = lib.mkVMOverride false;

    system.autoUpgrade.enable = lib.mkVMOverride false;
  };
}
