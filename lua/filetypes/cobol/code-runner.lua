local M = {}

local find_copybook_dir = function()
  local file_path = vim.fn.expand('%:p')
  local parent_dir = vim.fn.fnamemodify(file_path, ':h')
  local copybook_dir = vim.fn.glob(parent_dir .. '/**/copy-books')

  return copybook_dir
end

M.run = function()
  local copybook_dir = find_copybook_dir() or ''

  local file_path = vim.fn.expand('%:p')
  local COMPILE = ("cobc -I %s -xO %s"):format(copybook_dir, file_path)

  local filename_without_extension = vim.fn.expand('%:t:r')
  local RUN = './' .. filename_without_extension
  local REMOVE = 'rm ' .. filename_without_extension

  local final_cmd = COMPILE .. ' && ' .. RUN .. ' && ' .. REMOVE
  vim.cmd('w')
  vim.cmd(("TermExec cmd='%s'"):format(final_cmd))
end

return M
