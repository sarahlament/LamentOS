# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix # Include the hardware scan. Some of these will be redefined later
      # lanzaboote was included earlier, so I should be fine without defining it here
    ];

  # Use lanzzaboote for secureboot
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";

  # Let's inform it about my cryptdevice
  boot.initrd.luks.devices.cryptroot = {
    device = "/dev/disk/by-uuid/bdddba9f-4c5c-4476-9404-8fb74d69cde6";
    preLVM = true;
  };

  # Let's not load a few modules
  boot.blacklistedKernelModules = [ "pcspkr" "nouveau" ];

  # And to unlock it with TPM2
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.tpm2.enable = true;
  security.tpm2.enable = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "scratchy"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Enable the X11 windowing system.
  hardware.graphics.enable = true;
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
  
  # And make sure nvidia works correctly
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  # Enable pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
  };

  # Let's set my default options here
  programs = {
    zsh.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };
    bat.enable = true;
    fzf.keybindings = true;

    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    waybar.enable = true;
    firefox.enable = true;
  };
  users.defaultUserShell = pkgs.zsh;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland xdg-desktop-portal-gtk ];
  };

  # Set my user config
  users.users.lament = {
  isNormalUser = true;
  extraGroups = [ "lament" "wheel" "systemd-journal" ];
  packages = with pkgs; [
      tree #? this is default, so let's leave it for now
      # basic things I use
      git
      curl

      # and let's include the hypr ecosystem
      hyprpaper
      hyprcursor
      hyprlock
      hypridle
      hyprsysteminfo
      hyprpolkitagent
      hyprland-qt-support
      kitty

      # a few extras
      discord
      dconf-editor
      matugen
      catppuccin-cursors
      fastfetch
    ];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    tpm2-tss
    tpm2-tools
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable a few experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # DO NOT CHANGE THIS!
  system.stateVersion = "25.05";
}

