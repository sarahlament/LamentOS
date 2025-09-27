{
	description = "LamentOS";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # let's use nixos-unstable
		lanzaboote = {
			# Lanzaboote is a secure boot implementation, requiring your own keys
			url = "github:nix-community/lanzaboote/v0.4.2";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		home-manager = {
			# Home Manager is a module that helps with creating various configurations
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		stylix = {
			# Stylix provides system-level theming
			# We are going to use a specific pull request, so I'm going to
			# commend out the normal url and replace it with the dev tree
			#url = "github:nix-community/stylix/";
			url = "github:make-42/stylix/matugen";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nixvim = {
			# NixVim is neovim and plugins done the nix way
			url = "github:nix-community/nixvim/main";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		aagl = {
			# Anime Games Launcher
			url = "github:ezKEa/aagl-gtk-on-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		lamentos = {
			# These are my own system modules, which will be expanded upon
			# When using it as a flake input yourselves, this will look different
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
		nixosConfigurations.${hostname} =
			nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs hostname;};
				modules =
					[
						inputs.lanzaboote.nixosModules.lanzaboote
						inputs.home-manager.nixosModules.home-manager
						inputs.stylix.nixosModules.stylix
						inputs.aagl.nixosModules.default

						inputs.lamentos.nixosModules.lamentos

						# Standalone home manager configuration module
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
