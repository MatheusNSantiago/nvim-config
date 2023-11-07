local U = require('filetypes.cobol.foo.ws_utils')

return function()
  local pattern = U.insert_after_every_char('INDICADORES', '%s*')
  local line_idx = U.get_first_empty_ws_line_after_pattern(pattern)

  U.use_get_data_description({
    defaults = {
      level = '77',
      name = 'IND-',
      type = '9(001)',
    },
    final = { level = true, name = false, type = true, value = true },
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

      local cnd_nao = add_cnd('NAO', '0')
      local cnd_sim = add_cnd('SIM', '1')

      vim.api.nvim_buf_set_lines(0, line_idx - 1, line_idx - 1, false, { indicador, cnd_nao, cnd_sim })
    end,
  })
end
