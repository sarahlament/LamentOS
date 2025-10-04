{
  config,
  pkgs,
  lib,
  ...
}: {
  hardware.graphics.enable = true; # graphics are wanted
  services = {
    dbus.enable = true;
    xserver.enable = true; # needed for compatibility reasons even though wayland is used

    tuned = {
      enable = true;
      ppdSupport = true; # This is default anyway
      ppdSettings.main = {
        default = "performance"; # Maps to "throughput-performance"
        battery_detection = false;
      };
    };

    displayManager = {
      autoLogin = {
        enable = true; # auto login
        user = "lament"; # as the default user
      };
      # gdm = {
      #   enable = true; # gdm is reported to work with hyprland, so let's use it since I won't have to configure it
      #   wayland = true; # let's prefer using wayland over x11
      # };
      sddm = {
        enable = true; # SDDM works great with KDE Plasma
        wayland.enable = true; # let's prefer using wayland over x11
      };
    };
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    fwupd.enable = true; # firmware update service
  };

  # XDG Desktop Portal configuration for KDE
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
    xdgOpenUsePortal = true;
  };

  security.sudo.wheelNeedsPassword = false; # honestly, I'm tired of typing my password every time

  programs.ccache.enable = true;
  security.rtkit.enable = true; # let's use the realtime kit

  virtualisation.virtualbox = {
    host.enable = true;
    host.enableExtensionPack = true;
  };
  users.extraGroups.vboxusers.members = ["lament"];
}
