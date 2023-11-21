local Input = require('filetypes.cobol.quick-add.input')
local cobol_utils = require('filetypes.cobol.utils')
local ts = vim.treesitter
local M = {}

---@alias  WSCategories "GUARDAS" | "CONTADORES" | "INDICADORES"
---@param category WSCategories
function M.get_last_line_for_category(category)
  local pattern = M.insert_after_every_char(category, '%s*')
  local ws_start, ws_end = M.get_working_storage_range()
  if not ws_start or not ws_end then return end

  local cursor_line
  for i = ws_start, ws_end do
    local line = vim.fn.getline(i)

    local is_category_heading = line:find(pattern)
    if is_category_heading then cursor_line = i end
  end

  -- coloca cursor na primeira linha após a heading da categoria
  cursor_line = cursor_line + 2

  while cursor_line <= ws_end do
    local line = vim.fn.getline(cursor_line)

    local is_empty = line == ''
    if is_empty then return cursor_line end

    local is_commented = cobol_utils.is_comment(line)
    if is_commented then
      local next_line = vim.fn.getline(cursor_line + 1)

      local is_next_line_commented = cobol_utils.is_comment(next_line)
      if is_next_line_commented then return cursor_line end
    end

    cursor_line = cursor_line + 1
  end

  print('Não foi possível encontrar uma linha disponível')
end

function M.get_working_storage_range()
  local node = ts.get_node()
  if not node then return end
  local root = node:tree():root()

  -- go to data_division
  local data_div_node = M.get_child(root, 'data_division')
  if not data_div_node then return end

  -- go to working_storage_section
  local ws_sec_node = M.get_child(data_div_node, 'working_storage_section')
  if not ws_sec_node then return end

  local ws_start, _, ws_end, _ = ws_sec_node:range()
  return ws_start, ws_end
end

---@param node TSNode
function M.get_child(node, type)
  local children = node:named_children()
  for _, child in ipairs(children) do
    if child:type() == type then return child end
  end
end

---@class DataDescription
---@field level string | nil
---@field name string | nil
---@field type string | nil
---@field value string | nil

---@class UseGetDataDescOpts
---@field callback fun(data: DataDescription)
---@field defaults? DataDescription
---@field is_final? {level: boolean, name: boolean, type: boolean, value: boolean}

---@param opts UseGetDataDescOpts
function M.use_get_data_description(opts)
  local d = opts.defaults or {}

  local data = {
    level = d.level,
    name = d.value,
    type = d.type,
    value = d.value,
  }

  local get_next_not_final_field = function(current_field)
    local fields = { 'level', 'name', 'type', 'value' }
    local current_idx = 0
    for i, field in ipairs(fields) do
      if field == current_field then current_idx = i end
    end
    if current_idx == #fields then return end
    return fields[current_idx + 1]
  end

  local input = {}

  local function create_input_factory(_opts)
    return function()
      local field = _opts.field

      local mount_next_field = function()
        local next_field = get_next_not_final_field(field)
        if next_field then
          local next_input = input[next_field]
          local _input = next_input()
          if _input then _input:mount() end
        end
      end

      local is_final_field = opts.is_final[field] == true
      if is_final_field then
        data[field] = d[field]
        if field == 'value' and _opts.callback then _opts.callback(data) end
        return mount_next_field()
      end

      return Input({
        title = _opts.title,
        default_value = _opts.default_value,
        auto_mount = field == 'level',
        on_submit = function(value)
          data[field] = value:upper()
          mount_next_field()
          if _opts.callback then _opts.callback(data) end
        end,
      })
    end
  end

  input.value = create_input_factory({
    field = 'value',
    title = 'Valor',
    default_value = d.value,
    callback = opts.callback,
  })

  input.type = create_input_factory({
    field = 'type',
    title = 'Type',
    default_value = d.type,
  })

  input.name = create_input_factory({
    field = 'name',
    title = 'Nome',
    default_value = d.name,
  })

  input.level = create_input_factory({
    field = 'level',
    title = 'Nível',
    default_value = d.level,
  })

  input.level()
end

function M.insert_after_every_char(str, insert)
  local result = ''
  for i = 1, #str do
    result = result .. str:sub(i, i) .. insert
  end
  return result
end

function M.spaces(n) return string.rep(' ', n) end

--- Inserts lines into the current buffer at a specified line index.
--- @param line_idx number: The index of the line where the new lines should be inserted.
--- @param lines table: A table of strings, each representing a line to be inserted.
function M.insert_lines(line_idx, lines)
  vim.api.nvim_buf_set_lines(0, line_idx - 1, line_idx - 1, false, lines) --
end

return M
