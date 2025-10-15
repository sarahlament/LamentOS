{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.defaultPackages = [pkgs.sops];
  sops.defaultSopsFile = ../secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/lament/.config/sops/age/keys.txt";
  sops.secrets.hashedPassword.neededForUsers = true;
}
