local M = {}

function M.setup()
  return {
    'jose-elias-alvarez/typescript.nvim',
    ft = { 'ts', 'js', 'typescript', 'javascript', 'tsx', 'jsx', 'typescriptreact', 'javascriptreact' },
    config = M.config,
  }
end

function M.config()
  require('typescript').setup({
    disable_commands = false,                    -- prevent the plugin from creating Vim commands
    debug = false,                               -- enable debug logging for commands
    go_to_source_definition = { fallback = true }, -- fall back to standard LSP definition on failure
    server = require('lsp').get_configs_for('tsserver'),
  })
end

return M
