return function()
  vim.cmd('silent! DisableHLIndent')

  utils.api.augroup('cobol', {
    event = 'VimLeavePre',
    desc = 'kill cobol_ls when exiting nvim',
    command = 'silent !killall server-linux',
  })
end
