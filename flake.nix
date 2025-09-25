{
	description = "LamentOS";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # let's use nixos-unstable
		lanzaboote = {
			url = "github:nix-community/lanzaboote/v0.4.2"; # because this is for secure boot, let's keep it at a specific version
			inputs.nixpkgs.follows = "nixpkgs"; # for every flake input, we want it to use the same nixpkgs as the system itself
		};
		home-manager = {
			url = "github:nix-community/home-manager/master"; # let's use the most recent commit
			inputs.nixpkgs.follows = "nixpkgs";
		};
		stylix = {
			#url = "github:nix-community/stylix/pull/892/head"; # let's use the PR for matugen theming
			url = "github:make-42/stylix/matugen"; # I want to try the lastest for this PR, so let's use the master it's based on
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nixvim = {
			url = "github:nix-community/nixvim/main"; # let's use the main branch
			inputs.nixpkgs.follows = "nixpkgs";
		};
		aagl = {
			url = "github:ezKEa/aagl-gtk-on-nix"; # an anime game laucnher, for games
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = {
		self,
		nixpkgs,
		...
	} @ inputs: let
		hostname = "LamentOS"; # let's define the hostname here so it's easier to change
	in {
		nixosConfigurations.${hostname} =
			nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs hostname;}; # we want to see our inputs
				modules =
					[
						inputs.lanzaboote.nixosModules.lanzaboote # lanzaboote: secure boot
						inputs.home-manager.nixosModules.home-manager # home manager: manage programs on the user level
						inputs.stylix.nixosModules.stylix # stylix: quick and easy themning across the entire system
						inputs.aagl.nixosModules.default # aagl: anime games launcher (yes, I play these)

						./modules/sysConf.nix # sysConf: module to make some of the core system configuration easier and contained
						./modules/userConf.nix # userConf: module to make the system user creation quicker and easier
					]
					++ (import ./system); # let's import the ./system directory, with the modules defined in default.nix
			};
	};
}
