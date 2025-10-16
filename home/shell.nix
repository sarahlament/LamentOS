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

        sys-update = "sudo nixos-rebuild --flake ${config.home.homeDirectory}/.nix-conf/# switch";
        sys-clean-gens = "sudo nix-collect-garbage -d; sys-update";
      };

      envExtra = ''
        unset SSH_AGENT_PID
        if [[ -z "$SSH_CONNECTION" || -z "$SSH_AUTH_SOCK" ]]; then
          export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
        fi
      '';
    };
  };
}
