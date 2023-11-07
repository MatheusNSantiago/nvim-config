local cobol_ls = require('lsp.servers.cobol_ls')
local chunk = require('filetypes.cobol.chunk')

return function()
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
    command = utils.throttle(function()
      chunk.clear()
      chunk.render()
    end, 70),
  })

  vim.lsp.start(cobol_ls)
end
