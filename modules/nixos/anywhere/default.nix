{
  # The following modules MUST be specific, and NOT general like "security" or
  # "services", only "common" is allowed.
  common = import ./common.nix;
  disko-config = import ./disko-config.nix;
  user = import ../user.nix;
}
