{
  description = "LamentOS";

  inputs = {
    # I'm totally fine using the unstable repo, but normally you would want a release, like below
    #nixpkgs.url = "github:nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # This allows us to have up-to-date claude-code instead of the late updates provided by nixpkgs
    claude-code.url = "github:sadjow/claude-code-nix";

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
    # We are going to use a specific pull request, so I'm going to comment out the normal url and replace it with the dev tree
    stylix = {
      #url = "github:nix-community/stylix/";
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

    # Custom LamentOS module systemn: a desktop experience on Nix that JustWorks
    lamentos = {
      url = "git+file:///home/lament/.lamentos";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        #stylix.follows = "stylix";
      };
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
          inputs.lamentos.nixosModules.lamentos

          ({config, ...}: {
            lamentos.system.identity = {
              hostName = "${hostname}";
            };
            lamentos.user.lament.fullName = "Sarah Lament";

            lamentos.graphics.nvidia.enable = true;

            home-manager.users.lament = {
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
