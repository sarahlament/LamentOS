{
  config,
  lib,
  pkgs,
  ...
}: {
  services.flatpak.enable = true; # flatpak is useful for some things, like my browser (for now, at least)
  programs.steam.enable = true; # yes, I play games when I'm not five hours into coding this lol

  programs.hyprland = {
    enable = true; # enable the hyprland window manager
    withUWSM = true; # let's use better integration with systemd
    xwayland.enable = true; # and let's use the xwayland backend for things that need it
  };
}
