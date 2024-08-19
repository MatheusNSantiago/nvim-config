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
    modes = { 'n', 'i', 'no', 'c' },
    hybrid_modes = { 'i' },
    list_items = {
      enable = true,
      shift_width = 2,
      indent_size = 2,

      marker_minus = {},
      marker_plus = {},
      marker_star = {},
      marker_dot = {},
    },
    -- This is nice to have
    callbacks = {
      on_enable = function(_, win)
        vim.wo[win].conceallevel = 2
        vim.wo[win].concealcursor = 'nc'
      end,
    },
  })
end

return M
