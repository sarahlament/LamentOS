{
	config,
	lib,
	pkgs,
	...
}: {
	# Default environment variables I want set at session start
	home.sessionVariables = {
		# Build configuration
		MAKEFLAGS = "-j16";
		ZSH_COMPDUMP = "${config.home.homeDirectory}/.cache/.zcompdump-${pkgs.zsh.version}";
	};
}
