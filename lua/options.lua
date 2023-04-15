local opt =  vim.opt
vim.g.mapleader = " "

opt.shell = "fish"
opt.hidden = true
opt.encoding = "utf-8"
opt.showmatch = true -- show matching brackets.
vim.o.completeopt = "menu,menuone,noselect"
-- opt.mouse = ""      -- disabilita o mouse

opt.undofile = true -- Save undo history

-- Indentação
opt.autoindent = true -- indent a new line the same as the current line
opt.smartindent = true
opt.cindent = true
opt.tabstop = 4 -- number of columns occupied by a tab character
opt.shiftwidth = 4 -- width for autoindents
opt.softtabstop = 4 -- see multiple spaces as tabstops
opt.smarttab = true
opt.expandtab = true -- converts tabs to white space

-- Texto
opt.lbr = true -- ligar o linebreak
opt.tw = 500 -- linebreak on 500 characters
opt.wrap = true -- wrap lines

-- UI Stuff
opt.signcolumn = "yes" -- Add a column on the left. Useful for linting
opt.cmdheight = 1 -- Give more space for displaying messages
opt.number = true
opt.relativenumber = true
opt.scrolloff = 6

-- Highlights
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"

-- Desabilitar Backups
opt.swapfile = false -- No swap files
opt.backup = false -- No backup files
opt.writebackup = false -- No backup files

-- Search settings
opt.hlsearch = true -- highlight search results
opt.ignorecase = true -- case insensitive matching
opt.incsearch = true -- Start showing results as you type
opt.smartcase = true -- Be smart about case sensitivity when searching
opt.path:remove("/usr/include")
opt.path:append("**")
opt.wildignorecase = true
opt.wildignore:append("**/node_modules/*")
opt.wildignore:append("**/.git/*")
