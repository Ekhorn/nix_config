{ config, ... }:

{
  users.users = {
    root.openssh.authorizedKeys.keys =
      config.users.users."${config.user.username}".openssh.authorizedKeys.keys;
  };
}
