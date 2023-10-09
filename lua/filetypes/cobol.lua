return {
  commands = function()
    vim.cmd('silent DisableHLIndent')


    local client_id = vim.lsp.start_client({
      name = "cobol_ls",
      cmd = vim.lsp.rpc.connect('127.0.0.1', 1044)
    })

    if not client_id then return end
    vim.lsp.buf_attach_client(0, client_id)
  end,
  mappings = {
    {
      'n',
      '<leader>r',
      function()
        local file_path = vim.fn.expand('%:p')
        local filename_without_extension = vim.fn.expand('%:t:r')

        local cmd_compile = 'cobc -xO ' .. '"' .. file_path .. '"'
        local cmd_run = './' .. filename_without_extension
        local cmd_remove_exec = 'rm ' .. filename_without_extension

        local cmd = cmd_compile .. ' && ' .. cmd_run .. ' && ' .. cmd_remove_exec

        vim.cmd('w')
        vim.cmd(("TermExec cmd='%s'"):format(cmd))
        vim.schedule(function() vim.cmd('wincmd j') end) -- Go to bottom terminal
      end,
    },
  },
}
