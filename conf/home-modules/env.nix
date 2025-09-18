{
	config,
	lib,
	pkgs,
	...
}: {
	# default environment variables I want set at session start
	home.sessionVariables = {
		# maybe if I set some extra things here they're just 'set' when I need them?
		MAKEFLAGS = "-j16";
		ZSH_COMPDUMP = "${config.home.homeDirectory}/.cache/.zcompdump-${pkgs.zsh.version}";
	};

	programs = {
		vscode = {
			enable = true;
			package = pkgs.vscodium;

			profiles.default = {
				extensions = with pkgs.vscode-extensions; [
					jnoortheen.nix-ide
					catppuccin.catppuccin-vsc
					catppuccin.catppuccin-vsc-icons

					eamodio.gitlens
					editorconfig.editorconfig
					anthropic.claude-code
				];

				userSettings = {
					"workbench.startupEditor" = "none";
					"workbench.welcomePage.walkthroughs.openOnInstall" = false;
					"extensions.ignoreRecommendations" = true;
					"update.mode" = "none";
					"extensions.autoUpdate" = false;
					"extensions.autoCheckUpdates" = false;
					"nix.enableLanguageServer" = true;
					"nix.serverPath" = "${pkgs.nil}/bin/nil";
					"nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
					"nix.serverSettings" = {
						"nil" = {
							"formatting" = {
								"command" = ["${pkgs.alejandra}/bin/alejandra"];
							};
						};
					};
					"editor.formatOnSave" = true;
					"editor.codeActionsOnSave" = {
						"source.organizeImports" = "explicit";
					};
					"editor.bracketPairColorization.enabled" = true;
					"editor.guides.bracketPairs" = "active";

					"gitlens.currentLine.enabled" = false;
					"gitlens.hovers.currentLine.over" = "line";
				};
			};
		};

		claude-code.enable = true;

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
			extraOptions = [
				"--group-directories-first"
				"--header"
			];
		};

		# fancy system info parser thingy
		fastfetch.enable = true;

		command-not-found.enable = true; # yes, I know what I *want* to do
		bat.enable = true; # better cat
	};
}
