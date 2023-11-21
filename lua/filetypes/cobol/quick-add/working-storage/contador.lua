local U = require('filetypes.cobol.quick-add.working-storage.utils')

local function make_entry(data)
  local pic_col = 40
  return string.format(
    '%s%s  %s%sPIC  %s VALUE %s.',
    string.rep(' ', 7),
    data.level,
    data.name,
    string.rep(' ', pic_col - 7 - 3 - #data.level - #data.name), -- Espaços pra fazer o alinhamento do PIC
    data.type,
    data.value
  )
end

---@param name? string: seta o nome (via quick-add)
return function(name)
  local first_empty_line_idx = U.get_last_line_for_category("CONTADORES")
  if not first_empty_line_idx then return end

  local defaults = {
    level = '77',
    name = name or 'CNT-',
    type = '9(009)',
    value = 'ZEROS',
  }

  local has_final_name = name ~= nil
  if has_final_name then
    U.insert_lines(first_empty_line_idx, { make_entry(defaults) })
    return
  end

  U.use_get_data_description({
    defaults = defaults,
    is_final = { level = true, name = false, type = true, value = true },
    callback = function(data) U.insert_lines(first_empty_line_idx, { make_entry(data) }) end,
  })
end
