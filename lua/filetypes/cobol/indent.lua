local fn = vim.fn
local ts = vim.treesitter
local M = {}

---@return TSNode[]
local function get_children_matching_pattern(node, pattern)
  local children = node:named_children()
  local matches = {}

  for _, child in ipairs(children) do
    local child_type = child:type()
    if child_type:match(pattern) then table.insert(matches, child) end
  end

  return matches
end

local function get_root()
  local node = ts.get_node()
  assert(node, 'Treesitter node not found')
  return node:tree():root()
end

---@return TSNode[]
local function get_divisions()
  local root = get_root()

  local divisions = get_children_matching_pattern(root, '_division')
  assert(#divisions > 0, 'No divisions found')

  return divisions
end

local function is_cursor_on_node(node)
  local node_start, _, node_end, _ = node:range()
  local cursor_line = fn.line('.') - 1

  return (cursor_line >= node_start) and (cursor_line <= node_end)
end

---@param division 'identification'|'environment'|'data'|'procedure'
local function is_cursor_on_division(division)
  division = division .. '_division'

  local divisions = get_divisions()
  for _, div in ipairs(divisions) do
    if div:type() == division then
      return is_cursor_on_node(div) --
    end
  end
end

local function indent(size)
  vim.schedule(function()
    local line = fn.getline('.')
    local line_number = fn.line('.')
    local col = fn.col('.')

    local indented_line = string.rep(' ', size) .. line

    fn.setline(line_number, indented_line)
    fn.cursor({ line_number, col + size })
  end)
end

local function is_comment(line) return line:match('^      %*') end

local function is_first_relevant_line_after(lnum, pattern)
  local max_lines_above = 5
  for i = 0, max_lines_above + 1, 1 do
    local line = fn.getline(lnum - i)

    local is_division = line:match(pattern)
    local is_blank = #line == 0

    local is_relevant_line = not (is_comment(line) or is_blank or is_division)
    if is_relevant_line then return false end
    if is_division then return true end
  end

  return false
end

local function insert_line_below()
  local mode = vim.fn.mode()
  if mode == 'i' then
    vim.cmd('stopinsert')
    vim.api.nvim_feedkeys('o', 'n', true)
    vim.cmd('startinsert')
  else
    vim.api.nvim_feedkeys('o', 'n', true)
  end
end

function M.new_indentedline_below()
  local is_cursor_in_proc_div = is_cursor_on_division('procedure')
  local lnum = fn.line('.')
  local line = fn.getline(lnum)
  local line_is_comment = is_comment(line)

  insert_line_below()

  if is_cursor_in_proc_div then
    local is_first_relevant_line_after_section = is_first_relevant_line_after(lnum, 'SECTION%.%s*$')

    if is_first_relevant_line_after_section then
      -- Por algum motivo, quando tem um comentário, o tamanho do indent diminui
      if line_is_comment then return indent(5) end

      return indent(4)
    end

    local is_first_relevant_line_after_division = is_first_relevant_line_after(lnum, 'DIVISION%.%s*$')
    local is_before_sec_a = fn.col('.') < 7
    if is_first_relevant_line_after_division and is_before_sec_a then return end
  end

  local is_root_of_group = line:match('^%s+01 .+%.$')
  if is_root_of_group then return indent(4) end
  -- o indent padrão identa na msm coluna do inicio do comentário, queremos que ele começe
  -- na primeira coluna válida
  if line_is_comment then return indent(1) end
end

return M

--  ╾───────────────────────────────────────────────────────────────────────────────────╼
-- local lsp = require('filetypes.cobol.lsp')
--
-- local M = {
--   current_line = '',
--   current_line_raw = '',
-- }
-- M.indent = function()
--   M.current_line_raw = vim.fn.getline('.')
--   M.current_line = M.get_current_line()
--
--   M.add_new_line()
--
--   lsp.tree_provider(function(tree)
--     local is_cursor_in_procedure_division = M.is_cursor_in_node('PROCEDURE DIVISION', tree)
--     local has_7_spaces_before_char = M.blanklines_util_char() == 7
--
--
--     if is_cursor_in_procedure_division and has_7_spaces_before_char then
--       return M.add_indentation(4)
--     end
--
--     if M.is_division() then return M.add_indentation(1) end
--     if M.is_section() then M.add_indentation(2) end
--     if M.is_root_of_group() then M.add_indentation(3) end
--   end)
-- end
--
-- M._end_of_line = '%s*█%s*$'
-- M.is_division = function() return M._line_matches({ 'DIVISION%.' .. M._end_of_line }) end
-- M.is_section = function() return M._line_matches({ 'SECTION%.' .. M._end_of_line }) end
-- M.is_root_of_group = function() return M._line_matches({ '01 .+%.' .. M._end_of_line }) end
--
-- M.is_cursor_in_node = function(node_name, tree)
--   local node = lsp.search_node(node_name, tree)
--   if node == nil then return false end
--   local cursor_pos = vim.fn.line('.')
--
--   local node_start, node_end = node.range.start, node.range.finish
--
--   if (cursor_pos <= node_end) and (cursor_pos >= node_start) then return true end
--   return false
-- end
--
-- function M.blanklines_util_char()
--   local line = M.current_line_raw
--   local line_with_no_leading_spaces = line:gsub('^%s+', '')
--
--   return #line - #line_with_no_leading_spaces
-- end
--
-- function M.get_current_line()
--   local current_line = vim.fn.getline('.')
--   local col = vim.fn.col('.')
--   current_line = (current_line:sub(1, col) .. '█' .. current_line:sub(col + 1)):upper()
--
--   return current_line
-- end
--
-- function M._line_matches(patterns)
--   for _, pattern in ipairs(patterns) do
--     if M.current_line:match(pattern) then return true end
--   end
--   return false
-- end
--
-- M.add_new_line = function()
--   local new_line = vim.api.nvim_replace_termcodes('<C-CR>', true, false, true)
--   vim.api.nvim_feedkeys(new_line, 'i', true)
-- end
--
-- M.add_indentation = function(size)
--   vim.schedule(function()
--     local line = vim.fn.getline('.')
--     local line_number = vim.fn.line('.')
--     local col = vim.fn.col('.')
--
--     vim.fn.setline(line_number, line:sub(0, col - 1) .. string.rep(' ', size) .. line:sub(col, #line))
--     vim.fn.cursor({ line_number, col + size })
--   end)
-- end

-- return M.indent
