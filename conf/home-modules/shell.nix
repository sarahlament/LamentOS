{
	config,
	pkgs,
	lib,
	...
}: {
	programs = {
		kitty = {
			enable = true;
			themeFile = "Catppuccin-Macchiato";
			shellIntegration.enableZshIntegration = true;
			actionAliases = {
				"launch_tab" = "launch --cwd=current --type=tab";
				"launch_window" = "launch --cwd=current --type=os-window";
			};
			font = {
				name = "JetBrainsMono Nerd Font";
				size = 14;
			};
			settings = {
				enable_audio_bell = false;
				remember_window_size = false;
				background_opacity = 0.8;
				dynamic_background_opacity = true;
				hide_window_decorations = true;
				cursor_blink_interval = 0.5;
				cursor_stop_blinking_after = 2;
				scrollback_lines = 5000;
				window_padding_width = 5;
				cursor_trail = 5;
				cursor_trail_decay = "0.2 0.6";
				scrollback_indicator_opacity = 0.3;
				mouse_hide_wait = 2;
				show_hyperlink_targets = true;
				underline_hyperlinks = "always";
			};
		};
		zsh = {
			enableCompletion = true;
			autosuggestion.enable = true;
			autosuggestion.strategy = [
				"history"
				"completion"
			];
			history.ignoreAllDups = true;
			history.append = true;
			syntaxHighlighting.enable = true;

			dirHashes = {
				nix = "${config.home.homeDirectory}/.nix-conf";
			};

			setOptions = ["NO_AUTOPUSHD"];

			# phase this out? maybe check another plugin manager?
			oh-my-zsh = {
				enable = true;

				# The main plugins I use
				plugins = [
					"sudo"
					"fancy-ctrl-z"
					"gitfast"
					"per-directory-history"
				];
			};

			# My main shell variables
			shellAliases = {
				c = "clear";
				ff = "fastfetch";
				shutdown = "systemctl shutdown";
				reboot = "systemctl reboot";

				g = "git";
				gs = "g status -s";
				gp = "g pull";
				gput = "g push";
				ga = "g add";
				"ga." = "ga .";
				gc = "g commit --verbose";
				gcm = "gc -m";
				gca = "gc -a";
				gcam = "gca -m";
				gcat = "gcam tmp";
				gd = "g diff";
				gds = "gd --stat";
				gdc = "gd --cached";
				glog = "g log --oneline --decorate --all --graph";
				gamend = "gc --amend";
				gcput = "gc && gput";

				cat = "bat";

				sys-update = "sudo nixos-rebuild --flake ${config.home.homeDirectory}/.nix-conf/#LamentOS switch";
				sys-clean-gens = "sudo nix-collect-garbage -d; sys-update";
			};

			# let's do some extra things and add some extra aliases(things I've added but not yet put into home manager)
			initContent =
				lib.mkOrder 2000 ''
					# Accept Zsh autosuggestion with Shift+Return
					  bindkey '^[[13;2u' autosuggest-accept

					  if [[ -f ~/.config/zsh/secrets.zsh ]]; then
					  source ~/.config/zsh/secrets.zsh
					  fi

					  if [[ $(tty) == *"pts"* ]]; then
					    ff
					  fi
				'';
		};

		# let's make my terminal a little more posh
		oh-my-posh = {
			enable = true;
			useTheme = "illusi0n";
		};

		# not quite sure what this is, but I've found it helpful
		fzf.enable = true;
	};
}
