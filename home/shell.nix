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
      history.append = true;
      syntaxHighlighting.enable = true;

      dirHashes = {
        nixconf = "${config.home.homeDirectory}/.nix-conf";
        modules = "${config.home.homeDirectory}/.lamentos";
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
        ff = "hyfetch";
        shutdown = "systemctl shutdown";
        reboot = "systemctl reboot";

        sys-clean-gens = "sudo nix-collect-garbage -d; sys-update";
        sys-update = "sudo nixos-rebuild --flake ${config.home.homeDirectory}/.nix-conf/# switch";
      };

      # let's load some secrets we don't want shared as part of the repo
      initContent = lib.mkOrder 2000 ''
        if [[ -f ~/.config/zsh/secrets.zsh ]]; then
        	source ~/.config/zsh/secrets.zsh
        fi
      '';
    };
  };
}
