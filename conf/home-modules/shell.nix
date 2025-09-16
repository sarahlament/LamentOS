{
	config,
	pkgs,
	lib,
	unknown,
	...
}: {
	programs = {
		kitty = {
			enable = true;
			# theme now handled by Stylix
			shellIntegration.enableZshIntegration = true;
			actionAliases = {
				"launch_tab" = "launch --cwd=current --type=tab";
				"launch_window" = "launch --cwd=current --type=os-window";
			};
			settings = {
				enable_audio_bell = false;
				remember_window_size = false;
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
			settings = {
				"$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
				palette = {
					blue = "#89B4FA";
					closer = "p:os";
					lavender = "#B4BEFE";
					os = "#ACB0BE";
					pink = "#F5C2E7";
					yellow = "#F9E2AF";
					red = "#F38BA8";
					green = "#A6E3A1";
				};
				upgrade = {
					source = "cdn";
					interval = "168h";
					auto = false;
					notice = false;
				};
				transient_prompt = {
					foreground = "p:blue";
					template = "❯ ";
				};
				blocks = [
					{
						type = "prompt";
						alignment = "left";
						segments = [
							{
								template = "{{.Icon}} ";
								foreground = "p:os";
								type = "os";
								style = "plain";
							}
							{
								template = "{{ .UserName }}@{{ .HostName }} ";
								foreground = "p:blue";
								type = "session";
								style = "plain";
							}
							{
								properties = {
									folder_icon = "....";
									home_icon = "~";
									style = "full";
								};
								template = "{{ .Path }} ";
								foreground = "p:pink";
								type = "path";
								style = "plain";
							}
							{
								properties = {
									branch_icon = " ";
									cherry_pick_icon = " ";
									commit_icon = " ";
									fetch_status = true;
									fetch_upstream_icon = true;
									merge_icon = " ";
									no_commits_icon = " ";
									rebase_icon = " ";
									revert_icon = " ";
									tag_icon = " ";
								};
								template = "{{.UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} <p:red> {{ .Working.String }}</p:red>{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }} <p:green> {{ .Staging.String }}</p:green>{{ end }} ";
								foreground = "p:lavender";
								type = "git";
								style = "plain";
							}
						];
						newline = true;
					}
					{
						type = "prompt";
						alignment = "right";
						segments = [
							{
								type = "sysinfo";
								style = "plain";
								foreground = "p:pink";
								template = "󰘚 {{ round .PhysicalPercentUsed .Precision }}% ";
								properties = {
									precision = 2;
								};
							}
							{
								type = "time";
								style = "plain";
								foreground = "p:lavender";
								template = "󰅐 {{ .CurrentDate | date .Format }}";
								properties = {
									time_format = "15:04";
								};
							}
						];
					}
					{
						type = "prompt";
						alignment = "left";
						segments = [
							{
								template = "❯ ";
								foreground = "p:blue";
								type = "text";
								style = "plain";
							}
						];
					}
				];
				version = 3;
				final_space = true;
			};
		};

		# not quite sure what this is, but I've found it helpful
		fzf.enable = true;
	};
}
