local map = require("utils").map

local silent = { silent = true }

--  ╭──────────────────────────────────────────────────────────╮
--  │                          Geral                           │
--  ╰──────────────────────────────────────────────────────────╯
map({ "n", "v" }, "<Space>", "<Nul>", silent)                                            -- Tira a movimentação no space
map({ "n", "v" }, "<C-n>", ":nohl<CR>", silent)                                          -- Remove Highlights

map({ "n", "x" }, "gx", ":silent execute '!open ' . shellescape('<cWORD>')<CR>", silent) -- Abrir links com o cursor

map({ "n" }, "<leader><leader>q", ":quitall!<CR>")

--  ╭──────────────────────────────────────────────────────────╮
--  │                       Movimentação                       │
--  ╰──────────────────────────────────────────────────────────╯

------- Mover no texto

map({ "n", "v" }, "ç", "l", silent)
map({ "n", "v" }, "l", "k", silent)
map({ "n", "v" }, "k", "j", silent)
map({ "n", "v" }, "j", "h", silent)

--  Mover de linha a linha

------- Mover entre Tabs

map({ "n", "v", "i" }, "<A-j>", ":tabprevious<CR>", silent)
map({ "n", "v", "i" }, "<A-ç>", ":tabnext<CR>", silent)
map({ "n", "v", "i" }, "<A-1>", "1gt")
map({ "n", "v", "i" }, "<A-2>", "2gt")
map({ "n", "v", "i" }, "<A-3>", "3gt")
map({ "n", "v", "i" }, "<A-4>", "4gt")
map({ "n", "v", "i" }, "<A-5>", "5gt")
map({ "n", "v", "i" }, "<A-6>", "6gt")
map({ "n", "v", "i" }, "<A-7>", "7gt")
map({ "n", "v", "i" }, "<A-8>", "8gt")
map({ "n", "v", "i" }, "<A-9>", "9gt")
--
-- Mover a tab
map("n", "<A-->", ":tabm -1<CR>", silent)
map("n", "<A-=>", ":tabm +1<CR>", silent)

-- restaurar tab fechada recentemente
map("n", "<leader>ut", "<Cmd>Undoquit<CR>") -- [U]ndo [T]ab

--------- Mover entre janelas

map("n", "<C-j>", "<C-w>h") -- Left
-- map('n', '<C-ç>', '<C-w>l') -- Right (AutoKey)
map("n", "<C-l>", "<C-w>k") -- Top
map("n", "<C-k>", "<C-w>j") --  Bottom

-- Mover no command mode
map("c", "C-k", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true})
map("c", "C-l", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true})
-- map("c", "<C-k>", "<Right>")
-- map("c", "<C-l>", "<Left>")


--  ╭──────────────────────────────────────────────────────────╮
--  │                          Edição                          │
--  ╰──────────────────────────────────────────────────────────╯

map({ "n", "v" }, "<leader>q", ":q<CR>", silent)          -- [Q]uit
-- map({ "n", "v" }, "<leader>w", ":w<CR>:so %<CR>", silent) -- [W]rite
-- map({ "n", "v" }, "<leader>w", ":w<CR>:so %<CR>:PackerCompile<CR>", silent) -- [W]rite
map({ "n", "v" }, "<leader>w", ":w<CR>", silent) -- [W]rite

-- Mover a linha verticalmente
map("n", "<M-k>", ":m +1<CR>==", silent)
map("n", "<M-l>", ":m -2<CR>==", silent)

map("v", "<M-l>", ":m '<-2<CR>gv=gv", silent)
map("v", "<M-k>", ":m '>+1<CR>gv=gv", silent)

-- Copiar a linha horizontalmente
map({ "n", "i" }, "<S-M-l>", 'mz"yyy"ypg`z')
map({ "n", "i" }, "<S-M-k>", 'mz"yyy"yPg`zkj')

map("v", "<S-M-l>", "yPgv:'<,'>m '.-1<CR>gv")
map("v", "<S-M-k>", "yPgv")

-- preservar buffer
map("x", "<leader>p", '"_dp')

-- copiar para o system clipboard
map({ "n", "v" }, "<leader>y", '"+y')

-- deletar pro void
map({ "n", "v" }, "<leader>d", '"_d')

--  ╭──────────────────────────────────────────────────────────╮
--  │                          Resize                          │
--  ╰──────────────────────────────────────────────────────────╯

-- Resize Panes

map("n", "<C-Up>", ":resize -2<CR>", silent)
map("n", "<C-Down>", ":resize +2<CR>", silent)
map("n", "<C-Left>", ":vertical resize +2<CR>", silent)
map("n", "<C-Right>", ":vertical resize -2<CR>", silent)
