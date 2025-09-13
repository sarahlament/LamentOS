{
	config,
	pkgs,
	lib,
	modulesPath,
	...
}: {
	# Let's set default modules and system type
	imports = [(modulesPath + "/installer/scan/not-detected.nix")];
	boot.initrd.availableKernelModules = [
		"nvme"
		"xhci_pci"
		"ahci"
		"usb_storage"
		"usbhid"
		"sd_mod"
		"sr_mod"
	];
	boot.initrd.kernelModules = [
		"dm-snapshot"
		"cryptd"
		"nvidia"
	];
	boot.kernelModules = ["kvm-amd"];
	boot.kernelPackages = pkgs.linuxPackages_zen;

	# Add some default params to the kernel cmdline
	boot.kernelParams = [
		"quiet"
		"systemd.show_status"
		"nowatchdog"
	];

	# let's set our drives
	fileSystems."/" = {
		device = "/dev/worksys/sys";
		fsType = "ext4";
	};
	fileSystems."/efi" = {
		device = "/dev/disk/by-uuid/4C94-B9C7";
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

	# Use lanzzaboote for secureboot
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
	];

	# Let's include sbctl for key managment and modprobed-db so I can whittle down the kernel modules I use
	environment.systemPackages = with pkgs; [
		sbctl
		modprobed-db
	];
}
