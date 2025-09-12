{
  conf,
  pkgs,
  lib,
  ...
}:

{
  programs.gemini-cli = {
    enable = true;
  };
}
