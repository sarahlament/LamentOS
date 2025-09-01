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
	services.xserver = {
		enable = true;
		videoDrivers = [ "nvidia" ];
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
		greetd.enable = true;
		openssh.enable = true;
	};

	# Let's define some system-wide programs and such
	programs.regreet = {
  		enable = true;

  		settings = {
    		background.path = "/xetc/wallpaper.png";
			interface = {
				font = "Sans 12";
				font_color = "#c6d0f5"; # text (frappe text)
				accent = "#ca9ee6";     # lavender accent
			};
			greeter = {
	 			border_radius = 16;
				button_color = "#303446";
	 			button_text_color = "#c6d0f5";
		 		highlight_color = "#babbf1"; # subtle accent for hover/focus
	 		};
		};
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

