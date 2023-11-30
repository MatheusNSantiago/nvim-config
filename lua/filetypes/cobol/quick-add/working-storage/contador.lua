local U = require('filetypes.cobol.quick-add.working-storage.utils')
local M = {}

---@param name? string: seta o nome (via quick-add)
function M.add_contador(name)
  local first_empty_line_idx = U.get_last_line_for_category('CONTADORES')
  if not first_empty_line_idx then return end

  local defaults = {
    level = '77',
    name = name or 'CNT-',
    type = '9(009)',
    value = 'ZEROS',
  }

  local name_was_already_set = name ~= nil
  if name_was_already_set then
    local entry = M.make_entry(defaults)
    return U.insert_lines(first_empty_line_idx, entry)
  end

  U.use_get_data_description({
    defaults = defaults,
    is_final = { level = true, name = false, type = true, value = true },
    callback = function(data)
      local entry = M.make_entry(data)
      U.insert_lines(first_empty_line_idx, entry)
    end,
  })
end

function M.make_entry(data)
  local pic_col = 40
  local pic_def = string.format(
    '%s%s  %s%sPIC  %s VALUE %s.',
    string.rep(' ', 7),
    data.level,
    data.name,
    string.rep(' ', pic_col - 7 - 3 - #data.level - #data.name), -- Espaços pra fazer o alinhamento do PIC
    data.type,
    data.value
  )
  return { pic_def }
end

return M.add_contador
