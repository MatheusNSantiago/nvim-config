local M = {}

function M.setup()
  return {
    'Jorengarenar/COBOL.vim',
    config = M.config,
  }
end

function M.config()
  vim.g.cobol_colorcolumns = 1
  vim.g.cobol_folding = 1
  vim.g.cobol_autoupper = 1
  vim.g.cobol_indent_data_items = 1
end

return M
