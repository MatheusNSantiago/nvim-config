local U = require('filetypes.cobol.quick-add.working-storage.utils')

---@param name? string: seta o nome (via quick-add)
return function(name)
  local first_empty_line_idx = U.get_last_line_for_categorie("GUARDAS")
  if not first_empty_line_idx then return end

  local has_final_name = name ~= nil

  U.use_get_data_description({
    defaults = {
      level = '77',
      name = name or 'GDA-',
      type = '',
      value = '',
    },
    is_final = { level = true, name = has_final_name, type = false, value = false },
    callback = function(data)
      local pic_col = 40
      local entry = string.format(
        '%s%s  %s%sPIC  %s VALUE %s.',
        string.rep(' ', 7),
        data.level,
        data.name,
        string.rep(' ', pic_col - 7 - 3 - #data.level - #data.name), -- Espaços pra fazer o alinhamento do PIC
        data.type,
        data.value
      )

      U.insert_lines(first_empty_line_idx, { entry })
    end,
  })
end
