local U = require('filetypes.cobol.foo.ws_utils')

return function()
  local pattern = U.insert_after_every_char('CONTADORES', '%s*')
  local line_idx = U.get_first_empty_ws_line_after_pattern(pattern)

  U.use_get_data_description({
    defaults = {
      level = '77',
      name = 'CNT-',
      type = '9(009)',
      value = 'ZEROS',
    },
    final = { level = true, name = false, type = true, value = true },
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
      -- add a linha + 1 espaço em branco para a próxima entrada
      vim.api.nvim_buf_set_lines(0, line_idx - 1, line_idx - 1, false, { entry })
    end,
  })
end
