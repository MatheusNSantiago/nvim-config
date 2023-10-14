vim.g.vim_dir = '~/.config/nvim'

--  ╾──────────────────────────────────────────────────────────────────────────────────────────────────╼

require('options')
require('utils')
require('autocommands')
require('plugins')
require('lsp').setup()
require('filetypes')
require('keymappings')
