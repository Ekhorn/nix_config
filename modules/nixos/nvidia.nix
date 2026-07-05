{ config, ... }:

{
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';

  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    };
    nvidia-container-toolkit.enable = true;
  };

  unfree.enable = true;
  unfree.packages = [
    "nvidia-kernel-modules"
    "nvidia-settings"
    "nvidia-x11"
  ];
}
