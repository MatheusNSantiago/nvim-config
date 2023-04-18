local M = {}

function M.setup()
  return {
    "jose-elias-alvarez/null-ls.nvim",
    config = M.config,
  }
end

function M.config()
  local null_ls = require("null-ls")
  local b = null_ls.builtins

  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
  null_ls.setup({
    sources = {
      --  ╭──────────────────────────────────────────────────────────╮
      --  │                        Formatting                        │
      --  ╰──────────────────────────────────────────────────────────╯

      b.formatting.stylua,   -- lua
      b.formatting.black,    -- python
      b.formatting.prettierd, -- js/ts
      -- b.formatting.rustywind, -- tailwind (reorganiza classes)
      b.formatting.fixjson,  -- json
      b.formatting.yamlfmt,  -- yaml
      b.formatting.dart_format, -- dart
      b.formatting.fish_indent, -- fish

      --  ╭──────────────────────────────────────────────────────────╮
      --  │                       Diagnostics                        │
      --  ╰──────────────────────────────────────────────────────────╯

      -- b.diagnostics.eslint_d, -- js/ts
      -- b.diagnostics.xo,
      b.diagnostics.fish,  -- fish
      b.diagnostics.ruff,   -- python
      b.diagnostics.yamllint, -- yaml

--  ╭──────────────────────────────────────────────────────────╮
--  │                        Completion                        │
--  ╰──────────────────────────────────────────────────────────╯

      b.completion.luasnip,

--  ╭──────────────────────────────────────────────────────────╮
--  │                       Code Actions                       │
--  ╰──────────────────────────────────────────────────────────╯
      b.code_actions.eslint_d,
      require("typescript.extensions.null-ls.code-actions"),
    },
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "<Leader>ff", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr })
    end,
  })
end

return M
