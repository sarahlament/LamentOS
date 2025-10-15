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
    nil
    alejandra
    nodejs
    uv
    python3

    xdg-utils
    wl-clipboard
    wl-clip-persist

    lsfg-vk
    lsfg-vk-ui
    r2modman
    mangohud
    piper

    discord

    gdu
    playerctl
    pwvucontrol
    headsetcontrol
  ];
}
