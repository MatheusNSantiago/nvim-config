local cmd = { 'node', '/home/matheus/dev/cobol/plugins/cobol-lsp/out/index.js', '--stdio' }

local client_id = vim.lsp.start_client({
  cmd = cmd,
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = function(_, buf)
    utils.api.keymap('n', 'K', ':Lspsaga hover_doc<CR>')
    utils.api.keymap('n', '<leader>ca', ':Lspsaga code_action<CR>')
    utils.api.keymap('n', 'gd', ':Lspsaga goto_definition<CR>')

    utils.api.keymap('n', '<leader>a', function()
      local line = vim.fn.line('.') - 1
      local diagnostics = vim.lsp.diagnostic.get_line_diagnostics(buf, line)

      log(diagnostics)
    end)
  end,
})
if not client_id then return end

vim.lsp.buf_attach_client(0, client_id)
