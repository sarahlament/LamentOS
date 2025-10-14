{
  description = "LamentOS";

  inputs = {
    # Let's use nixos-unstable; I'm comfortable with not using a 'release' branch
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
    stylix = {
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

    # This allows us to have up-to-date claude-code instead of the late updates provided by nixpkgs
    # Note: this is an overlay, not a module
    claude-code = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Custom LamentOS module systemn: a desktop experience on Nix that 'JustWorks':tm:
    lamentos = {
      url = "git+file:///home/lament/.lamentos";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        stylix.follows = "stylix";
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
          inputs.lamentos.nixosModules.lamentos
          inputs.aagl.nixosModules.default

          ({config, ...}: {
            lamentos.system.identity = {
              hostName = "${hostname}";
              stateVersion = "25.11";
            };
            lamentos.user.lament = {
              fullName = "Sarah Lament";
              isAdmin = true;
            };
            lamentos.users.sudoNoPassword = true;

            lamentos.graphics.vendor = "nvidia";
            lamentos.desktop.kde.enable = true;

            lamentos.shell.modernTools.useRustSudo = true;
            users.users.lament.extraGroups = [
              "gamemode"
              "plugdev"
              "docker"
            ];

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
