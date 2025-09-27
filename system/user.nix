{
	config,
	lib,
	pkgs,
	...
}: {
	lamentos.user = {
		name = "lament";
		fullName = "Sarah Lament";
	};

	services = {
		flatpak.enable = true; # flatpak is useful for some things
	};

	programs.hyprland = {
		enable = true; # enable the hyprland window manager
		withUWSM = true; # let's use better integration with systemd
		xwayland.enable = true; # and let's use the xwayland backend for things that need it
	};

	programs.steam.enable = true;
}
