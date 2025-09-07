{ conf, pkgs, lib, ... }:

{
	programs.gemini-cli = {
		enable = true;

		commands = {
			genchangelog = {
				prompt = ''
					Your task is to parse the `<version>`, `<change_type>`, and `<message>` from their input and use the `write_file` tool to correctly update the `CHANGELOG.md` file.
				'';
				description = "Adds a new entry to the project's CHANGELOG.md file.";
			};
			"git/fix" = { # Becomes /git:fix
				prompt = "Please analyze the staged git changes and provide a code fix for the issue described here: {{args}}.";
				description = "Generates a fix for a given GitHub issue.";
			};
		};
	};
}