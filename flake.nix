{
  description = "LamentOS";

  inputs = {
    # I'm totally fine using the unstable repo, but normally you would want a release, like below
    #nixpkgs.url = "github:nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Lanzaboote is a secure boot implementation, requiring your own keys
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager is a module that helps with creating various configurations
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix provides system-level theming
    # We are going to use a specific pull request, so I'm going to
    # comment out the normal url and replace it with the dev tree
    #url = "github:nix-community/stylix/";
    stylix = {
      url = "github:make-42/stylix/matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixVim is neovim and plugins done the nix way
    nixvim = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Anime Games Launcher
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    hostname = "LamentOS";
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules =
        [
          inputs.lanzaboote.nixosModules.lanzaboote
          inputs.stylix.nixosModules.stylix
          inputs.aagl.nixosModules.default

          inputs.home-manager.nixosModules.home-manager

          ./modules/sysConf.nix
          ./modules/userConf.nix

          # Basic system configuration
          ({config, ...}: {
            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];
          })

          # Simple way to load all of my home-manager files.
          ({config, ...}: {
            home-manager.users.${config.userConf.name} = {
              imports =
                [
                  inputs.nixvim.homeModules.nixvim
                ]
                ++ (import ./home);
            };
          })
        ]
        ++ (import ./system);
    };
  };
}
