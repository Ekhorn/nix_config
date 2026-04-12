# QEMU

### Prerequisite

Download <https://channels.nixos.org/nixos-24.11/latest-nixos-minimal-x86_64-linux.iso>

Create a VM (with at least a 10GB volume), click "Customize before install" in virtmanager and select UEFI firmware.

### Installation

See <https://nixos.org/manual/nixos/stable/#sec-installation-manual>

1. **Configure root & boot partitions**

```sh
sudo -i
parted /dev/vda -- mklabel gpt
parted /dev/vda -- mkpart root ext4 512MB -8GB
parted /dev/vda -- mkpart ESP fat32 1MB 512MB

parted /dev/vda -- set 2 esp on
```

2. **Format partitions**

```sh
mkfs.ext4 -L nixos /dev/vda1
mkfs.fat -F 32 -n boot /dev/vda2
```

3. **Installing**

```sh
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
nixos-generate-config --root /mnt
nano /mnt/etc/nixos/configuration.nix # Configure users
```

Install and set passwords.

```sh
nixos-install
nixos-enter --root /mnt -c 'passwd emu'
reboot
```

### Increasing root partition size

Open `vda` block device with parted.

```sh
parted /dev/vda
```

Check root partition id and resize.

```sh
print
resizepart 1 6GB
quit
```

Resize block device.

```sh
resize2fs /dev/vda1
df -h
```
