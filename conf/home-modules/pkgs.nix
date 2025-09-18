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

		arch-install-scripts

		nil
		alejandra
	];
}
