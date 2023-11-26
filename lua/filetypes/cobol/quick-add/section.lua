local Input = require('filetypes.cobol.quick-add.input')
local M = {}

function M.add_section()
  local line_number = vim.fn.line('.')
  local bufnr = vim.api.nvim_get_current_buf()

  Input({
    auto_mount = true,
    on_submit = function(header)
      header = header:upper()

      local header_number = header:match('^(%d+)-') or ''
      local header_number_99 = header_number:gsub('%d%d$', '99')

      local template = {
        '*',
        '*---------------------------------------*',
        header,
        '*---------------------------------------*',
        '*',
        ' ',
        '*',
        ' ' .. header_number_99 .. '-SAI.',
        '     EXIT.',
      }

      local full_len = template[2]:len()

      M.add_left_pad(template)

      local section = 'SECTION.'
      local middle_pad = full_len - #header - #section
      template[3] = ' ' .. template[3] .. string.rep(' ', middle_pad - 1) .. section

      vim.api.nvim_buf_set_lines(bufnr, line_number - 1, line_number, false, template)

      -- coloca o cursor no meio da seção
      vim.api.nvim_win_set_cursor(0, { line_number + 5, 8 })
    end,
  })
end

--- adiconar padding até a seção A
function M.add_left_pad(lines)
  for i, text in ipairs(lines) do
    lines[i] = string.rep(' ', 6) .. text
  end
end

return M
