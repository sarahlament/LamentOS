outputs = { self, nixpkgs }:

{
  # Set my user config
  users.users.lament = {
    isNormalUser = true;
    extraGroups = [ "wheel" "systemd-journal" ];
    packages = with nixpkgs; [
      # basic things I use
      git
      curl
      
      # and let's include the hypr ecosystem
      hyprpaper
      hyprcursor
      hyprlock
      hypridle
      hyprsysteminfo
      hyprpolkitagent
      hyprland-qt-support
      kitty
      
      # a few extras
      discord
      matugen
      catppuccin-cursors
      fastfetch
      eza
    ];
  };
}
