-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`

require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
  buftype_exclude = {"terminal", "telescope", "nofile"},
  filetype_exclude = {"help", "dashboard", "packer", "NvimTree", "Trouble", "TelescopePrompt", "Float"},
  show_current_context = true,
  show_current_context_start = false,
  show_end_of_line = false,
  space_char_blankline = " ",
  use_treesitter = true,
}
