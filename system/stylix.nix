{
  config,
  lib,
  pkgs,
  ...
}: {
  stylix = {
    image = ../wallpaper.png;

    # Set opacity for various elements
    opacity = {
      applications = 0.85;
      terminal = 0.85;
      desktop = 0.5;
      popups = 0.95;
    };
  };
}
