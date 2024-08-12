local M = {}

function M.setup()
  return {
    'OXY2DEV/markview.nvim',
    lazy = false,
    config = M.config,
  }
end

function M.config()
  require('markview').setup({
    modes = { 'n', 'no', 'c' }, -- Change these modes
    -- to what you need

    hybrid_modes = { 'n' }, -- Uses this feature on
    -- normal mode

    -- This is nice to have
    callbacks = {
      on_enable = function(_, win)
        vim.wo[win].conceallevel = 2
        vim.wo[win].concealcursor = 'c'
      end,
    },
  })
end

return M
