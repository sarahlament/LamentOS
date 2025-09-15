{
	config,
	pkgs,
	lib,
	hostname,
	...
}: {
	nixpkgs.config.allowUnfree = true; # allow 'unfree' software
	networking.networkmanager.enable = true; # network-manager just kinda works from my experience
	networking.hostName = hostname;
	networking.firewall.enable = true; # enable firewall for security
	time.timeZone = "America/Chicago"; # let's set our timezone

	hardware.graphics.enable = true; # graphics are wanted
	services = {
		xserver = {
			enable = true; # needed for compatibility reasons even though wayland is used
		};

		displayManager = {
			autoLogin = {
				enable = true; # auto login
				user = "lament"; # as me
			};
			gdm = {
				enable = true; # gdm is reported to work with hyprland, so let's use it since I won't have to configure it
				wayland = true; # let's prefer using wayland over x11
			};
		};
		openssh = {
			enable = true;
			settings = {
				PasswordAuthentication = false;
				PermitRootLogin = "no";
			};
		};
		fwupd.enable = true; # firmware update service
	};

	security.sudo.wheelNeedsPassword = false; # honestly, I'm tired of typing my password everytime
	programs.ccache.enable = true; # let's use ccache to help with builds on the system itself

	security.rtkit.enable = true; # let's use the realtime kit
}
