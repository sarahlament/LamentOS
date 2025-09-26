{
	config,
	pkgs,
	lib,
	...
}: {
	# Use lanzzaboote for secure boot, so it signs files with my keys
	# as lanzaboote uses its own thing, force systemd-boot to false
	boot.loader.systemd-boot.enable = lib.mkForce false;
	boot.lanzaboote = {
		enable = true;
		pkiBundle = "/var/lib/sbctl";
		configurationLimit = 10;
		settings = {
			console-mode = "max";
			timeout = 2;
		};
	};

	# Let's set some modules we definitely want for boot
	boot.initrd.availableKernelModules = [
		"nvme"
		"xhci_pci"
		"ahci"
		"usb_storage"
		"usbhid"
		"sd_mod"
		"sr_mod"
	];

	# Hardware-specific kernel module blacklist
	boot.blacklistedKernelModules = [
		"pcspkr" # PC speaker (annoying beeps)
		"watchdog" # Hardware watchdog timer
	];

	# Include hardware management tools
	environment.systemPackages = with pkgs; [
		sbctl # Secure boot key management
		modprobed-db # Track kernel module usage for optimization
	];

	# let's use systemd instead of busybox for init
	boot.initrd.systemd.enable = true;

	# Plymouth boot splash screen
	boot.plymouth.enable = true;

	# Kernel configuration for boot process
	boot.kernelPackages = pkgs.linuxPackages_zen;
	boot.kernelParams = [
		"quiet"
		"splash"
		"nowatchdog"
	];

	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.efi.efiSysMountPoint = "/efi";
}
