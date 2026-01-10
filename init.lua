vim.g.vim_dir = vim.fn.stdpath('config')
--  ╾──────────────────────────────────────────────────────────────────────────────────────────────────╼
-- vim.cmd("language en_US")
--  ╾──────────────────────────────────────────────────────────────────────────────────────────────────╼
require('options')
require('utils')
require('autocommands')
require('plugins')
require('lsp').setup()
require('filetypes')
require('keymappings')

--  ╾──────────────────────────────────────────────────────────────────────────────────────────────────╼
-- Auto-reload para Claude Code
--  ╾──────────────────────────────────────────────────────────────────────────────────────────────────╼

require('plugins.custom.hotreload').setup()

if utils.was_nvim_opened_to_directory() then
  require('utils.directory-watcher').setup({ path = vim.fn.getcwd() })
end
