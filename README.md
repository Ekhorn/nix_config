# Nix Configuration

### Minimal Installation

Based on <https://nixos.org/manual/nixos/stable/#sec-installation-manual>

```sh
sudo -i
```

```sh
sudo systemctl start wpa_supplicant
```

```sh
wpa_cli
0
set_network 0 ssid "network"
OK
set_network 0 psk "password"
OK
enable_network 0
OK
quit
```

**UEFI (GPT)**

```sh
parted /dev/disk1 -- mklabel gpt
parted /dev/disk1 -- mkpart root ext4 512MB -8GB
parted /dev/disk1 -- mkpart swap linux-swap -8GB 100%
parted /dev/disk1 -- mkpart ESP fat32 1MB 512MB
parted /dev/disk1 -- set 3 esp on
```

**(Optional) LUKS Setup**

```sh
cryptsetup luksFormat /dev/disk1part1
cryptsetup luksOpen /dev/disk1part1 crypted
mkfs.ext4 /dev/mapper/crypted
```

**Formatting**

```sh
mkfs.ext4 -L nixos /dev/disk1part2 # Skip when using LUKS
mkswap -L swap /dev/disk1part2
mkfs.fat -F 32 -n boot /dev/disk1part3
```

**Installing**

```sh
mount /dev/disk/by-label/nixos /mnt # No LUKS
mount /dev/mapper /mnt # LUKS
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
swapon /dev/disk1part2
```

```sh
nixos-generate-config --root /mnt
```

Configure `hostname`, enable `networking.networkmanager.enable`, set `user` with package `git` and save.

```sh
nano /mnt/etc/nixos/configuration.nix
```

Install nixos

```sh
nixos-install
```

Set user password and reboot.

```sh
nixos-enter --root /mnt -c 'passwd user'
reboot
```

### Setup

Assuming the repo is cloned (use `nmtui` for wifi).

```sh
cd develop/nix_config
```

Copy the hardware configuration to the host directory.

```sh
cp /etc/nixos/hardware-configuration.nix hosts/my-host
```

Wipe the old nixos configuration.

```sh
sudo rm -rf /etc/nixos/*
```

Symlink new configuration.

```sh
sudo ln -s flake.nix /etc/nixos/flake.nix
```

Lastly, rebuild the nixos configuration and reboot.

```sh
sudo nixos-rebuild switch .#my-host
reboot
```

### Post-install Secrets Configuration

Update password manager.

```sh
unison
keepassxc ~/Desktop/$USER.kdbx
```

Create and add new ssh key.

```sh
ssh-keygen
cat ~/.ssh/id_*.pub >> modules/nixos/authorized_keys
git commit -m "conf: add authorized public key" --no-gpg-sign
```

Then copy GPG from other system, you may need to reboot the system.

```sh
ssh other@hostname 'gpg --export-secret-keys -a "$(gpg -K | rg -o "[A-F0-9]{40}")"' | gpg --import
gpg --edit-key "$(gpg -K | rg -o "[A-F0-9]{40}")"
seahorse
```

### Mounting drives

<!-- TODO: consider disko configs?? -->

List drives

```sh
lsblk -f -o NAME,UUID,FSTYPE,SIZE
```

Set drive to mount

```sh
nvim hosts/new-host/hardware-configuration.nix
```

```nix
fileSystems."/mnt/hdd" =
  { device = "/dev/disk/by-uuid/uuid";
    fsType = "ext4";
  };
```

### NixOS Anyhwere

```sh
nix run github:nix-community/nixos-anywhere -- \
  --generate-hardware-config nixos-generate-config ./<configuration-name>/hardware-configuration.nix --no-substitute-on-destination \
  --flake .#<configuration-name> root@<ip address>
```

```sh
ssh user@<ip address>
ssh root@<ip address>
passwd user
```

```nix
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      # PasswordAuthentication = false;
      # PermitRootLogin = "no";
      # UsePAM = false;
      # KbdInteractiveAuthentication = false;
    };
  };
```

```sh
nixos-rebuild --target-host user@ip-address --use-remote-sudo switch --flake .#<configuration-name>
```
