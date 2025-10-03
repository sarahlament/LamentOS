{
  config,
  lib,
  pkgs,
  ...
}: {
  stylix = {
    # let's have nvim transparent
    targets.nixvim.transparentBackground = {
      main = true;
      numberLine = true;
      signColumn = true;
    };

    # Disable Qt theming - KDE Plasma 6 handles Qt apps natively
    targets.qt.enable = false;
  };
}
