{
  config,
  lib,
  pkgs,
  ...
}: {
  # Default environment variables I want set at session start
  home.sessionVariables = {
    MAKEFLAGS = "-j16";
  };
}
