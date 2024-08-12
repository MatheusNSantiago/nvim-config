local M = {}
local keymap = utils.api.keymap

function M.setup()
  return {
    'mrcjkb/rustaceanvim',
    init = function()
      M.setup_rustacean() --
    end,
  }
end

function M.setup_rustacean()
  ---@see defaults https://github.com/mrcjkb/rustaceanvim/blob/master/lua/rustaceanvim/config/internal.lua

  vim.g.rustaceanvim = {
    tools = {
      hover_actions = { replace_builtin_hover = false },
    },
    server = {
      on_attach = function(client, bufnr)
        require('lsp').common_on_attach(client, bufnr) --

        keymap('n', '<leader>ff', ':RustFmt<CR>', { buffer = bufnr, desc = '[lsp] format' })
        keymap('n', '<leader>a', function() vim.cmd.RustLsp('codeAction') end, { buffer = bufnr })
      end,

      default_settings = {
        ['rust-analyzer'] = {},
      },
    },
    -- DAP configuration
    dap = {},
  }
end

return M
