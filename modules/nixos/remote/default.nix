{ ... }:

{
  imports = [ ./ssh.nix ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  security.sudo.wheelNeedsPassword = true;
  security.pam.sshAgentAuth.enable = true;
}
