local U = require('filetypes.cobol.quick-add.working-storage.utils')
local M = {}

---@param name string: seta o nome
function M.add_programa(name)
  local first_empty_line_idx = U.get_last_line_for_category('PROGRAMAS')
  if not first_empty_line_idx then return end

  U.use_get_data_description({
    defaults = {
      level = '77',
      name = name,
      type = ('X(%03d)'):format(#name),
      value = name,
    },
    is_final = { level = true, name = true, type = true, value = true },
    callback = function(data)
      local entry = M.make_entry(data)
      U.insert_lines(first_empty_line_idx, entry)
    end,
  })
end

function M.make_entry(data)
  local pic_col = 40
  local pic_def = string.format(
    "%s%s  %s%sPIC  %s VALUE '%s'.",
    U.spaces(7),
    data.level,
    data.name,
    U.spaces(pic_col - 7 - 2 - #data.level - #data.name), -- Espaços pra fazer o alinhamento do PIC
    data.type,
    data.value
  )
  return { pic_def }
end

return M.add_programa
