{ lib, ... }:

let
  user = "test";
in
{
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
  };

  # Essential overwrites
  user.username = lib.mkVMOverride user;
  users.users.${user} = {
    initialPassword = lib.mkVMOverride "test";
  };
}
