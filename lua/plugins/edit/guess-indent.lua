local M = {}

function M.setup()
  return {
    'nmac427/guess-indent.nvim',
    config = M.config,
  }
end

function M.config()
  require('guess-indent').setup({
    auto_cmd = true,             -- Set to false to disable automatic execution
    override_editorconfig = false, -- Set to true to override settings set by .editorconfig
    filetype_exclude = {         -- A list of filetypes for which the auto command gets disabled
      'cobol',
      'copybook',
      'netrw',
      'tutor',
    },
    buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
      'help',
      'nofile',
      'terminal',
      'prompt',
    },
  })
end

return M
