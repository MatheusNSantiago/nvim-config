local M = {}

local function get_copybook_dir()
  local path = vim.fn.expand('%:p')
  while path ~= '/' do
    local parent_dir_path = vim.fn.fnamemodify(path, ':h')
    local parent_dir_files = Array(vim.fn.readdir(parent_dir_path))

    if parent_dir_files:contains('copybook') then --
      return parent_dir_path .. '/copybook'
    end

    path = parent_dir_path
  end

  return path
end

M.run = function()
  local copybook_dir = get_copybook_dir() or ''

  local file_path = vim.fn.expand('%:p')
  local COMPILE = ("cobc -I %s -xO %s && clear"):format(copybook_dir, file_path)

  local filename_without_extension = vim.fn.expand('%:t:r')
  local RUN = './' .. filename_without_extension
  local REMOVE = 'rm ' .. filename_without_extension

  local final_cmd = COMPILE .. ' && ' .. RUN .. ' && ' .. REMOVE
  vim.cmd('w')
  vim.cmd(("TermExec cmd='%s'"):format(final_cmd))
end

return M
