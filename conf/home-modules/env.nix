{ config, pkgs, lib, ... }:

{
	# default environment variables I want set at session start
	home.sessionVariables = {
		# these are helpers for nvidia based cards
		LIBVA_DRIVER_NAME = "nvidia";
		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		ELECTRON_OZON_PLATFORM_HINT = "auto";

		# maybe if I set some extra things here they're just 'set' when I need them?
		MAKEFLAGS = "-j16";
		ZSH_COMPDUMP = "${config.home.homeDirectory}/.cache/.zcompdump-${pkgs.zsh.version}";
	};

	programs = {
		git = {
			enable = true;
			userName = "Sarah Lament";
			userEmail = "4612427+sarahlament@users.noreply.github.com";
			extraConfig = {
				init.defaultBranch = "main";
				fetch.prune = true;
				pull.rebase = true;
			};
			aliases = {
				sreset = "reset HEAD~1 --soft";
				hreset = "reset HEAD~1 --hard";
			};
		};

		# ls, but fancy
		eza = {
			enable = true;
			enableZshIntegration = true;
			colors = "auto";
			git = true;
			icons = "auto";
			extraOptions = [ "--group-directories-first" "--header" ];
		};

		# fancy system info parser thingy
		fastfetch.enable = true;

		# let's use neovim by default
		neovim = {
			enable = true;
			defaultEditor = true;
			vimAlias = true;
		};

		command-not-found.enable = true; # yes, I know what I *want* to do
		bat.enable = true; # better cat
	};
}
