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
  };
  # maybe I need this to make cursors work correctly??
  home.pointerCursor.enable = true;
}
