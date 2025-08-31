{ config, pkgs, ... }:

{
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
			catppuccin-cursors
			fastfetch
			eza

			# wl-clip things
			wl-clipboard
			wl-clip-persist
		];
	};
}
