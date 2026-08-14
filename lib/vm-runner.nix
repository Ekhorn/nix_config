{ lib }:

# Wrap a nixosConfiguration's VM with a runner (QEMU binary, shell script)
# native to `system` (the machine evaluating the flake), which is also the
# machine that runs the VM. The guest may have a different architecture
# (e.g. an aarch64 guest built on x86_64 via binfmt emulation).
#
# This cannot live in the build-vm NixOS modules: pure evaluation hides the
# evaluating machine (`builtins.currentSystem` is unavailable), while the
# module's `pkgs` is the guest package set. Only the flake knows `system`.
system: pkgs: cfg:

let
  # KVM can only accelerate guests matching this machine's architecture
  kvmAvailable = (lib.systems.elaborate system).canExecute cfg.pkgs.stdenv.hostPlatform;
in
(cfg.extendModules {
  modules = [
    { virtualisation.vmVariant.virtualisation.host.pkgs = pkgs; }
  ]
  # Cross-architecture guest: go straight to TCG emulation instead of
  # trying KVM first and printing a warning
  ++ lib.optional (!kvmAvailable) {
    virtualisation.vmVariant.virtualisation.qemu.options = [ "-machine accel=tcg" ];
  };
}).config.system.build.vm
