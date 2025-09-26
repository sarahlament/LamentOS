# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Development Commands

### NixOS Configuration Management
- `sudo nixos-rebuild switch --flake .` - Apply current flake configuration to the system
- `nixos-rebuild dry-run --flake .` - Preview changes without applying them
- `nix flake update` - Update all flake inputs to latest versions
- `nix flake check --show-trace` - Validate flake configuration for syntax errors

**Note**: Flake input source code is directly available at `~/.nix-inputs/` with symlinks to:
- `nixpkgs/` - NixOS packages and modules source
- `home-manager/` - Home Manager modules and options
- `stylix/` - System theming framework source
- `nixvim/` - NixOS Neovim configuration source
- `lanzaboote/` - Secure boot implementation source
- `aagl/` - Anime game launcher support source

### Development and Testing
- `nix develop` - Enter development shell if devShell is configured
- `nix build .#nixosConfigurations.LamentOS.config.system.build.toplevel` - Build system configuration without applying

## Architecture Overview

This is a NixOS system configuration flake for "LamentOS" with the following structure:

### Core Configuration Files
- `flake.nix` - Main flake definition with inputs and module imports
- MODULES HAVE BEEN MOVED TO ~/.lamentos

### System Configuration (system/)
- `system/default.nix` - Index file importing all system modules
- `system/disks.nix` - Disk configuration and partitioning
- `system/boot.nix` - Boot configuration with secure boot via lanzaboote
- `system/core.nix` - Core system configuration (networking, display manager, SSH, graphics, tuned)
- `system/user.nix` - User-specific system settings (audio via PipeWire, Hyprland, fonts)
- `system/sysStylix.nix` - System-wide theming using Stylix (generates colors from wallpaper.png)
- `system/aagl.nix` - Anime game launcher configuration
- `system/nixconf.nix` - Nix-level configuration (experimental features, etc.)

### Home Manager Configuration (home/)
- `home/default.nix` - Index file importing all home modules
- `home/env.nix` - Environment variables (MAKEFLAGS, ZSH_COMPDUMP)
- `home/terminal.nix` - Terminal and CLI tools (kitty, git, eza, btop, fastfetch, bat)
- `home/development.nix` - Development environment (VSCodium, claude-code)
- `home/shell.nix` - Shell configuration (zsh with oh-my-posh prompt)
- `home/hypr.nix` - Hyprland window manager configuration with scratchpads
- `home/nixvim.nix` - Neovim configuration via nixvim
- `home/pkgs.nix` - User packages
- `home/usrStylix.nix` - User-level theming options

### Key Architecture Details
- **Modular structure**: Uses `default.nix` files for clean imports - system modules via `(import ./system)` and home modules via `(import ./home)`
- **Zero inline configuration**: flake.nix contains only essential structure with all configuration properly modularized
- **Custom modules**: `userConf` and `sysConf` modules that dynamically configure users and system settings
- **Centralized user management**: All home-manager configuration consolidated in userConf module
- **Home Manager integration**: Integrated at the NixOS level via userConf, not standalone
- **Window manager**: Hyprland with GDM display manager, includes scratchpad configurations with btop
- **Theming**: Stylix provides system-wide theming by generating colors from wallpaper.png
- **Performance tuning**: TuneD with power-profiles-daemon integration for optimal desktop performance
- **Development environment**: Organized terminal tools (btop, git, eza) and development tools (VSCodium, claude-code) in separate modules
- **Configuration scope**: Clear separation between system-level (NixOS) and user-level (Home Manager) concerns
- **System identity**: Hostname "LamentOS", state version "25.11" via sysConf module
- **Hardware support**: NVIDIA support configurable through sysConf.nvidia options
- **Nix configuration**: Dedicated nixconf.nix module for Nix-level settings (experimental features, etc.)

### Current User Configuration
- Username: "lament" (configurable via userConf.name)
- Shell: zsh (configurable via userConf.shell - supports zsh, bash, dash, fish)
- Uses secure boot with lanzaboote
- Auto-login enabled for the configured user
- Sudo without password for wheel group members
- NVIDIA drivers enabled by default with open-source drivers

### Module System
The configuration uses a modular approach with two main custom modules:
- `userConf`: Handles user creation, shell selection, and home-manager integration
- `sysConf`: Manages system-wide settings including state versions and hardware-specific configurations like NVIDIA

This allows for easy customization of the system by modifying options rather than directly editing configuration files.
