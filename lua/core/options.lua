vim.g.mapleader = " "

vim.opt.shell = 'fish'
vim.opt.hidden = true
vim.opt.encoding = 'utf-8'
vim.opt.showmatch = true -- show matching brackets.
vim.opt.mouse = 'a' -- deixa usar mouse no vim
vim.opt.undofile = true -- Save undo history

-- Indentação
vim.opt.autoindent = true -- indent a new line the same as the current line
vim.opt.tabstop = 4 -- number of columns occupied by a tab character
vim.opt.shiftwidth = 4 -- width for autoindents
vim.opt.softtabstop = 4 -- see multiple spaces as tabstops
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.expandtab = true -- converts tabs to white space

-- Texto
vim.opt.lbr = true -- ligar o linebreak
vim.opt.tw = 500 -- linebreak on 500 characters
vim.opt.wrap = true -- wrap lines

-- UI Stuff
vim.opt.signcolumn = "no" -- Add a column on the left. Useful for linting
vim.opt.cmdheight = 1 -- Give more space for displaying messages
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 6

-- Highlights
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 5
vim.opt.background = 'dark'

-- Desabilitar Backups
vim.opt.swapfile = false -- No swap files
vim.opt.backup = false -- No backup files
vim.opt.writebackup = false -- No backup files

-- Search settings
vim.opt.hlsearch = true -- highlight search results
vim.opt.ignorecase = true -- case insensitive matching
vim.opt.incsearch = true -- Start showing results as you type
vim.opt.smartcase = true -- Be smart about case sensitivity when searching
