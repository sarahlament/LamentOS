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
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://ezkea.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
    ];
    extra-sandbox-paths = [config.programs.ccache.cacheDir];
  };

  nixpkgs.overlays = [inputs.claude-code.overlays.default];
}
