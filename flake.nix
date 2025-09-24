{
	description = "LamentOS";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # let's use nixos-unstable
		lanzaboote = {
			url = "github:nix-community/lanzaboote/v0.4.2"; # because this is for secure boot, let's keep it at a specific version
			inputs.nixpkgs.follows = "nixpkgs";
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
			url = "github:ezKEa/aagl-gtk-on-nix";
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
				modules = [
					inputs.lanzaboote.nixosModules.lanzaboote # lanzaboote for secure boot
					inputs.home-manager.nixosModules.home-manager # home manager for, well, home manager
					inputs.stylix.nixosModules.stylix # let's try stylix
					inputs.aagl.nixosModules.default # let's have our anime games as well

					./modules/userConf.nix # let's use our module to handle the base system
					./modules/sysConf.nix # and our module to handle certain system variables

					./conf/disks.nix # disks: since they will almost never change
					./conf/boot.nix # boot: lanzaboote, initrd, kernel packages and params
					./conf/core.nix # system-level config: graphics, network, display manager
					./conf/user.nix # system-level user settings
					./conf/sysStylix.nix # system-level theming
					./conf/aagl.nix # our anime game launchers

					({config, ...}: {
							nix.settings.experimental-features = [
								"nix-command" # we need the 'nix' command for a few things
								"flakes" # we definitely want flakes
							];
							home-manager.users.${config.userConf.name} = {
								imports = [
									inputs.nixvim.homeModules.nixvim # import nixvim things

									./conf/home-modules/env.nix # env config: tools and such within the terminal
									./conf/home-modules/shell.nix # shell config: zsh and terminal
									./conf/home-modules/hypr.nix # hypr config: hyprland configuration
									./conf/home-modules/nixvim.nix # nixvim: neovim, the nix way
									./conf/home-modules/pkgs.nix # extra packages to install for the user
									./conf/home-modules/usrStylix.nix # some user-level theming options
								];
							};
						})
				];
			};
	};
}
