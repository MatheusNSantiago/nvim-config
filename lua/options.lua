local opt = vim.opt
local o = vim.o
vim.g.mapleader = vim.keycode('<space>')

opt.hidden = true
opt.encoding = 'utf-8'
opt.showmatch = true -- show matching brackets.
o.completeopt = 'menu,menuone,popup,fuzzy'
opt.pumheight = 10 -- Maximum number of items to show in the popup menu

-- opt.mouse = ""      -- disabilita o mouse

opt.undofile = true -- Salva histórico de undo
o.undolevels = 10000 -- Max undo

-- Indentação
opt.autoindent = true -- indent a new line the same as the current line
opt.smartindent = true
opt.cindent = true
opt.tabstop = 2 -- number of columns occupied by a tab character
opt.shiftwidth = 2 -- width for autoindents
opt.softtabstop = 2 -- see multiple spaces as tabstops
opt.smarttab = true
opt.expandtab = true -- converts tabs to white space

-- Texto
opt.lbr = true -- ligar o linebreak
opt.tw = 500 -- linebreak on 500 characters
opt.wrap = true -- wrap lines

-- Fold
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Coisos de UI
opt.signcolumn = 'yes' -- Adiciona uma coluna (de signs) do lado dos números
opt.cmdheight = 1
opt.number = true
opt.relativenumber = true
opt.scrolloff = 6 -- número de mínimo de linhas acima e abaixo do cursor
-- opt.splitkeep = 'screen'
opt.laststatus = 3
opt.cursorline = true
opt.termguicolors = true
opt.background = 'dark'
vim.g.netrw_banner = 0


-- Desabilitar Backups
opt.swapfile = false -- No swap files
opt.backup = false -- No backup files
opt.writebackup = false -- No backup files

-- Search settings
opt.hlsearch = true -- highlight search results
opt.ignorecase = true -- case insensitive matching
opt.incsearch = true -- Start showing results as you type
opt.smartcase = true -- Be smart about case sensitivity when searching
opt.path:remove('/usr/include')
opt.path:append('**')
opt.wildignorecase = true
opt.wildignore:append('**/node_modules/*')
opt.wildignore:append('**/.git/*')

vim.o.updatetime = 200 -- save swap file with 200ms debouncing
