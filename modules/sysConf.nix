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
				description = "Should we allow 'unfree' software (and firmware)";
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
				hardware.enableRedistributableFirmware = config.sysConf.allowUnfree;
				home-manager.users.${config.userConf.name}.home.stateVersion = config.sysConf.stateVersion;

				# let's include microcode updates, only the one needed will actually be loaded
				hardware.cpu.amd.updateMicrocode = config.sysConf.allowUnfree;
				hardware.cpu.intel.updateMicrocode = config.sysConf.allowUnfree;
			}
			(mkIf (config.sysConf.nvidia.enable == true) {
					# because we are using out-of-kernel modules for graphics, we need to specify what we need
					services.xserver.videoDrivers = ["nvidia"];
					boot.initrd.kernelModules = ["nvidia"];
					boot.blacklistedKernelModules = ["nouveau"];

					# let's make sure the modules are availble at boot-time
					boot.initrd.availableKernelModules = [
						"nvidia"
						"nvidia_modeset"
						"nvidia_uvm"
						"nvidia_drm"
					];

					hardware.nvidia = {
						modesetting.enable = true; # we kinda need this for the card to work correctly
						open = config.sysConf.nvidia.open; # are we using the nvidia-open drivers?
						nvidiaSettings = false; # we don't really need this yet
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
