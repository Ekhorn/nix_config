{ lib, pkgs, ... }:

let
  user = "test";
in
{
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096; # 2048; # 8192;
      cores = 4;
    };
    virtualisation.qemu.options =
      # Acceleration (KVM with TCG fallback), CPU and machine type defaults
      # are set by nixpkgs' qemu-common based on the host running the VM.
      # q35 and virtio-vga-gl are x86-only; aarch64 gets virt via qemu-common
      # and uses virtio-gpu-gl-pci for GL instead.
      lib.optionals pkgs.stdenv.hostPlatform.isx86 [
        "-machine q35"
        "-device virtio-vga-gl"
      ]
      ++ lib.optionals pkgs.stdenv.hostPlatform.isAarch64 [ "-device virtio-gpu-gl-pci" ]
      ++ [
        "-device virtio-balloon"
        "-device virtio-rng-pci,rng=rng0"
        "-display gtk,gl=on,grab-on-hover=on,show-cursor=on,zoom-to-fit=on"
        "-object rng-random,id=rng0,filename=/dev/urandom"
        # "-nographic"
      ];

    # Essential overwrites
    user.username = lib.mkVMOverride user;
    users.users.${user} = {
      initialPassword = lib.mkVMOverride "test";
    };
  };
}
