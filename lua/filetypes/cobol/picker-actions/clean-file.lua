local U = require('filetypes.cobol.utils')
local M = {}

function M.clean_file()
  local lines = vim.fn.getline(1, '$')
  local marked_list = Set() -- Linhas que serão comentadas

  for i, line in ipairs(lines) do
    if marked_list:contains(i) then goto continue end

    line = M.replace_inc_with_copy(line)
    line = M.remove_leading_columns(line)
    line = M.remove_excess_columns(line)

    if M.is_call_statement(line) then
      local statement_lines = M.call_statement_lines({ idx = i, line = line })
      marked_list:extend(statement_lines)
    end
    lines[i] = line
    ::continue::
  end

  -- Comenta as linhas marcadas
  marked_list:foreach(function(lnum) --
    lines[lnum] = U.comment_line(lines[lnum])
  end)

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

-- ╾───────────────────────────────────────────────────────────────────────────────────╼

function M.call_statement_lines(opts)
  local line_idx, line = opts.idx, opts.line
  local row, col = line_idx, M.call_statement_col(line)
  local start, end_ = M.call_statement_range(row, col)
  return vim.fn.range(start, end_)
end

function M.replace_inc_with_copy(line) return line:gsub('^%s*%-INC%s+([a-zA-Z0-9]+)%s*$', U.spaces(7) .. 'COPY %1.') end

function M.remove_leading_columns(line) return line:gsub('^' .. U.rep('.', 6), U.spaces(6)) end

function M.remove_excess_columns(line)
  if U.is_comment(line) then return line end
  return line:gsub('^(' .. U.rep('.', 72) .. ').*$', '%1')
end

function M.is_call_statement(line) return line:find('^%s+CALL') ~= nil end

M.call_statement_col = function(line)
  local _, end_col = line:find('^%s+CALL')
  return end_col
end

M.call_statement_range = function(row, col)
  local pos = { row - 1, col - 1 }

  local node = vim.treesitter.get_node({ pos = pos })
  assert(node ~= nil, ('node da call statement na posicao (%d, %d) não encontrado'):format(row, col))

  local s, _, e, _ = node:range()
  return s + 1, e + 1
end

return M.clean_file
