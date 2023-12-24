local cmd = { 'node', '/home/matheus/dev/cobol/plugins/cobol-lsp/out/index.js', '--stdio' }

local client_id = vim.lsp.start_client({
  cmd = cmd,
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = function () end
})
if not client_id then return end

vim.lsp.buf_attach_client(0, client_id)

