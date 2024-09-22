vim.g.vim_dir = vim.fn.stdpath('config')

--  ╾──────────────────────────────────────────────────────────────────────────────────────────────────╼

require('options')
require('utils')
require('autocommands')
require('plugins')
require('lsp').setup()
require('filetypes')
require('keymappings')
