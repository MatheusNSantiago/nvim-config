
-- https://github.com/neovim/nvim-lspconfig

--[[ local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
  return
end

local protocol = require("vim.lsp.protocol")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  --Enable completion triggered by <c-x><c-o>
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "<leader>ff", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
end

protocol.CompletionItemKind = {
  "", -- Text
  "", -- Method
  "", -- Function
  "", -- Constructor
  "", -- Field
  "", -- Variable
  "", -- Class
  "ﰮ", -- Interface
  "", -- Module
  "", -- Property
  "", -- Unit
  "", -- Value
  "", -- Enum
  "", -- Keyword
  "﬌", -- Snippet
  "", -- Color
  "", -- File
  "", -- Reference
  "", -- Folder
  "", -- EnumMember
  "", -- Constant
  "", -- Struct
  "", -- Event
  "ﬦ", -- Operator
  "", -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require("cmp_nvim_lsp").default_capabilities()

nvim_lsp.flow.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

nvim_lsp.tsserver.setup({
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities,
})

nvim_lsp.sourcekit.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

nvim_lsp.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pyright = { autoImportCompletion = true },
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
        completeFunctionParens = true,
        typeCheckingMode = "off",
      },
    },
  },
})

nvim_lsp.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        -- library = vim.api.nvim_get_runtime_file("", true),
        library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
        },
        checkThirdParty = false,
        maxPreload = 10000,
      },
    },
  },
})

nvim_lsp.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

nvim_lsp.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

nvim_lsp.astro.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  -- virtual_text=false,
  virtual_text = {
    spacing = 4,
    prefix = "●",
  },
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  severity_sort = true,
  virtual_text = {
    spacing = 4,
    prefix = "●",
  },
  update_in_insert = true,
}) ]]

--[[ -- Create a custom namespace. This will aggregate signs from all other
-- namespaces and only show the one with the highest severity on a
-- given line
local ns = vim.api.nvim_create_namespace("my_namespace")

-- Get a reference to the original virtual_text handler
local orig_signs_handler = vim.diagnostic.handlers.virtual_text

-- Override the built-in virtual_text handler
vim.diagnostic.handlers.virtual_text = {
  show = function(_, bufnr, _, opts)
    -- Get all diagnostics from the whole buffer rather than just the
    -- diagnostics passed to the handler
    local diagnostics = vim.diagnostic.get(bufnr)

    -- Find the "worst" diagnostic per line
    local max_severity_per_line = {}
    for _, d in pairs(diagnostics) do
      local m = max_severity_per_line[d.lnum]
      if not m or d.severity < m.severity then
        max_severity_per_line[d.lnum] = d
      end
    end

    -- Pass the filtered diagnostics (with our custom namespace) to
    -- the original handler
    local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
    orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
  end,
  hide = function(_, bufnr)
    orig_signs_handler.hide(ns, bufnr)
  end,
} ]]

