{ config, pkgs, ... }:

{
	# Let's move some user-level settings here instead of in system.nix
	services = {
		flatpak.enable = true;
		pipewire = {
			enable = true;
			pulse.enable = true;
			alsa.enable = true;
			wireplumber.enable = true;
		};
	};

	programs = {
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
	};

	# Set my user config
	users.users.lament = {
		isNormalUser = true;
		shell = pkgs.zsh;
		extraGroups = [ "wheel" "systemd-journal" ];
		packages = with pkgs; [
			# basic things I use
			git
			curl

			# and let's include the hypr ecosystem
			hyprpaper
			hyprcursor
			hyprlock
			hypridle
			hyprsysteminfo
			hyprpolkitagent
			hyprland-qt-support
			kitty
      
			# a few extras
			discord
			matugen
			fastfetch
			eza

			# wl-clip things
			wl-clipboard
			wl-clip-persist
		];
	};
}
