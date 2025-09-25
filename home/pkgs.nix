{
	config,
	pkgs,
	lib,
	...
}: {
	home.packages = with pkgs; [
		curl
		glib

		xdg-utils
		hyprcursor
		hyprsysteminfo
		hyprland-qt-support
		pyprland
		wofi

		lsfg-vk
		lsfg-vk-ui
		gamescope
		gamemode

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
