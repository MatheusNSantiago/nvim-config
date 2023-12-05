local U = require('filetypes.cobol.utils')
local M = {}

function M.export_file()
  local lines = vim.fn.getline(1, '$')
  local marked_lines = Set() -- Linhas que serão descomentadas

  for i, line in ipairs(lines) do
    -- Se a linha estiver marcada, não faz nada
    if marked_lines:contains(i) then goto continue end

    line = M.replace_copy_with_inc(line)

    if M.is_commented_call_statement(line) then
      local statement_lines = M.commented_call_statement_lines({ idx = i, line = line })
      marked_lines:extend(statement_lines)
    end

    lines[i] = line
    ::continue::
  end

  -- Descomenta as linhas marcadas
  marked_lines:foreach(function(lnum)
    local line = lines[lnum]
    lines[lnum] = U.uncomment_line(line)
  end)

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

--  ╾───────────────────────────────────────────────────────────────────────────────────╼

function M.commented_call_statement_lines(opts)
  local line_idx, line = opts.idx, opts.line
  local lines = Set()


  while U.is_comment(line) do
    lines:push(line_idx)

    local is_end_of_statement = line:find('^%s+%*%s*[a-zA-Z0-9-]+%.')
    if is_end_of_statement then break end

    line_idx = line_idx + 1
    line = vim.fn.getline(line_idx)
  end

  return lines
end

M.is_commented_call_statement = function(line)
  local pattern = U.spaces(6) .. '%*' .. '%s*CALL'
  return line:find(pattern) ~= nil
end
M.replace_copy_with_inc = function(line)
  local pattern = U.spaces(7) .. 'COPY%s+([a-zA-Z0-9]+)%s*%.'
  return line:gsub(pattern, '-INC %1')
end

return M.export_file
