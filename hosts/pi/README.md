# Deploying to Raspberry Pi

## Installation

```sh
zstdcat nixos-image-sd-card-<version>-aarch64-linux.img.zst | sudo dd of=/dev/sdX bs=4M status=progress
sync
```

References

- https://wiki.nixos.org/wiki/NixOS_on_ARM
- https://wiki.nixos.org/wiki/NixOS_on_ARM/Raspberry_Pi_4

## Configuration

```sh
# Don't forget to set a password
nixos-rebuild --target-host user@<ip-address> --sudo switch --flake .#pi
```

### Manual firmware configuration

```sh
sudo mkdir -p /mnt/firmware
sudo mount /dev/disk/by-label/FIRMWARE /mnt/firmware
echo "dtoverlay=vc4-kms-v3d" | sudo tee -a /mnt/firmware/config.txt
echo "dtoverlay=vc4-kms-dsi-7inch" | sudo tee -a /mnt/firmware/config.txt
echo "max_framebuffers=2" | sudo tee -a /mnt/firmware/config.txt
sudo umount /mnt/firmware
```
