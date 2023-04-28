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
      --  │                         Linter                           │
      --  ╰──────────────────────────────────────────────────────────╯

      -- b.diagnostics.eslint_d, -- js/ts
      -- b.diagnostics.xo,
      b.diagnostics.fish,  -- fish
      b.diagnostics.ruff,  -- python
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
      local ft = vim.bo[bufnr].filetype
      local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

      vim.keymap.set("n", "<Leader>ff", function()
        vim.lsp.buf.format({
          bufnr = bufnr,
          timeout_ms = 5000,
          filter = function(_client)
            if have_nls then
              return _client.name == "null-ls"
            end
            return _client.name ~= "null-ls"
          end,
        })
      end, { buffer = bufnr })
    end,
  })
end

return M
