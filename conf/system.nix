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
		displayManager.lightdm.enable = false;
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
		pipewire = {
			enable = true;
			pulse.enable = true;
			alsa.enable = true;
			wireplumber.enable = true;
		};
		greetd.enable = true;
		openssh.enable = true;
	};

	# Let's define some system-wide programs and such
	programs = {
		regreet.enable = true;
		command-not-found.enable = true;

		nano.enable = false;
		neovim = {
			enable = true;
			defaultEditor = true;
			vimAlias = true;
		};
		bat.enable = true;
		fzf.keybindings = true;

		hyprland = {
			enable = true;
			withUWSM = true;
			xwayland.enable = true;
		};
		waybar.enable = true;

		zsh.enable = true;
		firefox.enable = true;
	};

	# Let's install the nerdfonts
	fonts.packages = with pkgs; [
		noto-fonts-cjk-sans
		noto-fonts-emoji
		nerd-fonts.ubuntu
		nerd-fonts.ubuntu-mono
		nerd-fonts.fira-code
		nerd-fonts.fira-mono
		nerd-fonts.hack
		nerd-fonts.noto
	];
}

