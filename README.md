# Dotfiles

### Setup

First clone this repository. To configure wifi run `nmtui`.

```sh
mkdir develop && cd develop
nix-shell -p git
git clone https://github.com/Ekhorn/dotfiles
```

Copy the hardware configuration to the host directory.

```sh
sudo cp /etc/nixos/hardware-configuration.nix nixos/hosts/default/
```

Symlink nix flake to `/etc/nixos/flake.nix`.

```sh
sudo rm -rf /etc/nixos/*
sudo ln -s ~/develop/dotfiles/nixos/flake.nix /etc/nixos/flake.nix
```

Setup user in configuration.

```sh
sudo nano /etc/nixos/default/configuration.nix
sudo nixos-rebuild switch /etc/nixos#hostname
```

Lastly, rebuild the nixos configuration and reboot.

```sh
sudo nixos-rebuild switch
reboot
```

Setup ssh.

```sh
ssh-keygen
sudo nvim nixos/modules/ssh.nix
# Temporarily enable password login
sudo nixos-rebuild test
```

Run `ssh-copy-id` on other system, and append their public key to our authorized keys.

```sh
ssh-copy-id $USER@my-hostname
ssh $USER@my-hostname "echo '$(cat ~/.ssh/id_rsa.pub)' >> ~/.ssh/authorized_keys"
chmod 600 ~/.ssh/authorized_keys
```

Then disable password login.

```sh
sudo nvim nixos/modules/ssh.nix
sudo nixos-rebuild test
```

Then run `unison` and open the password manager.

```sh
unison
keepassxc ~/Desktop/$USER.kdbx
```

Then copy GPG from other system.

```sh
ssh other@hostname 'gpg --export-secret-keys -a "$(gpg -K | rg -o "[A-F0-9]{40}")"' | gpg --import
gpg --edit-key "$(gpg -K | rg -o "[A-F0-9]{40}")"
nix-shell -p seahorse --run "seahorse" # Check if everything is correct
```

