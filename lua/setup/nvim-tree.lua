local nvimtree = require("nvim-tree")

nvimtree.setup({
  -- Customize the appearance and behavior of nvim-tree
  sort_by = "case_sensitive", -- How files/folders are sorted
  renderer = {
    group_empty = true, -- Group empty directories at the end
    full_name = true,   -- Show full file names (including extensions)
    icons = {
      git_placement = "before", -- Show git status icons before the file name
      -- You can customize specific icons here if nvim-web-devicons is not enough
    },
  },
  filters = {
    dotfiles = false, -- Show hidden files (starting with '.')
    git_ignored = false, -- Show git ignored files
    -- exclude = { "node_modules" }, -- Exclude specific directories globally
  },
  view = {
    width = 30, -- Default width of the tree window
    side = "left", -- "left" or "right"
    relativenumber = false, -- Show relative line numbers in the tree
    number = false,         -- Show absolute line numbers
    -- auto_resize = true,  -- Resize the tree window automatically
  },
  actions = {
    open_file = {
      quit_on_open = false, -- Keep nvim-tree open after opening a file
      resize_window = true, -- Resize related window when opening a file
      -- Other options for how files open
    },
  },
  git = {
    enable = true, -- Enable git integration (shows indicators for modified/untracked files)
    ignore = false,
  },
  -- For a comprehensive list of options, see :help nvim-tree.setup
})

vim.keymap.set('n', '<leader>tt', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
vim.keymap.set('n', '<leader>ts', '<cmd>NvimTreeFindFile<CR>', { desc = 'Find current file in NvimTree' })
vim.keymap.set('n', '<leader>tr', '<cmd>NvimTreeRefresh<CR>', { desc = 'Refresh NvimTree' })
