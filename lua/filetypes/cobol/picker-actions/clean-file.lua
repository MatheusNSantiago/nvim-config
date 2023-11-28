local U = require('filetypes.cobol.utils')
local M = {}

function M.main()
  local lines = vim.fn.getline(1, '$')

  for i, line in ipairs(lines) do
    lines[i] = M.clean_line(line)
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

-- ╾───────────────────────────────────────────────────────────────────────────────────╼

function M.clean_line(line)
  line = M.replace_inc_with_copy(line)
  line = M.remove_leading_columns(line)
  line = M.remove_excess_columns(line)
  return line
end

function M.replace_inc_with_copy(line) return line:gsub('^%s*%-INC%s+([a-zA-Z0-9]+)%s*$', U.spaces(7) .. 'COPY %1.') end

function M.remove_leading_columns(line) return line:gsub('^' .. U.rep('.', 6), U.spaces(6)) end

function M.remove_excess_columns(line)
  if U.is_comment(line) then return line end
  return line:gsub('^(' .. U.rep('.', 72) .. ').*$', '%1')
end

return M.main
