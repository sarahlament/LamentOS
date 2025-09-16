# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Development Commands

### NixOS Configuration Management
- `sudo nixos-rebuild switch --flake .` - Apply current flake configuration to the system
- `nix flake update` - Update all flake inputs to latest versions
- `nix flake check` - Validate flake configuration for syntax errors
- `nixos-rebuild dry-run --flake .` - Preview changes without applying them

### Development and Testing
- `nix develop` - Enter development shell if devShell is configured
- `nix build .#nixosConfigurations.LamentOS.config.system.build.toplevel` - Build system configuration without applying

## Architecture Overview

This is a NixOS system configuration flake for "LamentOS" with the following structure:

### Core Configuration Files
- `flake.nix` - Main flake definition with inputs (nixpkgs, home-manager, nixvim, catppuccin, lanzaboote)
- `modules/userConf.nix` - Custom NixOS module for user configuration with options for name, fullName, and shell
- `conf/core.nix` - System-level configuration (networking, display manager, SSH, graphics)
- `conf/user.nix` - User-specific configuration (audio via PipeWire, Hyprland, fonts)
- `conf/boot.nix` - Boot configuration with secure boot via lanzaboote
- `conf/nvidia.nix` - NVIDIA-specific configuration

### Home Manager Modules (in conf/home-modules/)
- `hypr.nix` - Hyprland window manager configuration with Catppuccin theming
- `shell.nix` - Shell configuration (zsh)
- `nixvim.nix` - Neovim configuration via nixvim
- `pkgs.nix` - User packages
- `env.nix` - Environment and terminal tools
- `ai-cli.nix` - AI CLI tools configuration

### Key Architecture Details
- Uses a custom `userConf` module that dynamically configures users and shell integration
- Home Manager is integrated at the NixOS level, not standalone
- System uses Hyprland as the window manager with GDM display manager
- Catppuccin theme is applied system-wide via the catppuccin flake input
- Configuration is split between system-level (NixOS) and user-level (Home Manager) concerns
- The hostname is set to "LamentOS" and can be changed in flake.nix
- State version is globally defined as "25.11" in flake.nix

### Current User Configuration
- Username: "lament"
- Shell: zsh
- Uses secure boot with lanzaboote
- Auto-login enabled for user "lament"
- Sudo without password for wheel group
