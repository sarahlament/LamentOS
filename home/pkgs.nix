{
  config,
  pkgs,
  lib,
  ...
}: {
  # need an extra package? put them here!
  home.packages = with pkgs; [
    curl
    glib
    jq
    nodejs

    xdg-utils
    hyprcursor
    hyprsysteminfo
    hyprland-qt-support
    pyprland
    wofi

    lsfg-vk
    lsfg-vk-ui
    gamescope
    gamemode

    discord
    matugen

    wl-clipboard
    wl-clip-persist

    kdePackages.dolphin
    kdePackages.discover
    kdePackages.gwenview
    gdu
    playerctl
    pwvucontrol
    headsetcontrol

    nil
    alejandra
    python313Packages.editorconfig
  ];
}
