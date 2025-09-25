{
	config,
	lib,
	pkgs,
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
	};

	config = {
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
			home.username = config.userConf.name;
			home.homeDirectory = "/home/${config.userConf.name}";
			home.shell.enableShellIntegration = true;

			programs.${config.userConf.shell}.enable = true;
		};
		home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;
	};
}
