local M = {}

function M.setup()
  return { ---@type LazyPluginSpec
    dir = '~/dev/nvim-cobol',
    config = M.config,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'gbprod/stay-in-place.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
      'LudoPinelli/comment-box.nvim',
    },
    build = function() require('nvim-cobol').install_treesitter_parser({ sync = true }) end,
  }
end

function M.config()
  require('nvim-cobol').setup({
    kdz = {
      wsl_path = '/tmp/temp/zOSsrc',
      windows_path = '/mnt/c/Users/F7023235/ws_kdz170/#sigla-mainframe-ORIGINAL170/zOSsrc',
    },
    features = {
      outline = {
        enabled = true,
        keymaps = {
          open = '<leader>oo',
          search = '<leader>ss',
        },
      },
      search_section = { enabled = true, keymaps = { open = '<leader>ss' } },
      hover = {
        enabled = true,
        keymaps = { open = 'K' },
      },
      rename = {
        enabled = true,
        keymaps = { open = 'gr' },
      },
      quick_add = {
        enabled = true,
        keymaps = {
          section = '<leader>as',
          picture = '<leader>ap',
        },
      },
      refactor_section = {
        enabled = true,
        keymaps = { extract = 'rs' },
      },
      comment_tools = {
        enabled = true,
        keymaps = {
          separator = '<leader>cl',
          large_separator = '<leader>cL',
          box = '<leader>cb',
        },
      },
      utilities = { enabled = true, keymaps = { open = '<leader><leader>o' } },
      virtcolumn = { enabled = true },
      local_run = { enabled = true, keymaps = { run = '<leader>r' } },
    },
  })
end

return M
