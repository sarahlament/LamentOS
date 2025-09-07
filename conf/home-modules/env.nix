{ config, pkgs, lib, ... }:

{
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