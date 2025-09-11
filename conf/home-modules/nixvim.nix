{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;

    #================================================================
    # Base Editor Settings
    #================================================================
    # Set tab options
    opts = {
      tabstop = 4;
      expandtab = false;
      shiftwidth = 4;
      number = true; # Show line numbers
      relativenumber = true; # Show relative line numbers
      scrolloff = 8; # Keep 8 lines of context around the cursor
      mouse = "a"; # Enable mouse support
    };

    # Set leader key to space
    globals.mapleader = " ";

    #================================================================
    # Keymaps
    #================================================================
    # These are some sensible default keymaps for the plugins we're adding.
    # You can change or add to these as you see fit.
    keymaps = [
      # Telescope: File and text searching
      { key = "<leader>ff"; action = "<cmd>Telescope find_files<cr>"; mode = "n"; options.desc = "Find Files"; }
      { key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>"; mode = "n"; options.desc = "Live Grep"; }
      { key = "<leader>fb"; action = "<cmd>Telescope buffers<cr>"; mode = "n"; options.desc = "Find Buffers"; }
      { key = "<leader>fh"; action = "<cmd>Telescope help_tags<cr>"; mode = "n"; options.desc = "Help Tags"; }

      # Conform: Format code
      { key = "<leader><Tab>"; action = "<cmd>ConformFormat<cr>"; mode = ["n" "v"]; options.desc = "Format code"; }

      # Neo-tree: File explorer
      { key = "<leader>e"; action = "<cmd>Neotree toggle<cr>"; mode = "n"; options.desc = "Toggle File Explorer"; }

      # Oil.nvim: Edit filesystem
      { key = "-"; action = "<cmd>Oil<cr>"; mode = "n"; options.desc = "Open parent directory"; }

      # Lazygit
      { key = "<leader>gg"; action = "<cmd>LazyGit<cr>"; mode = "n"; options.desc = "Open LazyGit"; }
    ];

    #================================================================
    # UI & Experience Plugins
    #================================================================
    # Catppuccin theme
    colorschemes.catppuccin = {
      enable = true;
      flavour = "macchiato";
    };

    # Lualine: A fast and customizable status line
    plugins.lualine.enable = true;

    # Which-key: Displays a popup of possible keybindings
    plugins.which-key.enable = true;

    # Noice: A more modern UI for messages and commands
    plugins.noice.enable = true;

    # Indent-blankline: Adds indentation guides
    plugins.indent-blankline.enable = true;

    # Bufferline: VS Code-style tabs
    plugins.bufferline.enable = true;

    # Dressing: Improves the UI for built-in prompts
    plugins.dressing.enable = true;

    #================================================================
    # Language & Code Intelligence Plugins
    #================================================================
    # LSP (Language Server Protocol) support
    lsp = {
      enable = true;
      servers = {
        nil.enable = true;      # Nix
        taplo.enable = true;    # TOML
        jsonls.enable = true;   # JSON
        bashls.enable = true;   # Shell
        yamlls.enable = true;   # YAML
        marksman.enable = true; # Markdown
      };
    };

    # Treesitter: Better syntax highlighting and code parsing
    treesitter.enable = true;

    # Conform: A powerful and fast code formatter
    plugins.conform-nvim = {
      enable = true;
      formatOnSave = {
        lspFallback = true;
        timeoutMs = 500;
      };
      formattersByFt = {
        nix = [ "nixpkgs-fmt" ];
        toml = [ "taplo" ];
        json = [ "prettier" ];
        yaml = [ "prettier" ];
        markdown = [ "prettier" ];
        sh = [ "shfmt" ];
        bash = [ "shfmt" ];
      };
    };

    # Completion engine (nvim-cmp)
    completion = {
      cmp = {
        enable = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
      };
    };

    # Snippet engine (LuaSnip)
    snippets.luasnip.enable = true;

    # Debug Adapter Protocol (DAP)
    plugins.dap.enable = true;

    #================================================================
    # File & Project Management Plugins
    #================================================================
    # Telescope: A highly-extensible fuzzy finder
    plugins.telescope = {
      enable = true;
      # This extension makes Telescope's sorting much faster
      extensions.fzf-native.enable = true;
    };

    # Neo-tree: A modern file tree explorer
    plugins.neo-tree.enable = true;

    # Oil.nvim: Edit your filesystem like a Neovim buffer
    plugins.oil.enable = true;

    #================================================================
    # Git Integration Plugins
    #================================================================
    # Gitsigns: Shows git diff information in the sign column
    plugins.gitsigns.enable = true;

    # Lazygit: A powerful terminal UI for git
    plugins.lazygit.enable = true;

    #================================================================
    # Other Essential Plugins
    #================================================================
    # Comment.nvim: Quickly comment and uncomment code
    plugins.comment.enable = true;

    # Nvim-autopairs: Automatically closes pairs of brackets, etc.
    plugins.nvim-autopairs.enable = true;

    # Flash: Instantly jump anywhere on screen
    plugins.flash.enable = true;
  };
}
