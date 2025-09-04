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
				lanzaboote.nixosModules.lanzaboote # lanzaboote for secure boot
				home-manager.nixosModules.home-manager # home manager for, well, home manager

				./conf/boot.nix # config related to boot: encryption, boot, mounts, kernel
				./conf/core.nix # system-level config: graphics, network, display manager
				./conf/user.nix # user-level config: audio, users, window managers
          
				{
					nix.settings.experimental-features = [ "nix-command" "flakes" ]; # we obviously want flakes
					home-manager.users."lament" = import ./conf/home.nix; # let's update the user along with the system
				}
			];
		};


		homeConfigurations.lament = home-manager.lib.homeManagerConfiguration { # create our home config, with our username as the name
			pkgs = nixpkgs.legacyPackages.x86_64-linux;
			modules = [
				./conf/home.nix # reference our home.nix
			];
		};
	};
}
