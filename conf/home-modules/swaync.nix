{
	config,
	pkgs,
	lib,
	...
}: let
	# Import Catppuccin palette
	inherit (config.catppuccin) sources;
	palette = (lib.importJSON "${sources.palette}/palette.json").mocha.colors;
in {
	services.swaync = {
		enable = true;
		settings = {
			positionX = "right";
			positionY = "top";
			layer = "overlay";
			control-center-layer = "top";
			layer-shell = true;
			cssPriority = "application";
			control-center-margin-top = 10;
			control-center-margin-bottom = 10;
			control-center-margin-right = 10;
			control-center-margin-left = 10;
			notification-2fa-action = true;
			notification-inline-replies = false;
			notification-icon-size = 64;
			notification-body-image-height = 100;
			notification-body-image-width = 200;
			timeout = 10;
			timeout-low = 5;
			timeout-critical = 0;
			fit-to-screen = true;
			control-center-width = 500;
			control-center-height = 600;
			notification-window-width = 500;
			keyboard-shortcuts = true;
			image-visibility = "when-available";
			transition-time = 200;
			hide-on-clear = false;
			hide-on-action = true;
			script-fail-notify = true;
			scripts = {
				example-script = {
					exec = "echo 'Do something...'";
					urgency = "Normal";
				};
			};
		};
		
		style = ''
			* {
				font-family: "JetBrains Mono Nerd Font";
				font-weight: normal;
				font-size: 14px;
				min-height: 0;
			}
			
			.floating-notifications {
				background: transparent;
			}
			
			/* Notification window styling */
			.notification-row {
				outline: none;
				margin: 10px;
				padding: 0;
			}
			
			.notification-row:focus,
			.notification-row:hover {
				background: rgba(203, 166, 247, 0.1);
				border-radius: 10px;
			}
			
			.notification {
				background: rgba(30, 30, 46, 0.95);
				border: 2px solid #${palette.mauve.hex};
				border-radius: 15px;
				margin: 6px 12px;
				box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
				padding: 0;
			}
			
			.notification-content {
				background: transparent;
				padding: 15px;
				border-radius: 13px;
			}
			
			.notification-default-action,
			.notification-action {
				padding: 4px;
				margin: 0;
				box-shadow: none;
				background: rgba(69, 71, 90, 0.8);
				border: 1px solid #${palette.surface0.hex};
				color: #${palette.text.hex};
				transition: all 200ms;
			}
			
			.notification-default-action:hover,
			.notification-action:hover {
				-gtk-icon-effect: none;
				background: rgba(203, 166, 247, 0.2);
				border: 1px solid #${palette.mauve.hex};
			}
			
			.notification-default-action {
				border-radius: 13px;
			}
			
			/* Notification content styling */
			.summary {
				font-size: 16px;
				font-weight: bold;
				background: transparent;
				color: #${palette.text.hex};
				text-shadow: none;
			}
			
			.time {
				font-size: 12px;
				font-weight: bold;
				background: transparent;
				color: #${palette.subtext1.hex};
				text-shadow: none;
				margin-right: 18px;
			}
			
			.body {
				font-size: 14px;
				font-weight: normal;
				background: transparent;
				color: #${palette.subtext1.hex};
				text-shadow: none;
			}
			
			/* Control center styling */
			.control-center {
				background: rgba(30, 30, 46, 0.95);
				border: 3px solid #${palette.mauve.hex};
				border-radius: 15px;
				margin: 10px;
				box-shadow: 0 16px 64px rgba(0, 0, 0, 0.4);
			}
			
			.control-center-list {
				background: transparent;
			}
			
			.control-center-list-placeholder {
				opacity: 0.5;
			}
			
			.control-center .notification-row:focus,
			.control-center .notification-row:hover {
				opacity: 1;
				background: rgba(203, 166, 247, 0.1);
			}
			
			.control-center .notification {
				border: 2px solid #${palette.surface0.hex};
				background: rgba(69, 71, 90, 0.8);
			}
			
			/* Widget styling */
			.widget-title {
				margin: 8px;
				font-size: 18px;
				font-weight: bold;
				color: #${palette.text.hex};
			}
			
			.widget-title > button {
				font-size: 16px;
				color: #${palette.text.hex};
				text-shadow: none;
				background: rgba(69, 71, 90, 0.8);
				border: 2px solid #${palette.surface0.hex};
				border-radius: 10px;
				box-shadow: none;
				padding: 8px 16px;
			}
			
			.widget-title > button:hover {
				background: rgba(203, 166, 247, 0.2);
				border: 2px solid #${palette.mauve.hex};
			}
			
			.widget-dnd {
				margin: 8px;
				font-size: 16px;
				color: #${palette.text.hex};
			}
			
			.widget-dnd > switch {
				font-size: initial;
				border-radius: 8px;
				background: rgba(69, 71, 90, 0.8);
				border: 2px solid #${palette.surface0.hex};
			}
			
			.widget-dnd > switch:checked {
				background: linear-gradient(45deg, #${palette.mauve.hex}, #${palette.lavender.hex});
			}
			
			.widget-dnd > switch slider {
				background: #${palette.text.hex};
				border-radius: 8px;
			}
			
			/* Close button styling */
			.close-button {
				background: rgba(243, 139, 168, 0.8);
				color: #${palette.base.hex};
				text-shadow: none;
				padding: 0;
				border-radius: 50%;
				margin-top: 10px;
				margin-right: 16px;
				box-shadow: none;
				border: none;
				min-width: 24px;
				min-height: 24px;
			}
			
			.close-button:hover {
				box-shadow: none;
				background: #${palette.red.hex};
			}
			
			/* Urgency-specific styling */
			.low {
				border: 2px solid #${palette.surface0.hex};
			}
			
			.normal {
				border: 2px solid #${palette.blue.hex};
			}
			
			.critical {
				border: 2px solid #${palette.red.hex};
			}
			
			.critical .notification-content {
				background: rgba(243, 139, 168, 0.1);
			}
		'';
	};
}