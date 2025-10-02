{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  nix.settings = {
    experimental-features = [
      "nix-command" # we need the 'nix' command for a few things
      "flakes" # we definitely want flakes
    ];
    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  nixpkgs.overlays = [inputs.claude-code.overlays.default];
}
