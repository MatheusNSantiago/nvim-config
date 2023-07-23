local M = {}

function M.setup()
  return {
    'nvim-lualine/lualine.nvim',
    event = 'BufReadPre',
    config = M.config,
  }
end

function M.config()
  local icons = require('utils.icons')
  local lualine = require('lualine')
  local c = require('utils.colors')

  local repo_name = vim.fn.fnamemodify(vim.fn.trim(vim.fn.system('git rev-parse --show-toplevel')), ':t')

  lualine.setup({
    options = {
      theme = require('plugins.ui.lualine.theme'),
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
    globalstatus = true,
    icons_enabled = true,
    refresh = {
      statusline = 1000, -- The refresh option sets minimum time that lualine tries
      tabline = 1000, -- to maintain between refresh. It's not guarantied if situation
      winbar = 100,   -- arises that lualine needs to refresh itself before this time
    },
    disabled_filetypes = {
      -- statusline = { "NvimTree", "toggleterm" },
      -- winbar = { "help", "startify", "packer", "neogitstatus", "Trouble", "Outline" },
    },
    sections = require('plugins.ui.lualine.statusline'),
    -- inactive_sections = require("plugins.ui.lualine.statusline").sections,
    winbar = {},
    inactive_sections = {
      lualine_x = {},
      lualine_c = { { '%=' }, { 'filename' } },
    },
    extensions = {
      {
        filetypes = { 'toggleterm' },
        sections = {},
      },
      'quickfix',
      {
        filetypes = { 'NvimTree' },
        sections = {},
        winbar = {
          lualine_b = {
            {
              function() return icons.git.Git .. ' ' .. repo_name end,
              color = { bg = 'None', fg = c.cyan, gui = 'underline,bold' },
            },
          },
        },
      },
    },
  })
end

return M
