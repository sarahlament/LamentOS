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
      applications = 0.8;
      terminal = 0.75;
      desktop = 0.5;
      popups = 0.95;
    };
  };
}
