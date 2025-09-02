{
	description = "LamentOS";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		lanzaboote = {
			url = "github:nix-community/lanzaboote/v0.4.2";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, lanzaboote, ... }:
	let
		system = "x86_64-linux";
	in
	{
		nixosConfigurations = {
			lamentOS = nixpkgs.lib.nixosSystem {
				inherit system;
				modules = [
					# let's load our external modules here
					lanzaboote.nixosModules.lanzaboote

					# and now let's use modularized nix configs
					./conf/boot.nix
					./conf/core.nix
					./conf/user.nix
          
					# and a few extras that feel more 'critical' and thus should be 'seen'
					{
						nix.settings.experimental-features = [ "nix-command" "flakes" ];
						system.stateVersion = "25.11"; # DO NOT CHANGE THIS! THIS SHOULD STAY WHERE THE SYSTEM WAS INITIALLY INSTALLED
					}
				];
			};
		};
	};
}
