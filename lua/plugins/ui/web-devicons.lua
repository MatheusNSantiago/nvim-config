local M = {}

function M.setup()
  return {
    "nvim-tree/nvim-web-devicons",
    config = M.config
  }
end

function M.config()
  require("nvim-web-devicons").setup({
    -- your personnal icons can go here (to override)
    -- DevIcon will be appended to `name`
    override = {},
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true,
  })
end

return M
