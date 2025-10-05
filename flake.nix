{
  description = "LamentOS";

  inputs = {
    # I'm totally fine using the unstable repo, but normally you would want a release, like below
    #nixpkgs.url = "github:nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # This allows us to have up-to-date claude-code instead of the late updates provided by nixpkgs
    claude-code = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    # We are no longer using the new matugen color pallette generator, so let's revert to main
    stylix = {
      #url = "github:make-42/stylix/matugen";
      url = "github:nix-community/stylix/";
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
            lamentos.users.sudoNoPassword = true;

            lamentos.graphics.nvidia.enable = true;
            lamentos.desktop.plasma6.enable = true;

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
