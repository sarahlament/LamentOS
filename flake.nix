{
  description = "LamentOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    lanzaboote = {
      url = "github:/nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, lanzaboote }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in 
  {
    nixosConfigurations = {
      lamentOS = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [ 
          lanzaboote.nixosModules.lanzaboote
          ./nixos/configuration.nix 
         ];
       };
     };
   };
}
