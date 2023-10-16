local lsp = require('filetypes.cobol.lsp')

local M = {
  current_line = '',
  current_line_raw = '',
}

M.indent = function()
  M.current_line_raw = vim.fn.getline('.')
  M.current_line = M.get_current_line()

  M.add_new_line()

  -- Add the correct indentation
  lsp.tree_wrapper(function(tree)
    local is_cursor_in_procedure_division = M.is_cursor_in_node('PROCEDURE DIVISION', tree)
    local has_7_spaces_before_char = M.blanklines_util_char() == 7


    if is_cursor_in_procedure_division and has_7_spaces_before_char then
      return M.add_indentation(4)
    end

    if M.is_division() then return M.add_indentation(1) end
    if M.is_section() then M.add_indentation(2) end
    if M.is_root_of_group() then M.add_indentation(3) end
  end)
end

M._end_of_line = '%s*█%s*$'
M.is_division = function() return M._line_matches({ 'DIVISION%.' .. M._end_of_line }) end
M.is_section = function() return M._line_matches({ 'SECTION%.' .. M._end_of_line }) end
M.is_root_of_group = function() return M._line_matches({ '01 .+%.' .. M._end_of_line }) end

M.is_cursor_in_node = function(node_name, tree)
  local node = lsp.search_node(node_name, tree)
  if node == nil then return false end
  local cursor_pos = vim.fn.line('.')

  local node_start, node_end = node.range.start, node.range.finish

  if (cursor_pos <= node_end) and (cursor_pos >= node_start) then return true end
  return false
end

function M.blanklines_util_char()
  local line = M.current_line_raw
  local line_with_no_leading_spaces = line:gsub('^%s+', '')

  return #line - #line_with_no_leading_spaces
end

function M.get_current_line()
  local current_line = vim.fn.getline('.')
  local col = vim.fn.col('.')
  current_line = (current_line:sub(1, col) .. '█' .. current_line:sub(col + 1)):upper()

  return current_line
end

function M._line_matches(patterns)
  for _, pattern in ipairs(patterns) do
    if M.current_line:match(pattern) then return true end
  end
  return false
end

M.add_new_line = function()
  local new_line = vim.api.nvim_replace_termcodes('<C-CR>', true, false, true)
  vim.api.nvim_feedkeys(new_line, 'i', true)
end

M.add_indentation = function(size)
  vim.schedule(function()
    local line = vim.fn.getline('.')
    local line_number = vim.fn.line('.')
    local col = vim.fn.col('.')

    vim.fn.setline(line_number, line:sub(0, col - 1) .. string.rep(' ', size) .. line:sub(col, #line))
    vim.fn.cursor({ line_number, col + size })
  end)
end

return M.indent
