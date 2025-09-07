{ config, pkgs, lib, ... }:

{
    home.username = "lament"; # let's give it our username
    home.homeDirectory = "/home/lament"; # and the home directory
    home.stateVersion = "25.11"; # DO NOT CHANGE THIS!
    home.file = { }; # this can be used to define files and their content

    # set certain variables I want set at the start of my login
    home.sessionVariables = {
        LIBVA_DRIVER_NAME = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        ELECTRON_OZON_PLATFORM_HINT = "auto";
    };
}
