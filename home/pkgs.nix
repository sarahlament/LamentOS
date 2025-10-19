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
    nixd
    alejandra
    nodejs
    uv
    python3
    unrar

    dotnet-sdk_9

    xdg-utils
    wl-clipboard
    wl-clip-persist

    lsfg-vk
    lsfg-vk-ui
    r2modman
    mangohud
    piper

    discord
    ryubing

    gdu
    playerctl
    pwvucontrol
    headsetcontrol
  ];
}
