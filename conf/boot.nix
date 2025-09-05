{ conf, pkgs, lib, modulesPath, ... }:

{
	# Let's set default modules and system type
	imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
	boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
	boot.initrd.kernelModules = [ "dm-snapshot" "cryptd" "nvidia" ];
	boot.kernelModules = [ "kvm-amd" ];
	boot.extraModulePackages = [ ];
	boot.kernelPackages = pkgs.linuxPackages;

	# Add some default params to the kernel cmdline
	boot.kernelParams = [ "quiet" "bgrt_disable" "systemd.show_status" ];

	# Let's inform it about my cryptdevice
	boot.initrd.luks.devices.cryptroot = {
		device = "/dev/disk/by-uuid/bdddba9f-4c5c-4476-9404-8fb74d69cde6";
		preLVM = true;
	};
  
	# Now let's set our drives
	fileSystems."/" = { 
		device = "/dev/worksys/sys";
    	fsType = "ext4";
  	};
	fileSystems."/efi" = { 
		device = "/dev/disk/by-uuid/4C94-B9C7";
		fsType = "vfat";
		options = [ "fmask=0077" "dmask=0077" ];
	};
	swapDevices = [ { device = "/dev/worksys/swap"; } ];

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
	boot.blacklistedKernelModules = [ "pcspkr" "nouveau" ];

	# And to unlock it with TPM2
	boot.initrd.systemd.enable = true;
	boot.initrd.systemd.tpm2.enable = true;
	security.tpm2.enable = true;

	# Since these are for secure boot, let's have these here
	environment.systemPackages = with pkgs; [ tpm2-tss tpm2-tools sbctl ];
}
