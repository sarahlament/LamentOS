{
	config,
	lib,
	pkgs,
	...
}: {
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
					"workbench.settings.editor" = "json";

					"update.mode" = "none";
					"extensions.ignoreRecommendations" = true;
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

					"explorer.confirmDragAndDrop" = false;

					"gitlens.currentLine.enabled" = false;
					"gitlens.hovers.currentLine.over" = "line";
					"problems.showErrors" = false;
					"problems.showWarnings" = false;
					"editor.validationDelay" = 9999999;
				};
			};
		};

		claude-code.enable = true;
	};
}