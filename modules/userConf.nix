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
				type = types.package;
				default = pkgs.zsh;
				description = "the shell to use";
			};
	};

	config =
		mkMerge [
			(mkIf (config.userConf.name != null) {
					users.users.${config.userConf.name} = {
						description = config.userConf.fullName;
						isNormalUser = true;
						extraGroups = ["wheel" "systemd-journal"];
					};
					home-manager.users.${config.userConf.name} = {
						home.username = config.userConf.name;
						home.homeDirectory = "/home/${config.userConf.name}";
						home.shell.enableShellIntegration = true;
					};
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
				})
			(mkIf (config.userConf.shell == pkgs.zsh) {
					programs.zsh.enable = true;
					users.users.${config.userConf.name}.shell = pkgs.zsh;
					home-manager.users.${config.userConf.name}.programs.zsh.enable = true;
				})
			(mkIf (config.userConf.shell == pkgs.bash) {
					users.users.${config.userConf.name}.shell = pkgs.bash;
					home-manager.users.${config.userConf.name}.programs.bash.enable = true;
					programs.bash.enable = true;
				})
			(mkIf (config.userConf.shell == pkgs.fish) {
					users.users.${config.userConf.name}.shell = pkgs.fish;
					home-manager.users.${config.userConf.name}.programs.fish.enable = true;
					programs.fish.enable = true;
				})
			(mkIf (config.userConf.shell == pkgs.nushell) {
					home-manager.users.${config.userConf.name}.home.packages = [pkgs.nushell];
					home-manager.users.${config.userConf.name}.programs.nushell.enable = true;
					users.users.${config.userConf.name}.shell = pkgs.nushell;
				})
		];
}
