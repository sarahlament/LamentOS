{
	description = "LamentOS";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable"; # let's use nixpkgs-unstable
		lanzaboote = {
			url = "github:nix-community/lanzaboote/v0.4.2"; # because this is for secureboot, let's keep it at a specific version
			inputs.nixpkgs.follows = "nixpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager"; # let's use the most recent commit
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, ... }@inputs :
	let
		system = "x86_64-linux"; # define the system type here
		pkgs = nixpkgs.legacyPackages.${system};
	in
	{
		nixosConfigurations.LamentOS = nixpkgs.lib.nixosSystem { # create our system config, named lamentOS
			specialArgs = { inherit inputs; };
			modules = [
				inputs.lanzaboote.nixosModules.lanzaboote # lanzaboote for secureboot
				inputs.home-manager.nixosModules.home-manager # home manager for, well, home manager
				inputs.nixvim.nixosModules.nixvim # nixvim for neovim config

				./conf/boot.nix # config related to boot: lanzaboote, mounts, kernel options
				./conf/core.nix # system-level config: graphics, network, display manager
				./conf/user.nix # user-level config: audio, users, window managers

				{
					system.stateVersion = "25.11"; # DO NOT CHANGE THIS!
					nixpkgs.hostPlatform = "${system}";
					nix.settings.experimental-features = [ "nix-command" "flakes" ]; # we obviously want flakes
					home-manager.useGlobalPkgs = true; # since I want this integrated with the system, let's use the system packages as well
					home-manager.useUserPackages = true; # and let's treat packages here as user packages, not 'home manager' packages
					home-manager.users.lament = {
						home.stateVersion = "25.11"; # DO NOT CHANGE THIS!
						home.username = "lament"; # let's give it our username
						home.homeDirectory = "/home/lament"; # and the home directory
						imports = [
							./conf/home-modules/env.nix # env config: tools and such within the terminal
							./conf/home-modules/shell.nix # shell config: zsh and terminal
							./conf/home-modules/hypr.nix # hypr config: hyprland configuration
							./conf/home-modules/pkgs.nix # extra packages to install
							./conf/home-modules/gemini.nix # let's try out gemini-cli
							./conf/home-modules/nixvim.nix # and let's configure nixvim
						];
					};
				}
			];
		};
	};
}
