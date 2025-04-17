{
  # The following modules MUST be specific, and NOT general like "security" or
  # "services", only "common" is allowed.
  common = import ./common.nix;
  docker = import ./docker.nix;
  gnome = import ./gnome.nix;
  # greetd = import ./greetd.nix;
  # hyprland = import ./hyprland.nix;
  nvidia = import ./nvidia.nix;
  qemu = import ./qemu.nix;
  # qmk = import ./qmk.nix;
  rust = import ./rust.nix;
  ssh = import ./ssh.nix;
  user = import ./user.nix;
  # wayland = import ./wayland.nix;
}
