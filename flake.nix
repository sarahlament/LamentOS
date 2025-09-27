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

    # These are my own system modules, which will be expanded upon
    # When using it as a flake input yourselves, this will look different
    lamentos = {
      url = "git+file:///home/lament/.lamentos";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
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

          ### START OF LamentOS Module DOCUMENTATION. ###
          inputs.lamentos.nixosModules.lamentos
          inputs.home-manager.nixosModules.home-manager

          # here are oll of the settings related to my LamentOS module that I personally use
          ({pkgs, ...}: {
            # I started straight on nixos-unstable, so yes, this is correct
            lamentos.system = {
              stateVersion = "25.11";
              allowUnfree = true;
            };
            lamentos.hardware = {
              # And the reason this module was completed first lol
              graphics.enable = true;
              graphics.nvidia.enable = true;

              # Why would you not want audio?
              audio.enable = true;

              # I'm on a desktop, so basic NetworkManager works perfectly
              # Little tip: I mentioned all the settings you must opt-in HOWEVER!
              # there *is* one that is default true: `lamentos.hardware.networking.firewall`
              # I myself forgot this when I started, and while not 'necessary' I'm
              # sure that it not being there when needed would be a shock :P
              networking = {
                enable = true;
                hostName = "${hostname}";
                networkmanager.enable = true;
              };
            };

            # These are a bit self-explanitory, I hope I don't need to explain much
            lamentos.system.locale.timeZone = "America/Chicago";
            lamentos.user = {
              name = "lament";
              fullName = "Sarah Lament";
            };

            # Install a set of sensible fonts
            lamentos.fonts.enableDefaultFonts = true;

            # I use hyprland, so let's specify what I need for it
            lamentos.desktop.xdg = {
              enable = true;
              portals = with pkgs; [
                xdg-desktop-portal-hyprland
                xdg-desktop-portal-gtk
              ];
              configPackages = with pkgs; [hyprland];

              # Common folders (~/Downloads, ~/Documents) are useful
              preferXdgDirectories = true;
              userDirs.enable = true;

              # Mime Types ensure that applications work the way they're supposed to
              mime = {
                enable = true;
                apps = true;
              };
            };
          })
          ### END OF LamentOS Module DOCUMENTATION. ###

          # Simple way to load all of my home-manager files.
          ({config, ...}: {
            home-manager.users.${config.lamentos.user.name} = {
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
