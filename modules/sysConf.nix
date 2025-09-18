{
	config,
	lib,
	pkgs,
	...
}:
with lib; {
	options.sysConf = {
		stateVersion =
			mkOption {
				type = types.str;
				default = "25.11";
				description = "The stateVersion we are using for the system. Unless you know what you're doing, DO NOT CHANGE THIS!";
			};
		systemType =
			mkOption {
				type = types.str;
				default = "x86_64-linux";
				description = "The system type we are using. You probably want to keep this as-is";
			};
		allowUnfree =
			mkOption {
				type = types.bool;
				default = true;
				description = "Should we allow 'unfree' software";
			};
		nvidia = {
			enable = mkEnableOption "Should we handle nvidia graphics cards";

			open =
				mkOption {
					type = types.bool;
					default = true;
					description = "Use the nvidia-open drivers";
				};
		};
	};

	config =
		mkMerge [
			{
				system.stateVersion = config.sysConf.stateVersion;
				nixpkgs.hostPlatform = config.sysConf.systemType;
				nixpkgs.config.allowUnfree = config.sysConf.allowUnfree;
				home-manager.users.${config.userConf.name}.home.stateVersion = config.sysConf.stateVersion;
			}
			(mkIf (config.sysConf.nvidia.enable == true) {
					services.xserver.videoDrivers = ["nvidia"];
					boot.initrd.kernelModules = ["nvidia"];

					hardware.nvidia = {
						modesetting.enable = true;
						open = config.sysConf.nvidia.open;
					};

					home-manager.users.${config.userConf.name}.home.sessionVariables = {
						# nvidia-specific environment variables
						LIBVA_DRIVER_NAME = "nvidia";
						__GLX_VENDOR_LIBRARY_NAME = "nvidia";
						ELECTRON_OZONE_PLATFORM_HINT = "auto";
					};
				})
		];
}
