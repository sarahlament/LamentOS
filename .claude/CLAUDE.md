# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Development Commands

### NixOS Configuration Management
- `sudo nixos-rebuild switch --flake .` - Apply current flake configuration to the system
- `nixos-rebuild dry-run --flake .` - Preview changes without applying them
- `nix flake update` - Update all flake inputs to latest versions
- `nix flake check` - Validate flake configuration for syntax errors

### Development and Testing
- `nix develop` - Enter development shell if devShell is configured
- `nix build .#nixosConfigurations.LamentOS.config.system.build.toplevel` - Build system configuration without applying

## Architecture Overview

This is a NixOS system configuration flake for "LamentOS" with the following structure:

### Core Configuration Files
- `flake.nix` - Main flake definition with inputs (nixpkgs, home-manager, nixvim, stylix, catppuccin, lanzaboote)
- `modules/userConf.nix` - Custom NixOS module for user configuration with options for name, fullName, and shell
- `modules/sysConf.nix` - System configuration module handling stateVersion, systemType, allowUnfree, and NVIDIA settings
- `conf/core.nix` - System-level configuration (networking, display manager, SSH, graphics, auto-login)
- `conf/user.nix` - User-specific configuration (audio via PipeWire, Hyprland, fonts)
- `conf/boot.nix` - Boot configuration with secure boot via lanzaboote
- `conf/sysStylix.nix` - System-wide theming using Stylix with Catppuccin Mocha theme

### Home Manager Modules (in conf/home-modules/)
- `hypr.nix` - Hyprland window manager configuration
- `shell.nix` - Shell configuration (zsh)
- `nixvim.nix` - Neovim configuration via nixvim
- `pkgs.nix` - User packages
- `env.nix` - Environment and terminal tools
- `homeStylix.nix` - User-level theming configuration

### Key Architecture Details
- Uses custom `userConf` and `sysConf` modules that dynamically configure users and system settings
- Home Manager is integrated at the NixOS level via the flake, not standalone
- System uses Hyprland as the window manager with GDM display manager
- Stylix provides system-wide theming with Catppuccin Mocha as the base16 scheme
- Configuration is split between system-level (NixOS) and user-level (Home Manager) concerns
- The hostname is set to "LamentOS" and can be changed in flake.nix
- State version is globally defined as "25.11" via the sysConf module
- NVIDIA support is configurable through the sysConf.nvidia options

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