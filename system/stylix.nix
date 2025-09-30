{
  config,
  lib,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    image = ../wallpaper.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-terminal-dark.yaml";
    cursor = {
      name = "Numix-Cursor-Light";
      package = pkgs.numix-cursor-theme;
      size = 32;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      serif = {
        package = pkgs.source-serif-pro;
        name = "Source Serif";
      };
    };

    # Font sizes
    fonts.sizes = {
      applications = 14;
      terminal = 14;
      desktop = 12;
      popups = 12;
    };

    # Set opacity for various elements
    opacity = {
      applications = 0.8;
      terminal = 0.75;
      desktop = 0.5;
      popups = 0.95;
    };
  };
}
