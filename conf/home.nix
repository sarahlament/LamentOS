{ config, pkgs, lib, ... }:

{
	home.stateVersion = "25.11"; # DO NOT CHANGE THIS!

	# We obviously need basic user information
	home.username = "lament";
	home.homeDirectory = "/home/lament";

	home.packages = with pkgs; [
		curl

		hyprcursor
		hyprsysteminfo
		hyprland-qt-support
		kitty

		discord
		matugen
		fastfetch
		eza
		pwvucontrol

		wl-clipboard
		wl-clip-persist

		kdePackages.dolphin
		playerctl
		pwvucontrol
	];

	# now let's define some of my programs
	programs = {
		home-manager.enable = true;
		git = {
			enable = true;
			userName = "Sarah Lament";
			userEmail = "4612427+sarahlament@users.noreply.github.com";
			extraConfig = {
				init.defaultBranch = "main";
				fetch.prune = true;
				pull.rebase = true;
			};
		};
		zsh = {
			enable = true;
			enableCompletion = true;
			autosuggestion.enable = true;
			autosuggestion.strategy = [ "history" "completion" ];
			history.ignoreAllDups = true;
			history.append = true;
			syntaxHighlighting.enable = true;
			
			oh-my-zsh = {
				enable = true;

				extraConfig = "unsetopt autopushd";

				# The main plugins I use
				plugins = [ "sudo" "eza" "fancy-ctrl-z" "gitfast" "zsh-interactive-cd" ];
			};

			# Some extra variables I want set upon opening a terminal
			envExtra = "MAKEFLAGS=\"-j16\"";

			#  My main shell variables
			shellAliases = {
				c = "clear";
				ff = "fastfetch";
				shutdown = "systemctl shutdown";
				reboot = "systemctl reboot";

				g = "git";
				gs = "g status";
				gl = "g log";
				ga = "g add";
				"ga." = "ga .";
				gcm = "g commit -am";
				gp = "g push";

				cat = "bat";
			};

			# let's do some extra things and add some extra aliases(things I've added but not yet put into home manager)
			initContent = lib.mkOrder 9999 ''
				if [[ -f ~/.config/zsh/moreAliases.zsh ]]; then
					source ~/.config/zsh/moreAliases.zsh
				fi

				if [[ $(tty) == *"pts"* ]]; then
					ff
				fi
			'';
		};

		# let's make my terminal a little more posh
		oh-my-posh = {
			enable = true;
			enableZshIntegration = true;
			useTheme = "catppuccin_mocha";
		};

		# let's use neovim by default
		neovim = {
			enable = true;
			defaultEditor = true;
			vimAlias = true;
		};

		command-not-found.enable = true;	# yes, I know what I *want* to do
		bat.enable = true;	# better cat
		fzf = {	# really nice keybinding stuff for my shell
			enable = true;
			enableZshIntegration = true;
		};

		# let's enable and define part of the hypr ecosystem (hpyrland will be added once I have it more finalized)
		hyprlock.enable = true;
		waybar = {
			enable = true;
			systemd.enable = true;
		};
	};

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-gtk # allows GTK based apps to work correctly
		];
	};

	services = {
		hyprpolkitagent.enable = true;	# polkit helper for hyprland
		hyprpaper.enable = true;	# wallpaper daemon
		hypridle.enable = true;	# idle after an ammount of time
	};

	home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

	# let's move my uwsm config here
#	".config/uwsm/env-hyprland".text = ''
#		export LIBVA_DRIVER_NAME=nvidia
#		export __GKX_VENDOR_LIBRARY_NAME=nvidia
#		export ELECTRON_OZONE_PLATFORM_HINT=auto
#	'';
	};

	# if this works the way I think it does, I can use this instead of uwsm config
	home.sessionVariables = {
		LIBVA_DRIVER_NAME = "nvidia";
		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		ELECTRON_OZON_PLATFORM_HINT = "auto";
	};
}
