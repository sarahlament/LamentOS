{
	description = "LamentOS";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; # let's use nix-unstable
		lanzaboote = {
			url = "github:nix-community/lanzaboote/v0.4.2"; # because this is for secureboot, let's keep it at a specific version
			inputs.nixpkgs.follows = "nixpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager"; # let's use the most recent commit
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, lanzaboote, home-manager, ... }:
	let
		system = "x86_64-linux"; # define the system type here
	in
	{
		nixosConfigurations.lamentOS = nixpkgs.lib.nixosSystem { # create our system config, named lamentOS
			inherit system;
			modules = [
				lanzaboote.nixosModules.lanzaboote # lanzaboote for secureboot
				home-manager.nixosModules.home-manager # home manager for, well, home manager

				./conf/boot.nix # config related to boot: encryption, boot, mounts, kernel
				./conf/core.nix # system-level config: graphics, network, display manager
				./conf/user.nix # user-level config: audio, users, window managers
				
				{
					system.stateVersion = "25.11"; # DO NOT CHANGE THIS
					nix.settings.experimental-features = [ "nix-command" "flakes" ]; # we obviously want flakes
					home-manager.useGlobalPkgs = true; # since I want this integrated with the system, let's use the system packages as well
					home-manager.useUserPackages = true; # and let's treat packages here as user packages, not 'home manager' packages
					home-manager.users.lament = {
						imports = [
							./conf/home-modules/user.nix # main user config
							./conf/home-modules/shell.nix # shell config: zsh and terminal
							./conf/home-modules/env.nix # env config: tools and such within the terminal
							./conf/home-modules/hypr.nix # hypr config: hyprland configuration
							./conf/home-modules/pkgs.nix # extra packages to install
							./conf/home-modules/gemini.nix # let's try out gemini-cli
						];
					};
				}
			];
		};
	};
}