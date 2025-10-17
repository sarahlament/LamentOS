{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    tuned = {
      enable = true;
      ppdSupport = true; # This is default anyway
      ppdSettings.main = {
        default = "performance"; # Maps to "throughput-performance"
        battery_detection = false;
      };
    };
    displayManager = {
      autoLogin = {
        enable = true; # auto login
        user = "lament"; # as the default user
      };
    };
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    fwupd.enable = true; # firmware update service
  };

  programs.ccache.enable = true;
  programs.ccache.packageNames = [
    "nvidia-x11"
    "linux_zen"
  ];
  programs.nix-ld.enable = true;
  security.rtkit.enable = true; # let's use the realtime kit
}
