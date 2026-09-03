### AGENTS.md

Read project-level agent instructions before working if they exist and have not
already been read.

Prefer Zed's built-in file tools over terminal commands for reading and changing
files.

For Zed file tools, every path argument MUST begin with the opened project
root's directory name. This includes source and destination paths.

#### Path Examples

Example for a project named `nix_config`:

- Correct: `nix_config/packages/file.nix`
- Incorrect: `packages/file.nix`
- Incorrect: `/home/user/develop/nix_config/packages/file.nix`
