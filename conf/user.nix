{
	config,
	lib,
	pkgs,
	...
}: {
	userConf = {
		name = "lament";
		fullName = "Sarah Lament";
	};

	services = {
		flatpak.enable = true; # flatpak is useful for some things
		pipewire = {
			enable = true; # audio is wanted, I hope...
			pulse.enable = true; # pulse backend for pipewire
			alsa.enable = true; # alsa backend for pipewire
			wireplumber.enable = true; # wireplumber session manager for pipewire
		};
	};

	programs.hyprland = {
		enable = true; # enable the hyprland window manager
		withUWSM = true; # let's use better integration with systemd
		xwayland.enable = true; # and let's use the xwayland backend for things that need it
	};

	programs.steam = {
		enable = true;
		extraPackages = with pkgs; [gamescope gamemode];
	};
	# Let's install some fonts
	fonts.packages = with pkgs; [
		font-awesome
		noto-fonts-cjk-sans
		nerd-fonts.jetbrains-mono
		inter
		source-serif-pro
	];
}
