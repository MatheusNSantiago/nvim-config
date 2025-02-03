vim.g.vim_dir = vim.fn.stdpath('config')
--  ╾──────────────────────────────────────────────────────────────────────────────────────────────────╼
vim.cmd("language en_US")
--  ╾──────────────────────────────────────────────────────────────────────────────────────────────────╼
require('options')
require('utils')
require('autocommands')
require('plugins')
require('lsp').setup()
require('filetypes')
require('keymappings')
