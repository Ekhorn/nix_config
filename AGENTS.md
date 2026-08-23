# AGENTS.md

## Structure

```
.
├── hosts/                 # Host-specific configurations
│   └── anywhere/          # Minimal remotely deployed server hosts
├── lib/                   # Reusable Nix functions
├── modules/
│   ├── home-manager/      # Reusable Home Manager modules
│   │   └── anywhere/      # Minimal modules for anywhere hosts
│   ├── nixos/             # Reusable NixOS modules
│   │   ├── anywhere/      # Minimal modules for anywhere hosts
│   │   └── remote/        # Remote management modules
│   └── shared/            # Definitions shared across module systems
├── overlays/              # nixpkgs overlays
├── packages/              # Custom packages and derivations
├── patches/               # Upstream patches
└── shells/                # Development shells
```

Anywhere hosts are minimal servers, initially provisioned with `nixos-anywhere`
and maintained with remote builds. They should import only what they need.

Do not create general modules or directories such as `programs`, `services`,
or `security`. `common` is the only allowed general-purpose name.
