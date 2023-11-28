local U = require('filetypes.cobol.utils')
local ts, fn = vim.treesitter, vim.fn
local M = {}

function M.main()
  local marked_lines = Array() -- Linhas que serão comentadas

  local lines = fn.getline(1, '$')
  for i, line in ipairs(lines) do
    -- Se a linha estiver marcada, não faz nada
    if marked_lines:contains(i) then goto continue end

    if M.line_has_copy_statement(line) then --
      line = M.replace_copy_with_inc(line)
    end

    if M.is_call_statement(line) then
      local row, col = i, M.call_statement_col(line)
      local start, end_ = M.call_statement_range(row, col)

      local lines_to_comment = fn.range(start, end_)
      marked_lines:extend(lines_to_comment)
    end

    lines[i] = line
    ::continue::
  end

  marked_lines:foreach(function(lnum) --
    lines[lnum] = M.comment_line(lines[lnum])
  end)

  fn.setreg('+', lines)
  print('Arquivo exportado para o clipboard')
end

M.is_call_statement = function(line) return line:find('^%s+CALL') ~= nil end
M.call_statement_col = function(line)
  local _, end_col = line:find('^%s+CALL')
  return end_col
end

M.line_has_copy_statement = function(line) return line:find(U.spaces(7) .. 'COPY%s+[a-zA-Z0-9]+%s*%.') ~= nil end
M.replace_copy_with_inc = function(line) return line:gsub(U.spaces(7) .. 'COPY%s+([a-zA-Z0-9]+)%s*%.', '-INC %1') end

M.call_statement_range = function(row, col)
  local pos = { row - 1, col - 1 }

  local node = ts.get_node({ pos = pos })
  assert(node ~= nil, ('node da call statement na posicao (%d, %d) não encontrado'):format(row, col))

  local s, _, e, _ = node:range()
  return s + 1, e + 1
end

function M.comment_line(line)
  if U.is_comment(line) then return line end
  local is_populated = #line > 6
  if is_populated then --
    return string.sub(line, 0, 6) .. '*' .. string.sub(line, 8, #line)
  end
  return line .. U.spaces(6 - #line) .. '*'
end

return M.main
