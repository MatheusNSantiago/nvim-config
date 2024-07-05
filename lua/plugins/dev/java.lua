local M = {}

function M.setup()
  return {
    'nvim-java/nvim-java',
    config = M.config,
    ft = { 'java' },
    enabled = not utils.is_wsl(),
    dependencies = {
      'nvim-java/nvim-java-refactor',
      'nvim-java/lua-async-await',
      'nvim-java/nvim-java-core',
      'nvim-java/nvim-java-test',
      'nvim-java/nvim-java-dap',
      'mfussenegger/nvim-dap',
      'MunifTanjim/nui.nvim',
      'neovim/nvim-lspconfig',
    },
  }
end

function M.config()
  require('java').setup({
    java_test = { enable = true },
    java_debug_adapter = { enable = false },
    jdk = { auto_install = true },
    notifications = { dap = false },
  })
end

return M
