-- Setup installer & lsp configs
local typescript_ok, typescript = pcall(require, "typescript")

local mason_ok, mason = pcall(require, "mason")
local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")


if not mason_ok or not mason_lsp_ok then
  return
end

mason.setup({
  ui = {
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "rounded",
  },
})

mason_lsp.setup({
  -- A list of servers to automatically install if they're not already installed
  ensure_installed = {
    "bashls",
    "cssls",
    "eslint",
    "graphql",
    "html",
    "jsonls",
    "lua_ls",
    "tailwindcss",
    "tsserver",
    "pyright",
    "prismals",
  },
  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  automatic_installation = true,
})

local lspconfig = require("lspconfig")

local defaut_handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    severity_sort = true,
    underline = true,
    update_in_insert = false,
    -- virtual_text=false,
    virtual_text = {
      spacing = 4,
      prefix = "●",
    },
  }),
}

local function on_attach(client, bufnr)
  -- set up buffer keymaps, etc.

  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "<leader>ff", function() vim.lsp.buf.format({ async = true }) end, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- Order matters

-- It enables tsserver automatically so no need to call lspconfig.tsserver.setup
if typescript_ok then
  typescript.setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false,          -- enable debug logging for commands
    -- LSP Config options
    server = {
      capabilities = require("lsp.servers.tsserver").capabilities,
      handlers = require("lsp.servers.tsserver").handlers,
      on_attach = require("lsp.servers.tsserver").on_attach,
      settings = require("lsp.servers.tsserver").settings,
    },
  })
end

lspconfig.tailwindcss.setup({
  capabilities = require("lsp.servers.tailwindcss").capabilities,
  filetypes = require("lsp.servers.tailwindcss").filetypes,
  handlers = defaut_handlers,
  init_options = require("lsp.servers.tailwindcss").init_options,
  on_attach = require("lsp.servers.tailwindcss").on_attach,
  settings = require("lsp.servers.tailwindcss").settings,
})

lspconfig.cssls.setup({
  capabilities = capabilities,
  handlers = defaut_handlers,
  on_attach = require("lsp.servers.cssls").on_attach,
  settings = require("lsp.servers.cssls").settings,
})

lspconfig.eslint.setup({
  capabilities = capabilities,
  handlers = defaut_handlers,
  on_attach = require("lsp.servers.eslint").on_attach,
  settings = require("lsp.servers.eslint").settings,
})

lspconfig.jsonls.setup({
  capabilities = capabilities,
  handlers = defaut_handlers,
  on_attach = on_attach,
  settings = require("lsp.servers.jsonls").settings,
})

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  handlers = defaut_handlers,
  on_attach = on_attach,
  settings = require("lsp.servers.lua_ls").settings,
})

lspconfig.vuels.setup({
  filetypes = require("lsp.servers.vuels").filetypes,
  handlers = defaut_handlers,
  init_options = require("lsp.servers.vuels").init_options,
  on_attach = on_attach,
})

for _, server in ipairs({ "bashls", "emmet_ls", "graphql", "html", "volar", "prismals" }) do
  lspconfig[server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = defaut_handlers,
  })
end

