require("utils")

map({ 'n', 'v' }, '<Space>', '<Nul>', { silent = true }) -- Tira a movimentação no space
map({ 'n', 'v' }, '<C-n>', ':nohl<CR>')

-- |────────────────────────| Movimentação |──────────────────────────|

------- Mover no texto

map({ 'n', 'v' }, 'ç', 'l')
map({ 'n', 'v' }, 'l', 'k')
map({ 'n', 'v' }, 'k', 'j')
map({ 'n', 'v' }, 'j', 'h')

--  Mover de linha a linha

map('n', '<C-k>', '<C-e>')

------- Mover entre Tabs

map({ 'n', 'v', 'i' }, '<A-j>', ':tabprevious<CR>', { silent = true })
map({ 'n', 'v', 'i' }, '<A-ç>', ':tabnext<CR>', { silent = true })
map({ 'n', 'v', 'i' }, '<A-1>', '1gt')
map({ 'n', 'v', 'i' }, '<A-2>', '2gt')
map({ 'n', 'v', 'i' }, '<A-3>', '3gt')
map({ 'n', 'v', 'i' }, '<A-4>', '4gt')
map({ 'n', 'v', 'i' }, '<A-5>', '5gt')
map({ 'n', 'v', 'i' }, '<A-6>', '6gt')
map({ 'n', 'v', 'i' }, '<A-7>', '7gt')
map({ 'n', 'v', 'i' }, '<A-8>', '8gt')
map({ 'n', 'v', 'i' }, '<A-9>', '9gt')

-- Ir pra última tab

-- let g:lasttab = 1
-- nmap <silent> <C-Tab> :exe "tabn ".g:lasttab<CR>
-- au TabLeave * let g:lasttab = tabpagenr()

-- Opens a new tab with the current buffer's path
-- Super useful when editing files in the same directory
-- map <leader>te :tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/

-- Mover a tab
map('n', '<A-->', ':tabm -1<CR>', { silent = true })
map('n', '<A-=>', ':tabm +1<CR>', { silent = true })

-- restaurar tab fechada recentemente
map('n', '<leader>ut', ':Undoquit<CR>') -- [U]ndo [T]ab

--------- Mover entre janelas

map('n', '<C-j>', '<C-w>h') -- Left
-- map('n', '<C-ç>', '<C-w>l') -- Right (AutoKey)
map('n', '<C-l>', '<C-w>k') -- Top
map('n', '<C-k>', '<C-w>j') --  Bottom

-- |────────────────────────────| Edição |────────────────────────────|

map({ 'n', 'v' }, '<leader>q', ':q<CR>', { silent = true }) -- [Q]uit
map({ 'n', 'v' }, '<leader>w', ':w<CR>', { silent = true }) -- [W]rite
-- map('n', '<leader>ff', "mzHmxgg=G`xzt`z", { silent = true }) -- [F]ormat [F]ilE

-- Mover a linha verticalmente
map('n', '<M-k>', ':m +1<CR>==', { silent = true })
map('n', '<M-l>', ':m -2<CR>==', { silent = true })

map('v', '<M-l>', ":m '<-2<CR>gv=gv", { silent = true })
map('v', '<M-k>', ":m '>+1<CR>gv=gv", { silent = true })

-- Copiar a linha horizontalmente
map('n', '<S-M-l>', 'mz"yyy"ypg`z')
map('n', '<S-M-k>', 'mz"yyy"yPg`zkj')

map('v', '<S-M-l>', "yPgv:'<,'>m '.-1<CR>gv")
map('v', '<S-M-k>', "yPgv")


-- preservar buffer
map('x', '<leader>p', "\"_dp")

-- copiar para o system clipboard
map({ 'n', 'v' }, "<leader>y", "\"+y")

-- deletar pro void
map({ 'n', 'v' }, "<leader>d", "\"_d")
