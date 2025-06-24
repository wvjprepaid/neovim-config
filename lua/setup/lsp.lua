local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Give me rounded borders everywhere
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- LSP Server config

-- Python LSP (pyright)
require("lspconfig").pyright.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr) -- bufnr is often useful in on_attach
    client.server_capabilities.document_formatting = false
    -- You can add Python-specific keymaps here if needed,
    -- or define a common on_attach function for all servers.
  end,
  -- Pyright specific settings (optional but recommended)
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic", -- "off", "basic", "strict"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        -- Set specific diagnostic modes for problems
        diagnostics = {
          warnPublishingUnused = false, -- Example: Don't warn on unused imports/variables
        },
        -- Add extra paths for imports if your project structure requires it
        -- extraPaths = {
        --   "path/to/my/custom_libs",
        -- },
      },
    },
  },
})

-- Golang LSP (gopls) -- ADD THIS BLOCK
require("lspconfig").gopls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false -- Consistent with your other setups
    -- If you want to enable specific Go-related commands or features
    -- you can add them here within the on_attach function.

    -- Optional: Setup keymaps specific to Go
    -- local buf_set_keymap = vim.api.nvim_buf_set_keymap
    -- local opts = { noremap = true, silent = true }
    -- buf_set_keymap(bufnr, 'n', '<leader>go', '<cmd>GoTag<CR>', opts) -- Example: Requires 'fatih/vim-go' or similar plugin
  end,
  settings = {
    gopls = {
      -- These are common gopls settings. Adjust as per your preference.
      -- Refer to `gopls` documentation for a full list: `go doc golang.org/x/tools/gopls`
      buildFlags = {}, -- e.g., { "-tags=foo" }
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      staticcheck = true, -- Enable static analysis by default (highly recommended)
      gofumpt = false,
      analyses = {
        -- Enable/disable specific analyses from gopls
        unusedparams = true, -- Check for unused parameters
        unusedvariable = true,
        unreachable = true,
        unusedfunc = true,
        unusedresult = true,
        unusedwrite = true,
        waitgroup = true,

      },
      -- ["ui.completion.useDeepCompletions"] = true,
      -- ["ui.diagnostic.annotations"] = {}, -- Hide certain diagnostics
      -- ["ui.formatting.gofumpt"] = true, -- Use gofumpt instead of gofmt if available
      -- ["ui.semanticTokens"] = true, -- Enable semantic highlighting (requires nvim-treesitter setup)
    },
  },
})

-- Markdown LSP (Marksman)
require("lspconfig").marksman.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false
    -- You can add specific settings for marksman here if needed
  end,
  filetypes = { "markdown" },
})


require("lspconfig").cssls.setup({
  capabilities = capabilities,
  settings = {
    css = {
      lint = {
        emptyRules = "ignore",
        duplicateProperties = "warning",
      },
    },
    scss = {
      lint = {
        idSelector = "warning",
        zeroUnits = "warning",
        duplicateProperties = "warning",
        emptyRules = nil,
      },
      completion = {
        completePropertyWithSemicolon = true,
        triggerPropertyValueCompletion = true,
      },
    },
  },
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
})
require("lspconfig").ts_ls.setup({
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
})

require("lspconfig").html.setup({
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
})

require("lspconfig").stylelint_lsp.setup({
  filetypes = { "css", "scss" },
  root_dir = require("lspconfig").util.root_pattern("package.json", ".git"),
  settings = {
    stylelintplus = {
      -- see available options in stylelint-lsp documentation
    },
  },
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
})

-- require("lspconfig").eslint.setup({
--   root_dir = require("lspconfig").util.root_pattern("package.json", ".git"),
--   on_attach = function(client)
--     client.server_capabilities.document_formatting = false
--   end,
-- })

-- LSP Prevents inline buffer annotations
vim.diagnostic.open_float()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  underline = true,
  update_on_insert = false,
})
