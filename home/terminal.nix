{
	config,
	lib,
	pkgs,
	...
}: {
	programs = {
		kitty = {
			enable = true;

			shellIntegration.enableZshIntegration = true;
			actionAliases = {
				"launch_tab" = "launch --cwd=current --type=tab";
				"launch_window" = "launch --cwd=current --type=os-window";
			};
			settings = {
				enable_audio_bell = false;
				remember_window_size = false;
				dynamic_background_opacity = true;
				hide_window_decorations = true;
				cursor_blink_interval = 0.5;
				cursor_stop_blinking_after = 2;
				scrollback_lines = 5000;
				window_padding_width = 5;
				cursor_trail = 5;
				cursor_trail_decay = "0.2 0.6";
				scrollback_indicator_opacity = 0.3;
				mouse_hide_wait = 2;
				show_hyperlink_targets = true;
				underline_hyperlinks = "always";
			};
		};

		git = {
			enable = true;
			userName = "Sarah Lament";
			userEmail = "4612427+sarahlament@users.noreply.github.com";
			extraConfig = {
				init.defaultBranch = "main";
				fetch.prune = true;
				pull.rebase = true;
			};
			aliases = {
				sreset = "reset HEAD~1 --soft";
				hreset = "reset HEAD~1 --hard";
				logg = "log --oneline --decorate --all --graph";
				stat = "status --short --branch";
			};
		};

		# ls, but fancy
		eza = {
			enable = true;
			git = true;
			colors = "auto";
			icons = "auto";
			extraOptions = [
				"--group-directories-first"
				"--header"
			];
		};

		# Configure btop for better system monitoring
		btop = {
			enable = true;
			settings = {
				# Performance
				update_ms = 2000; # 2 second refresh (less CPU usage)

				# Display preferences
				show_uptime = true;
				proc_tree = true; # Show process tree like htop
				proc_sorting = "cpu lazy"; # Sort by CPU usage
				proc_reversed = false;

				# CPU display
				cpu_graph_upper = "total";
				cpu_graph_lower = "total";

				# Memory display
				mem_graph_upper = "used";
				mem_graph_lower = "available";

				# Hide network/IO (you can toggle on manually if needed)
				show_io_stat = false;
				show_disks = false;

				# Interface
				vim_keys = false; # Use normal arrow key navigation
				show_battery = true;
				clock_format = "%H:%M";
			};
		};

		# fancy system info parser thingy
		fastfetch.enable = true;

		command-not-found.enable = true; # yes, I know what I *want* to do
		bat.enable = true; # better cat
	};
}