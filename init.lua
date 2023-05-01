vim.g.vim_dir = '~/.config/nvim'

--  ╾──────────────────────────────────────────────────────────────────────────────────────────────────╼

require('options')
require('utils')
require('autocommands')
require('lsp').setup()
require('plugins')
require('keymappings')
