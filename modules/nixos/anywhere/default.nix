{
  # The following modules MUST be specific, and NOT general like "security" or
  # "services", only "common" is allowed.
  common = import ./common.nix;
  build-vm = import ./build-vm.nix;
  disko-config = import ./disko-config.nix;
  user = import ../user.nix;
}
