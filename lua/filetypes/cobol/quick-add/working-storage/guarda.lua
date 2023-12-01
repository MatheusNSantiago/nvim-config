local U = require('filetypes.cobol.quick-add.working-storage.utils')
local M = {}

---@param name? string: seta o nome (via quick-add)
function M.add_guarda(name)
  local first_empty_line_idx = U.get_last_line_for_category('GUARDAS')
  if not first_empty_line_idx then return end

  local name_was_already_set = name ~= nil

  U.use_get_data_description({
    defaults = {
      level = '77',
      name = name or 'GDA-',
      type = '',
      value = '',
    },
    is_final = { level = true, name = name_was_already_set, type = false, value = false },
    callback = function(data)
      local entry = M.make_entry(data)
      U.insert_lines(first_empty_line_idx, entry)
    end,
  })
end

function M.make_entry(data)
  local pic_col = 40
  local pic_def = string.format(
    '%s%s  %s%sPIC  %s%s.',
    string.rep(' ', 7),
    data.level,
    data.name,
    string.rep(' ', pic_col - 7 - 3 - #data.level - #data.name), -- Espaços pra fazer o alinhamento do PIC
    data.type,
    data.value ~= '' and (' VALUE ' .. data.value) or ''
  )
  return { pic_def }
end

return M.add_guarda
