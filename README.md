# Nix Configuration

### Setup

First clone this repository. To configure wifi run `nmtui`.

```sh
mkdir develop && cd develop
nix-shell -p git
git clone https://github.com/Ekhorn/nix_config
```

Copy the hardware configuration to the host directory.

```sh
mkdir hosts/new-host/
cp /etc/nixos/hardware-configuration.nix hosts/new-host/
```

Symlink nix flake to `/etc/nixos/flake.nix`.

```sh
sudo rm -rf /etc/nixos/*
sudo ln -s ~/develop/nix_config/flake.nix /etc/nixos/flake.nix
```

Setup user in configuration, and adjust to your liking.

```sh
cp hosts/pc-koen/configuration.nix hosts/new-host
cp hosts/pc-koen/home.nix hosts/new-host
nano hosts/new-host/configuration.nix
nano hosts/new-host/home.nix
```

Create and add new ssh key.

```sh
ssh-keygen
cat ~/.ssh/id_*.pub >> modules/nixos/authorized_keys
git commit -m "conf: add authorized public key"
```

Lastly, rebuild the nixos configuration and reboot.

```sh
sudo nixos-rebuild switch .#new-host
reboot
```

### Post-install Secrets Configuration

Update password manager.

```sh
unison
keepassxc ~/Desktop/$USER.kdbx
```

Then copy GPG from other system.

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
