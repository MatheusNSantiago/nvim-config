local M = {}

function M.setup()
  return {
    'nvim-java/nvim-java',
    ft = { 'java' },
    dependencies = {
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
