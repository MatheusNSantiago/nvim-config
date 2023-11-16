local U = require('filetypes.cobol.quick-add.working-storage.utils')

---@param name? string: seta o nome (via quick-add)
return function(name)
  local first_empty_line_idx = U.get_last_line_for_categorie("INDICADORES")
  if not first_empty_line_idx then return end

  local has_final_name = name ~= nil

  U.use_get_data_description({
    defaults = {
      level = '77',
      name = name or 'IND-',
      type = '9(001)',
    },
    is_final = { level = true, name = has_final_name, type = true, value = true },
    callback = function(data)
      local pic_col = 40

      local indicador = string.format(
        '%s%s  %s%sPIC  %s.',
        U.spaces(7),
        data.level,
        data.name,
        U.spaces(pic_col - 7 - 3 - #data.level - #data.name),
        data.type --
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

      U.insert_lines(first_empty_line_idx, {
        indicador,
        add_cnd('NAO', '0'),
        add_cnd('SIM', '1'),
      })
    end,
  })
end
