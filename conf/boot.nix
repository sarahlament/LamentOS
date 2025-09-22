{
	config,
	pkgs,
	lib,
	...
}: {
	# Let's set default modules and system type
	boot.initrd.availableKernelModules = [
		"nvme"
		"xhci_pci"
		"ahci"
		"usb_storage"
		"usbhid"
		"sd_mod"
		"sr_mod"
	];
	boot.kernelModules = ["kvm-amd"];
	boot.kernelPackages = pkgs.linuxPackages_zen;
	boot.initrd.systemd.enable = true;

	# Plymouth boot splash screen
	boot.plymouth.enable = true;

	# Add some default params to the kernel cmdline
	boot.kernelParams = [
		"quiet"
		"splash"
	];

	# let's set our drives
	fileSystems."/" = {
		device = "/dev/worksys/sys";
		fsType = "ext4";
	};
	fileSystems."/efi" = {
		device = "/dev/disk/by-label/NIXBOOT";
		fsType = "vfat";
		options = [
			"fmask=0077"
			"dmask=0077"
		];
	};
	swapDevices = [{device = "/dev/worksys/swap";}];

	# Allow redist firmware
	hardware.enableRedistributableFirmware = true;
	hardware.cpu.amd.updateMicrocode = true;

	# Use lanzzaboote for secure boot
	boot.loader.systemd-boot.enable = lib.mkForce false;
	boot.lanzaboote = {
		enable = true;
		pkiBundle = "/var/lib/sbctl";
	};
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.efi.efiSysMountPoint = "/efi";

	# Let's not load a few modules
	boot.blacklistedKernelModules = [
		"pcspkr"
		"nouveau"
		"watchdog"
	];

	# Let's include sbctl for key management and modprobed-db so I can whittle down the kernel modules I use
	environment.systemPackages = with pkgs; [
		sbctl
		modprobed-db
	];
}
