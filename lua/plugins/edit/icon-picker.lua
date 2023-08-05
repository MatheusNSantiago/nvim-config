local M = {}

function M.setup()
  return {
    'ziontee113/icon-picker.nvim',
    cmd ="IconPickerNormal",
    config = M.config,
  }
end

function M.config()
  require('icon-picker').setup({
    disable_legacy_commands = true,
  })
end

return M
