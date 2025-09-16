{
	config,
	pkgs,
	lib,
	...
}: {
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
		kdePackages.discover
		playerctl
		pwvucontrol
		headsetcontrol

		# nwg-shell components for KDE-like desktop experience
		nwg-panel # taskbar/panel (replaces waybar)
		nwg-drawer # application launcher/start menu
		nwg-look # GTK theme manager
		nwg-displays # display configuration tool
		nwg-clipman # clipboard history manager

		arch-install-scripts
	];
}
