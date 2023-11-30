local U = require('filetypes.cobol.quick-add.working-storage.utils')
local M = {}

---@param name? string: seta o nome (via quick-add)
function M.add_indicador(name)
  local first_empty_line_idx = U.get_last_line_for_category('INDICADORES')
  if not first_empty_line_idx then return end

  local name_was_already_set = name ~= nil

  U.use_get_data_description({
    defaults = {
      level = '77',
      name = name or 'IND-',
      type = '9(001)',
    },
    is_final = { level = true, name = name_was_already_set, type = true, value = true },
    callback = function(data)
      local entry = M.make_entry(data)
      U.insert_lines(first_empty_line_idx, entry)
    end,
  })
end

function M.make_entry(data)
  local pic_col = 40

  local indicador = string.format(
    '%s%s  %s%sPIC  %s.',
    U.spaces(7),
    data.level,
    data.name,
    U.spaces(pic_col - 7 - 3 - #data.level - #data.name),
    data.type
  )

  local add_cnd = function(condicao, valor)
    local cnd_name = data.name:gsub('IND%-', 'CND%-')
    return string.format(
      '%s88  %s-%s%sVALUE %s.',
      U.spaces(11),
      cnd_name,
      condicao,
      U.spaces(pic_col - 11 - 5 - (#cnd_name + 4)),
      valor
    )
  end

  return {
    indicador,
    add_cnd('NAO', '0'),
    add_cnd('SIM', '1'),
  }
end

return M.add_indicador
