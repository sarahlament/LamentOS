{
	description = "LamentOS";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # let's use nixos-unstable
		lanzaboote = {
			url = "github:nix-community/lanzaboote/v0.4.2"; # because this is for secureboot, let's keep it at a specific version
			inputs.nixpkgs.follows = "nixpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager/master"; # let's use the most recent commit
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nixvim = {
			url = "github:nix-community/nixvim/main";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		stylix = {
			url = "github:nix-community/stylix/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = {
		self,
		nixpkgs,
		...
	} @ inputs: let
		system = "x86_64-linux"; # define the system type here
		stateVersion = "25.11"; # globally define this here, so *if* they change, it's together
		hostname = "LamentOS"; # let's define the hostname here so it's easier to change
	in {
		nixosConfigurations.${hostname} =
			nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs hostname;}; # we want to see our inputs
				modules = [
					inputs.lanzaboote.nixosModules.lanzaboote # lanzaboote for secureboot
					inputs.home-manager.nixosModules.home-manager # home manager for, well, home manager
					inputs.stylix.nixosModules.stylix # we need this enabled system-wide, this *should* set it for HM as well

					./modules/userConf.nix # let's use our module to handle the base system

					./conf/boot.nix # config related to boot: lanzaboote, mounts, kernel options
					./conf/core.nix # system-level config: graphics, network, display manager
					./conf/nvidia.nix # nvidia-specific configuration
					./conf/user.nix # system-level user settings

					({config, ...}: {
							system.stateVersion = "${stateVersion}"; # DO NOT CHANGE THIS!
							nixpkgs.hostPlatform = "${system}";
							nix.settings.experimental-features = [
								"nix-command" # we need the 'nix' command for a few things
								"flakes" # we definitely want flakes
							];
							home-manager.users.${config.userConf.name} = {
								home.stateVersion = "${stateVersion}"; # DO NOT CHANGE THIS!
								imports = [
									inputs.nixvim.homeModules.nixvim # import nixvim things

									./conf/home-modules/env.nix # env config: tools and such within the terminal
									./conf/home-modules/shell.nix # shell config: zsh and terminal
									./conf/home-modules/hypr.nix # hypr config: hyprland configuration
									./conf/home-modules/pkgs.nix # extra packages to install
									./conf/home-modules/ai-cli.nix # let's try out gemini-cli
									./conf/home-modules/nixvim.nix # and let's configure nixvim
									./conf/home-modules/stylix.nix
								];
							};
						})
				];
			};
	};
}
