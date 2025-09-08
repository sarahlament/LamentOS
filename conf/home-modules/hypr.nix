{ config, pkgs, lib, ... }:

{
	programs = {
		# widget system
		waybar = {
			enable = true;
			systemd.enable = true;
		};

		# lock screen for idle (NYI)
#       hyprlock.enable = true;
	};

	# let's handle XDG things
	home.preferXdgDirectories = true;
	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-gtk # allows GTK based apps to work correctly
		];
		configPackages = [ pkgs.hyprland ]; # use hyprland as the configuration pkg
	};

	services = {
		hyprpolkitagent.enable = true; # polkit helper for hyprland
		hyprpaper.enable = true; # wallpaper daemon
		hypridle.enable = true; # idle after an ammount of time
	};
}
