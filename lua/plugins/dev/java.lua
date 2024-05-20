local M = {}

function M.setup()
  return {
    'nvim-java/nvim-java',
    ft = { 'java' },
    enabled = not utils.is_os_running_on_wsl(),
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

return M
