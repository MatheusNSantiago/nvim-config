local chunk = require('filetypes.cobol.chunk')
local comment_box = require('comment-box')
local indent = require('filetypes.cobol.indent')
local quick_add = require('filetypes.cobol.quick-add')
local code_runner = require('filetypes.cobol.code-runner')
local U = require('filetypes.cobol.utils')

return {
  mappings = {
    { 'n',          '<leader>a',  function() quick_add.quick_add_to_WS() end },
    { 'n',          '<leader>r',  function() code_runner.run() end },
    { 'n',          '<leader>cl', function() comment_box.line(5) end },
    { { 'n', 'v' }, '<leader>cb', function() comment_box.cbox() end },
    { 'i',          '<CR>',       function() indent.new_indentedline_below() end },
    { 'n',          'o',          function() indent.new_indentedline_below() end },
  },
  plugins = require('filetypes.cobol.plugins'),
  opt = {
    colorcolumn = '7,11,73,80',
    commentstring = '      *%s',
    iskeyword = '@,48-57,_,-',
  },
  commands = function()
    vim.cmd('silent! DisableHLIndent')

    utils.api.augroup('cobol', {
      desc = 'kill cobol_ls when exiting nvim',
      pattern = '*.cbl',
      event = 'VimLeavePre',
      command = 'silent !killall server-linux',
    }, {
      desc = 'mostrar aqueles indicadores iguais ao do HLChunk',
      event = { 'CursorMovedI', 'CursorMoved' },
      pattern = '*.cbl',
      command = utils.throttle(chunk.refresh, 70),
    }, {
      desc = 'Capitalizar código depois de salvar',
      event = 'BufWritePost',
      pattern = '*.cbl',
      command = function()
        local lines = vim.fn.getline(1, '$')
        local new_lines = {}
        for _, line in ipairs(lines) do
          local is_comment = U.is_comment(line)
          local is_copybook = line:match([[^%s*[cC][oO][pP][yY]%s+['"].+['"]%.]])

          local do_nothing = is_comment or is_copybook

          table.insert(new_lines, (do_nothing and line) or line:upper())
        end

        vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
      end,
    })
  end,
}
