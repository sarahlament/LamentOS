{ conf, pkgs, lib, ... }:

{
	nixpkgs.config.allowUnfree = true; # allow 'unfree' software
	networking.networkmanager.enable = true; # network-manager just kinda works from my experience
	networking.hostName = "LamentOS"; # let's set our hostname
	time.timeZone = "America/Chicago"; # let's set our timezone

	hardware.graphics.enable = true; # graphics are wanted
	services = {
		xserver = {
			enable = true; # needed for compatibility reasons even though wayland is used
			videoDrivers = [ "nvidia" ]; # since we have nvidia, we need to care ONLY for that driver
		};

		displayManager = {
			autoLogin = {
				enable = true; # auto login
				user = "lament"; # as this user
			};
			gdm = {
				enable = true; # gdm is reported to work with hyprland, so let's use it since I won't have to configure it
				wayland = true; # let's prefer using wayland over x11
			};
		};
	};

	programs.ccache.enable = true; # let's use ccache to help with builds on the system itself

	hardware.nvidia = {
		modesetting.enable = true; # we need to allow nvidia modesetting for it to work
		open = true; # let's use the nvidia-open drivers
		nvidiaSettings = true; # and include the nvidia-settings application
	};

	security.rtkit.enable = true; # let's use the realtime kit
	services = {
		openssh.enable = true; # let's use a simple ssh server ( to be configured properly later)
	};
}

