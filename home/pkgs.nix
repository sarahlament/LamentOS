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

    xdg-utils

    lsfg-vk
    lsfg-vk-ui

    discord

    wl-clipboard
    wl-clip-persist

    gdu
    playerctl
    pwvucontrol
    headsetcontrol

    nil
    alejandra

    mangohud
    piper
  ];
}
