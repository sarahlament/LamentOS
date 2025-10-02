# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Development Commands

### NixOS Configuration Management
- `sudo nixos-rebuild switch --flake .` - Apply current flake configuration to the system
- `nixos-rebuild dry-run --flake .` - Preview changes without applying them
- `nix flake update` - Update all flake inputs to latest versions
- `nix flake check` - Validate flake configuration for syntax errors

## Architecture Overview

This is a NixOS system configuration that uses the LamentOS module system - a custom flake-based module system for managing NixOS configurations.

### Repository Structure

**Main Configuration Repository** (`~/.nix-conf`):
- `flake.nix` - Main system flake that imports the LamentOS module system
- `system/` - System-level configuration modules (boot, disks, core, user, etc.)
- `home/` - Home Manager configuration modules (shell, terminal, development, etc.)
- `wallpaper.png` - Wallpaper used by Stylix for theme generation

**LamentOS Module System** (`~/.lamentos`):
- `flake.nix` - LamentOS module system flake definition
- `modules/` - Reusable NixOS modules with a clean option-based API
  - `graphics/` - Graphics configuration (NVIDIA, etc.)
  - `system/` - System modules (identity, theming)
  - `user/` - User management modules
  - `shell/` - Shell-related modules

### Key Architecture Principles

- **Dual-repository design**: Main config in `~/.nix-conf`, reusable modules in `~/.lamentos`
- **Module system**: LamentOS provides clean `lamentos.*` options (e.g., `lamentos.graphics.nvidia.enable`)
- **Flake inputs**: Main flake imports lamentos as a local git flake input
- **Modular imports**: Both repos use `default.nix` files to aggregate module imports
- **Separation of concerns**: System-level (NixOS) vs user-level (Home Manager) configuration
- **Home Manager integration**: Integrated at NixOS level, user-specific configs in `home/`
- **Stylix theming**: System-wide theming from `wallpaper.png`

### Module Categories

**System modules** (`~/.nix-conf/system/`):
- Core system configuration (networking, display, hardware)
- Boot configuration (secure boot via lanzaboote)
- Disk configuration and partitioning
- Nix daemon settings

**Home modules** (`~/.nix-conf/home/`):
- Shell configuration and terminal tools
- Development environment setup
- Window manager configuration (Hyprland)
- User packages and applications
- Git and version control settings

**LamentOS modules** (`~/.lamentos/modules/`):
- Reusable abstractions with option-based APIs
- Graphics hardware configuration
- System identity and theming
- User management
- system grep is ripgrep