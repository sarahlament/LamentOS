{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    # codium is actually pretty damn good
    vscode = {
      enable = true;
      package = pkgs.vscodium;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          dracula-theme.theme-dracula

          eamodio.gitlens
          anthropic.claude-code
        ];

        userSettings = {
          "workbench.colorTheme" = lib.mkForce "Dracula Theme";
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
          "editor.wordWrap" = "wordWrapColumn";
          "editor.wordWrapColumn" = 100;

          "explorer.confirmDragAndDrop" = false;

          "gitlens.currentLine.enabled" = false;
          "gitlens.hovers.currentLine.over" = "line";
          "problems.showErrors" = false;
          "problems.showWarnings" = false;
        };
      };
    };

    # claude is my AI agent of choice
    claude-code.enable = true;
  };
}
