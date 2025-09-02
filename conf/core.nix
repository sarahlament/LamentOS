{ conf, pkgs, lib, ... }:

{
	# Let's allow 'unfree' software
	nixpkgs.config.allowUnfree = true;

	# Let's handle networking
	networking.networkmanager.enable = true;
	networking.hostName = "LamentOS";
	time.timeZone = "America/Chicago";

	# Enable the X11 windowing system.
	hardware.graphics.enable = true;
	services = {
		xserver = {
			enable = true;
			videoDrivers = [ "nvidia" ];
		};

		# Let's auto login using GDM
		displayManager = {
			autoLogin = {
				enable = true;
				user = "lament";
			};
			gdm = {
				enable = true;
				wayland = true;
			};
		};
	};

	# And make sure nvidia works correctly
	hardware.nvidia = {
		modesetting.enable = true;
		open = true;
		nvidiaSettings = true;
	};

	# Enable system services
	security.rtkit.enable = true;
	services = {
		openssh.enable = true;
	};

	# Let's install some fonts
	fonts.packages = with pkgs; [
		font-awesome
		noto-fonts-cjk-sans
		noto-fonts-emoji
		nerd-fonts.ubuntu
		nerd-fonts.ubuntu-mono
		nerd-fonts.fira-code
		nerd-fonts.fira-mono
		nerd-fonts.hack
		nerd-fonts.noto
		nerd-fonts.jetbrains-mono
	];
}

