local M = {}

function M.setup()
  return {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = M.config,
  }
end

function M.config()
  require('hlchunk').setup({
    chunk = {
      enable = true,
      style = { { fg = '#806d9c' }, { fg = '#c21f30' } }, -- style = { { fg = '#806d9c' } },
      notify = true,
      priority = 15,
      exclude_filetypes = {
        aerial = true,
        html = true,
        dashboard = true,
        cobol = true,
        copybook = true,
      },
      ------------------
      use_treesitter = true,
      -- support_filetypes = {
      --   '*.py',
      --   '*.lua',
      --   '*.jsx?',
      --   '*.tsx?',
      --   '*.dart',
      --   '*.yaml',
      --   '*.json',
      --   '*.c',
      -- },
      chars = {
        horizontal_line = '─',
        vertical_line = '│',
        left_top = '╭',
        left_bottom = '╰',
        right_arrow = '─', -- '>',
      },
      textobject = 'ac',
      max_file_size = 1024 * 1024, -- 1MB
      error_sign = true,
      -- animation related
      duration = 0,
      delay = 0,
    },
    indent = {
      enable = not utils.is_os_running_on_wsl(),
      use_treesitter = false,
      chars = { '│', '¦', '┆', '┊' },
      style = { '#3b4261' },
    },
    line_num = {
      enable = false,
      use_treesitter = false,
      style = '#806d9c',
    },
    blank = {
      enable = false,
      chars = { '․' },
      style = { vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Whitespace')), 'fg', 'gui') },
    },
  })
end

return M
