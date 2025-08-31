{
  description = "LamentOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nixos-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs }:
 
  {
    nixosConfigurations = {
      lamentOS = nixpkgs.lib.nixosSystem {
        modules = [
          # let's load our external modules here
          lanzaboote.nixosModules.lanzaboote

          # and now let's use modularized nix configs
          ./conf/boot.nix
          ./conf/system.nix
          ./conf/user.nix
          
          # and a few extras that feel more 'critical' and thus should be 'seen'
          {
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            system.stateVersion = "25.11"; # DO NOT CHANGE THIS! THIS SHOULD STAY WHERE THE SYSTEM WAS INITIALLY INSTALLED
          };
         ];
       };
     };
   };
}
