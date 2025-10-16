{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    gpg = {
      enable = true;
      mutableKeys = true;
    };
    git.signing = {
      key = "ED9E24195789351E15883A327F48E306B42F5D4A";
      signByDefault = false;
    };
  };
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-curses;
    sshKeys = ["5760FCB097407ABE51DA83AB304C6B59A6F5B08A"];
  };
}
