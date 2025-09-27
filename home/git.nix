{
  config,
  lib,
  pkgs,
  ...
}: {
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
        logg = "log --oneline --decorate --all --graph";
        stat = "status --short --branch";
      };
    };

    # GitHub CLI for project management
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        aliases = {
          co = "pr checkout";
          pv = "pr view";
          pc = "pr create";
          pm = "pr merge";
          rc = "repo clone";
          rv = "repo view";
        };
      };
      gitCredentialHelper = {
        enable = true;
        hosts = [
          "https://github.com"
          "https://gist.github.com"
        ];
      };
    };
  };
}
