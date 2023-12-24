local M = {}

M.statement_pairs = {
  { 'IF',      'END-IF' },
  { 'PERFORM', 'END-PERFORM' },
}

local indent = function() require('filetypes.cobol.indent').indent(4, 40) end

function M.complete()
  local linenr = vim.fn.line('.')
  local line = vim.fn.getline(linenr)

  local start_statement, end_statement = M.get_current_statement(line)
  if not start_statement then return end

  local n_spaces = assert(line:find(start_statement)) - 1
  if not M.is_necessary(end_statement, n_spaces) then return indent() end

  local should_be_dotted = n_spaces == 11
  end_statement = string.rep(' ', n_spaces) .. end_statement .. (should_be_dotted and '.' or '')

  vim.api.nvim_buf_set_lines(0, linenr, linenr, false, { end_statement })
  indent()
end

---Se já tiver um complemento do statement em baixo, não precisa de outro.
---Ele olha até [max_lines_below] linhas abaixo no mesmo nível de indentação em busca do complemento.
function M.is_necessary(end_statement, spaces)
  end_statement = end_statement:gsub('%-', '%%-')
  local linenr = vim.fn.line('.')
  local pattern = '^' .. string.rep('.', spaces) .. end_statement

  local max_lines_below = 10
  for i = 1, max_lines_below, 1 do
    local line_below = vim.fn.getline(linenr + i)

    local has_end_statement = line_below:match(pattern)
    if has_end_statement then return false end
  end

  return true
end

function M.get_current_statement(line)
  for _, pair in ipairs(M.statement_pairs) do
    local start_statement, end_statement = pair[1], pair[2]
    if line:match(start_statement) then return start_statement, end_statement end
  end
end

return M
