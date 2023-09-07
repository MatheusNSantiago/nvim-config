local M = {}

function M.setup()
  return {
    'VidocqH/lsp-lens.nvim',
    event = 'LspAttach',
    config = M.config,
  }
end

function M.config()
  require('lsp-lens').setup({
    enable = true,
    include_declaration = false, -- Reference include declaration
    sections = {               -- Enable / Disable specific request
      definition = false,
      references = true,
      implements = true,
    },
    ignore_filetype = {},
  })
end

return M
