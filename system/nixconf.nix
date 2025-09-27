{
	config,
	lib,
	pkg,
	...
}: {
	nix.settings = {
		experimental-features = [
			"nix-command" # we need the 'nix' command for a few things
			"flakes" # we definitely want flakes
		];
		substituters = [
			"https://nix-community.cachix.org"
		];
		trusted-public-keys = [
			"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
		];
	};
}
