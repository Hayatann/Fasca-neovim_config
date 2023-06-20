-- Add plugins, the packer syntax without the "use"
return {
  -- disable default plugins
  ["folke/which-key.nvim"] = {
    disable = true,
  },

  -- motion & edit
  { "mg979/vim-visual-multi" },

  { "tpope/vim-repeat" },

  { "tpope/vim-surround" },

  { "ggandor/lightspeed.nvim" },

  -- git
  { "tpope/vim-fugitive" },

  ["sindrets/diffview.nvim"] = {
    after = "plenary.nvim",
    requires = "nvim-lua/plenary.nvim",
  },

  ["akinsho/git-conflict.nvim"] = { tag = "*", config = function() require("git-conflict").setup() end },

  -- autocomplete
  ["hrsh7th/cmp-nvim-lua"] = { after = "cmp_luasnip" },

  ["tzachar/cmp-tabnine"] = {
    requires = "hrsh7th/nvim-cmp",
    run = "./install.sh",
    config = function()
      require("cmp_tabnine.config").setup {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
        ignored_file_types = {},
        show_prediction_strength = false,
      }
      require("core.utils").add_cmp_source { name = "cmp_tabnine", priority = 1000, max_item_count = 7 }
    end,
  },

  ["rafamadriz/friendly-snippets"] = { event = { nil } },

  -- lsp
  ["jose-elias-alvarez/typescript.nvim"] = {
    after = "mason-lspconfig.nvim",
    config = function()
      require("typescript").setup {
        server = astronvim.lsp.server_settings "tsserver",
      }
    end,
  },

  ["simrat39/rust-tools.nvim"] = {
    after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
    config = function()
      require("rust-tools").setup {
        server = astronvim.lsp.server_settings "rust_analyzer", -- get the server settings and built in capabilities/on_attach
      }
    end,
  },

  ["WhoIsSethDaniel/mason-tool-installer.nvim"] = {
    after = "mason.nvim",
    config = function() require("user.plugins.mason-tool-installer").setup() end,
  },

  -- enhancement
  ["folke/todo-comments.nvim"] = {
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },

  ["folke/trouble.nvim"] = {
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },

  { "MattesGroeger/vim-bookmarks" },

  -- docs
  {
    "kkoomen/vim-doge",
    run = ":call doge#install()",
    config = function() require("user.plugins.vim-doge-conf").setup() end,
    cmd = { "DogeGenerate", "DogeCreateDocStandard" },
  },

  -- ["danymat/neogen"] = {
  --   config = function() require("neogen").setup(require "user.plugins.neogen-conf") end,
  -- },

  -- telescope

  ["tom-anders/telescope-vim-bookmarks.nvim"] = {
    after = "telescope.nvim",
    config = function() require("telescope").load_extension "vim_bookmarks" end,
  },

  ["nvim-telescope/telescope-project.nvim"] = {
    after = "telescope.nvim",
    config = function() require("telescope").load_extension "project" end,
  },

  ["nvim-telescope/telescope-live-grep-args.nvim"] = {
    after = "telescope.nvim",
    config = function() require("telescope").load_extension "live_grep_args" end,
  },

  ["nvim-telescope/telescope-file-browser.nvim"] = {
    after = "telescope.nvim",
    module = "telescope._extensions.file_browser",
    config = function() require("telescope").load_extension "file_browser" end,
  },

  -- ["nvim-telescope/telescope-media-files.nvim"] = {
  --   after = "telescope.nvim",
  --   config = function() require("telescope").load_extension "media_files" end,
  -- },

  -- themes
  ["EdenEast/nightfox.nvim"] = {
    config = function()
      require("nightfox").setup {
        options = {
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
        },
      }
    end,
  },

  ["ellisonleao/gruvbox.nvim"] = {
    config = function()
      require("gruvbox").setup {
        constrast = "soft",
        transparent_mode = true,
        overrides = {
          StatusLine = { bg = "#282828" },
        },
      }
    end,
  },

  { "luisiacc/gruvbox-baby" },

  { "sainnhe/gruvbox-material" },

  { "sainnhe/everforest" },

  { "savq/melange" },

  -- Discord
  {
    "andweeb/presence.nvim",
    config = function()
      require("presense").setup {
        -- General options
        auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
        neovim_image_text = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
        main_image = "neovim", -- Main image display (either "neovim" or "file")
        -- client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
        log_level = "info", -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
        enable_line_number = false, -- Displays the current line number instead of the current project
        blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
        buttons = true, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
        file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
        show_time = true, -- Show the timer

        -- Rich Presence text options
        editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
        file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
        git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
        plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
        reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
        workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
        line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
      }
    end,
  },
}
