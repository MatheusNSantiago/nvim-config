local M = {}

function M.setup()
  return {
    'Wansmer/symbol-usage.nvim',
    event = 'BufReadPre', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = M.config,
  }
end

function M.config()
  local SymbolKind = vim.lsp.protocol.SymbolKind

  local default_opts = {
    ---@type table<string, any> `nvim_set_hl`-like options for highlight virtual text
    hl = { link = 'Comment' },
    kinds = { SymbolKind.Function, SymbolKind.Method },
    ---@type 'above'|'end_of_line'|'textwidth'
    vt_position = 'end_of_line',
    ---@type function(symbol: Symbol): string
    text_format = function(symbol)
      local fragments = {}
      local number_of_references = symbol.references

      if number_of_references then
        if number_of_references > 0 then
          table.insert(fragments, ('[🔗%s]'):format(number_of_references)) --
        end
      end

      if symbol.definition then table.insert(fragments, symbol.definition .. ' defs') end

      if symbol.implementation then table.insert(fragments, symbol.implementation .. ' impls') end

      return table.concat(fragments, ', ')
    end,
    references = { enabled = true, include_declaration = false },
    definition = { enabled = false },
    implementation = { enabled = false },
    filetypes = {},
  }

  require('symbol-usage').setup(default_opts)
end

return M
