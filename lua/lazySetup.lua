-- returns the require for use in `config` parameter of lazy's use
-- expects the name of the config file
function get_setup(name)
  return function()
    require("setup." .. name)
  end
end

return {
  { "rebelot/kanagawa.nvim", config = get_setup("themes/kanagawa"), priority = 1000, lazy = false },
  -- { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "stevearc/oil.nvim", event = "VeryLazy", config = get_setup("oil") },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = get_setup("conform"),
  },
  { "mbbill/undotree" },
  { "LudoPinelli/comment-box.nvim", event = "VeryLazy" },
  { "numToStr/Comment.nvim", lazy = false,
    config = get_setup("comment") 
  },

  {
    'nvim-tree/nvim-tree.lua',
    version = '*', -- Recommended to use a specific version or '*' for the latest stable
    lazy = false,  -- Often, you want the tree to be available at startup
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- Optional, but highly recommended for file icons
    },
    config = get_setup("nvim-tree"), -- This will load your lua/setup/nvim-tree.lua file
  },

  { "rlane/pounce.nvim", config = get_setup("pounce") },
  {
    "nvim-lualine/lualine.nvim",
    config = get_setup("lualine"),
    event = "VeryLazy",
  },
  {
    "folke/which-key.nvim",
    config = get_setup("which-key"),
    event = "VeryLazy",
  },
  { "brenoprata10/nvim-highlight-colors", config = get_setup("highlight-colors") },
  {
    "nvim-treesitter/nvim-treesitter",
    config = get_setup("treesitter"),
    build = ":TSUpdate",
    event = "BufReadPost",
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = require("setup.snacks"),
  },
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    opts = require("setup.blink"),
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = get_setup("gitsigns"),
  },
  {
    "neovim/nvim-lspconfig",
    config = get_setup("lsp"),
    dependencies = { "saghen/blink.cmp" },
  },

    -- START: Add Mason and Mason-LSPConfig here
  {
    'williamboman/mason.nvim',
    -- Optional: Configure mason to automatically install/update certain servers when it first runs
    opts = {
      ensure_installed = {
        "lua_ls",         -- For Lua development
        "pyright",        -- For Python development
        "tsserver",       -- For TypeScript/JavaScript
        "rust_analyzer",  -- For Rust
        "html",           -- For HTML
        "cssls",          -- For CSS
        "gopls",
        "marksman",
        -- Add more servers here as needed
      },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim', -- Bridges Mason and nvim-lspconfig
    dependencies = {
      'williamboman/mason.nvim',        -- Mason is a dependency
      'neovim/nvim-lspconfig',          -- nvim-lspconfig is also a dependency
    },
    opts = {
      -- This ensures that nvim-lspconfig setups are generated automatically
      -- for servers installed by Mason. It's crucial for Mason to integrate.
      automatic_setup = true,
      -- You can also specify which servers you want to register.
      -- For example, ensure_installed_lsp_servers = { "lua_ls", "pyright" }
    },
    config = function(_, opts)
      -- This setup function for mason-lspconfig.nvim needs to run within lazy.nvim's config
      require('mason-lspconfig').setup(opts)
      -- If you have a custom 'lsp.lua' file (which you do), you'll need to
      -- require it AFTER mason-lspconfig has done its automatic setup.
      -- This ensures your custom lspconfig settings override or augment Mason's defaults.
      require('setup.lsp') -- This calls your existing lua/setup/lsp.lua
    end,
  },
  -- END: Add Mason and Mason-LSPConfig here

  -- START: Add nvim-navbuddy and its dependencies here
  {
    'SmiteshP/nvim-navic',
    opts = {}, -- You can add nvim-navic specific options here if needed, but often not required for navbuddy
  },
  {
    'MunifTanjim/nui.nvim',
    -- This is a UI library, no specific setup is usually needed here.
    -- It's often loaded implicitly by other plugins, but explicit is fine.
  },
  {
    'SmiteshP/nvim-navbuddy',
    dependencies = {
      'SmiteshP/nvim-navic',
      'MunifTanjim/nui.nvim',
      -- 'neovim/nvim-lspconfig' is already managed as a top-level plugin,
      -- but listing it here as a dependency explicitly doesn't hurt and clarifies intent.
      'neovim/nvim-lspconfig',
      -- Optional: uncomment if you want integration with Telescope
      -- 'nvim-telescope/telescope.nvim',
    },
    config = get_setup("navbuddy"), -- This will load your lua/setup/navbuddy.lua file
    event = "LspAttach", -- Load navbuddy when an LSP server attaches to a buffer
    -- Or you could use lazy = false if you want it always available,
    -- but LspAttach is more efficient.
  },
  -- END: Add nvim-navbuddy and its dependencies here

  -- In your lazySetup.lua file

  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = get_setup("fzf"),
  },
  { "rmagatti/auto-session", config = get_setup("auto-session") },
  { "echasnovski/mini.ai", config = get_setup("mini-ai"), version = false },
  { "echasnovski/mini.bracketed", config = get_setup("mini-bracketed"), version = false },
  { "echasnovski/mini.move", config = get_setup("mini-move"), version = false },
  { "windwp/nvim-ts-autotag", event = "InsertEnter" },
  {
    "windwp/nvim-autopairs",
    config = get_setup("autopairs"),
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  { "EdenEast/nightfox.nvim", config = get_setup("nightfox"), enabled = false },
  { "folke/tokyonight.nvim", config = get_setup("tokyonight"), enabled = false },
  { "catppuccin/nvim", name = "catppuccin", config = get_setup("catppuccin"), enabled = false },
}
