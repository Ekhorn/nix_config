{
  # The following modules MUST be specific, and NOT general like "security" or
  # "services", only "common" is allowed.
  common = import ./common.nix;
  gnome = import ./gnome.nix;
  # greetd = import ./greetd.nix;
  # hyprland = import ./hyprland.nix;
  nvidia = import ./nvidia.nix;
  rust = import ./rust.nix;
  ssh = import ./ssh.nix;
  user = import ./user.nix;
  virtualization = import ./virtualization.nix;
  # wayland = import ./wayland.nix;
}
