{
	config,
	pkgs,
	lib,
	...
}: {
	programs = {
		# our shell configuration
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
				gs = "g stat";
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
				glog = "g logg";
				gamend = "gc --amend";
				gcput = "gc && gput";

				cat = "bat";

				sys-update = "sudo nixos-rebuild --flake ${config.home.homeDirectory}/.nix-conf/#LamentOS switch && sleep 3 && exec zsh";
				sys-clean-gens = "sudo nix-collect-garbage -d; sys-update";
			};

			# let's load some secrets we don't want shared as part of the repo
			initContent =
				lib.mkOrder 2000 ''
					if [[ -f ~/.config/zsh/secrets.zsh ]]; then
						source ~/.config/zsh/secrets.zsh
					fi
				'';
		};

		# let's make my terminal a little more posh
		oh-my-posh = {
			enable = true;
			settings = {
				"$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
				# I've tried my best to grab from stylix correctly here,
				palette = {
					primary_blue = "#${config.lib.stylix.colors.base0D}";
					closer = "p:secondary_text";
					emphasized_text = "#${config.lib.stylix.colors.base06}";
					secondary_text = "#${config.lib.stylix.colors.base04}";
					accent_purple = "#${config.lib.stylix.colors.base0E}";
					warning_yellow = "#${config.lib.stylix.colors.base0A}";
					error_red = "#${config.lib.stylix.colors.base08}";
					success_green = "#${config.lib.stylix.colors.base0B}";
				};
				upgrade = {
					source = "cdn";
					interval = "168h";
					auto = false;
					notice = false;
				};
				transient_prompt = {
					foreground = "p:primary_blue";
					template = "❯ ";
				};
				blocks = [
					{
						type = "prompt";
						alignment = "left";
						segments = [
							{
								template = "{{.Icon}} ";
								foreground = "p:secondary_text";
								type = "os";
								style = "plain";
							}
							{
								template = "{{ .UserName }}@{{ .HostName }} ";
								foreground = "p:primary_blue";
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
								foreground = "p:accent_purple";
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
								template = "{{.UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} <p:error_red> {{ .Working.String }}</p:error_red>{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }} <p:success_green> {{ .Staging.String }}</p:success_green>{{ end }} ";
								foreground = "p:emphasized_text";
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
								foreground = "p:accent_purple";
								template = "󰘚 {{ round .PhysicalPercentUsed .Precision }}% ";
								properties = {
									precision = 1;
								};
							}
							{
								type = "time";
								style = "plain";
								foreground = "p:emphasized_text";
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
								foreground = "p:primary_blue";
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
