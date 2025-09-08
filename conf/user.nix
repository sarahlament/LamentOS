{ config, pkgs, ... }:

{
	services = {
		flatpak.enable = true; # flatpak is useful for some things
		pipewire = {
			enable = true; # audio is wanted, I hope...
			pulse.enable = true; # pulse backend for pipewire
			alsa.enable = true; # alsa backend for pipewire
			wireplumber.enable = true; # wireplumber session manager for pipewire
		};
	};

	programs.zsh.enable = true; # let's enable my prefered shell

	users.users.lament = {
		isNormalUser = true; # I am not a system user
		name = "Sarah Lament"; # full name for the user
		shell = pkgs.zsh; # actually set zsh as my shell
		extraGroups = [ "wheel" "systemd-journal" ]; # sudo and journals
	};
	programs.hyprland = {
		enable = true; # enable the hyprland window manager
		withUWSM = true; # let's use better integration with systemd
		xwayland.enable = true; # and let's use the xwayland backend for things that need it
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
