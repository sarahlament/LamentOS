outputs = { self }:

{
  # Enable the X11 windowing system.
  hardware.graphics.enable = true;
  services.xserver = {
    displayManager.lightdm.enable = false;
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  # And make sure nvidia works correctly
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  # Enable pipewire
  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      wireplumber.enable = true;
    };
    greetd.enable = true;
    openssh.enable = true;
  };
  
  # Let's define some system-wide programs and such
  programs = {
    regreet.enable = true;
    command-not-found.enable = true;

    nano.enable = false;
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };
    bat.enable = true;
    fzf.keybindings = true;

    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    waybar.enable = true;

    zsh.enable = true;
  };
}
