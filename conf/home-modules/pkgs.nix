{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		curl
		glib

		hyprcursor
		hyprsysteminfo
		hyprland-qt-support
		pyprland

		discord
		matugen

		wl-clipboard
		wl-clip-persist

		kdePackages.dolphin
		playerctl
		pwvucontrol
		preload
	];
}
