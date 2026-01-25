{ ... }:

{
  users.users.vmtest.isSystemUser = true;
  users.users.vmtest.initialPassword = "test";
  users.users.vmtest.group = "vmtest";
  users.groups.vmtest = { };

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 2048;
      cores = 4;
    };
  };
}
