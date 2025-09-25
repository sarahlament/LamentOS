{
	config,
	lib,
	pkgs,
	inputs,
	...
}:
with lib; {
	options.userConf = {
		name =
			mkOption {
				type = types.str;
				default = "user";
				description = "login name for the user";
			};
		fullName =
			mkOption {
				type = types.str;
				default = "System User";
				description = "display name for the user";
			};
		shell =
			mkOption {
				type =
					types.enum [
						"zsh"
						"bash"
						"dash"
						"fish"
					];
				default = "zsh";
				description = "which shell should the user use";
			};
		xdgThings =
			mkOption {
				type = types.bool;
				default = true;
				description = "do we want to setup XDG things?";
			};
	};

	config =
		mkMerge [
			{
				programs.${config.userConf.shell}.enable = true;
				users.users.${config.userConf.name} = {
					description = config.userConf.fullName;
					isNormalUser = true;
					extraGroups = [
						"wheel"
						"systemd-journal"
					];
					shell = pkgs.${config.userConf.shell};
				};
				home-manager.users.${config.userConf.name} = {
					imports =
						(import ../home)
						++ [
							inputs.nixvim.homeModules.nixvim
						];

					home.username = config.userConf.name;
					home.homeDirectory = "/home/${config.userConf.name}";
					home.shell.enableShellIntegration = true;

					programs.${config.userConf.shell}.enable = true;
				};
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
			}
			(mkIf (config.userConf.xdgThings == true) {
					xdg.portal = {
						enable = true;
						extraPortals = with pkgs; [
							xdg-desktop-portal-hyprland
							xdg-desktop-portal-gtk
						];
					};
					home-manager.users.${config.userConf.name} = {
						# XDG portal configuration
						home.preferXdgDirectories = true;
						xdg = {
							enable = true;
							portal = {
								enable = true;
								extraPortals = with pkgs; [
									xdg-desktop-portal-hyprland
									xdg-desktop-portal-gtk
								];
								configPackages = [pkgs.hyprland];
							};
							userDirs.enable = true;
							userDirs.createDirectories = true;
							mime.enable = true;
							mimeApps.enable = true;
						};
					};
				})
		];
}
