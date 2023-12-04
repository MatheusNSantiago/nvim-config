local fn = vim.fn
local ts = vim.treesitter
local U = require('filetypes.cobol.utils')
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
  vim.defer_fn(function()
    local line = fn.getline('.')
    local line_number = fn.line('.')
    local col = fn.col('.')

    local indented_line = string.rep(' ', size) .. line

    fn.setline(line_number, indented_line)
    fn.cursor({ line_number, col + size })
  end, 20)
end

local function is_first_relevant_line_after(lnum, pattern)
  local max_lines_above = 5
  for i = 0, max_lines_above + 1, 1 do
    local line = fn.getline(lnum - i)

    local is_division = line:match(pattern)
    local is_blank = #line == 0

    local is_relevant_line = not (U.is_comment(line) or is_blank or is_division)
    if is_relevant_line then return false end
    if is_division then return true end
  end

  return false
end

local function insert_line_below()
  if fn.mode() == 'i' then
    utils.api.feedkeys('<CR>')
    return
  end
  utils.api.feedkeys('o')
end

function M.new_indentedline_below()
  local ok, is_cursor_in_proc_div = pcall(is_cursor_on_division, 'procedure')
  if not ok then return insert_line_below() end

  local lnum, line = fn.line('.'), fn.getline('.')
  local line_is_comment = U.is_comment(line)

  insert_line_below()

  if is_cursor_in_proc_div then
    -- relevante = não é comentário, não é divisão, não é linha em branco
    local is_first_relevant_line_after_section = is_first_relevant_line_after(lnum, 'SECTION%.%s*$')
    if is_first_relevant_line_after_section then
      -- Por algum motivo, quando tem um comentário, o tamanho do indent diminui
      if line_is_comment then
        return indent(5)
      end

      return indent(4)
    end

    local is_first_relevant_line_after_division = is_first_relevant_line_after(lnum, 'DIVISION%.%s*$')
    local is_before_sec_a = fn.col('.') < 7
    if is_first_relevant_line_after_division and is_before_sec_a then return end
  end
  --
  -- local is_root_of_group = line:match('^%s+01 .+%.$')
  -- if is_root_of_group then return indent(4) end
  --
  -- -- o indent padrão identa na msm coluna do inicio do comentário, queremos que ele começe
  -- -- na primeira coluna válida
  -- if line_is_comment then return indent(1) end
end

return M
