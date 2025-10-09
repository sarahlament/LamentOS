{
  config,
  lib,
  pkgs,
  ...
}: {
  services.flatpak.enable = true; # flatpak is useful for some things, like my browser (for now, at least)

  programs.steam.enable = true; # yes, I play games when I'm not five hours into coding this lol
  programs.gamemode = {
    enable = true;
    settings = {
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
      };
    };
  };
  programs.gamescope = {
    enable = true;
    args = [
      "--rt"
      "--fullscreen"
      "--hdr-enabled"
      "--force-grab-cursor"
      "--backend wayland"
      "--mangoapp"
      "--prefer-output DP-1"
      "-W2560 -H1440 -r165"
    ];
    env = {
      DXVK_HDR = "1";
      ENABLE_GAMESCOPE_WSI = "1";
    };
  };

  services.ratbagd.enable = true;
}
