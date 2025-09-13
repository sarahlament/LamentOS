{
	config,
	pkgs,
	lib,
	...
}: {
	programs.gemini-cli = {
		enable = true;
		settings = {
			theme = "Dracula";
			vimMode = true;
			preferedEditor = "nvim";
			selectedAuthType = "gemini-api-key";
		};
	};

	programs.claude-code.enable = true;
}
