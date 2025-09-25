{config, ...}: {
	nix.settings.experimental-features = [
		"nix-command" # we need the 'nix' command for a few things
		"flakes" # we definitely want flakes
	];
}