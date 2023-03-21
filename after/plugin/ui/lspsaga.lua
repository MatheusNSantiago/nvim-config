local status, saga = pcall(require, "lspsaga")
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

if not status then
	return
end

saga.setup({
	-- server_filetype_map = {
	--   typescript = 'typescript'
	-- },
	-- move_in_saga = { prev = { "<C-l>", "l", "<C-n>" }, next = { "<C-k>", "k", "<C-p>" } },
	rename = {
		quit = "q",
		exec = "<CR>",
		mark = "x",
		confirm = "<CR>",
		in_select = true,
	},
	lightbulb = {
		enable = true,
		enable_in_insert = true,
		sign = true,
		sign_priority = 40,
		virtual_text = true,
	},
	finder = {
		--percentage
		max_height = 0.5,
		force_max_height = false,
		keys = {
			jump_to = "p",
			edit = { "o", "<CR>" },
			vsplit = "s",
			split = "i",
			tabe = "t",
			tabnew = "r",
			quit = { "q", "<ESC>" },
			close_in_preview = "<ESC>",
		},
	},
})

keymap("n", "<A-q>", "<Cmd>Lspsaga hover_doc<CR>", opts) -- Hover Doc
-- Rename F2
keymap("n", "<F2>", "<Cmd>Lspsaga rename<CR>", opts)

-- Diagnostic jump
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

-- Diagnostic jump with filters such as only jumping to an error
keymap("n", "[E", function()
	require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
keymap("n", "]E", function()
	require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

keymap("n", "gp", "<CMD>Lspsaga peek_definition<CR>", opts)
keymap("n", "gf", "<CMD>Lspsaga lsp_finder<CR>", { silent = true })
keymap("n", "gd", "<CMD>Lspsaga goto_definition<CR>")
keymap("n", "gD", "<CMD>tab split | Lspsaga goto_definition<CR>")

-- Code action
keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

-- Show line diagnostics
keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

vim.api.nvim_create_autocmd("Filetype", {
	pattern = "lspsagafinder",
	callback = function()
		keymap("n", "<C-n>", "<Down>", { buffer = true, nowait = true, noremap = true })
		keymap("n", "<C-p>", "<Up>", { buffer = true, nowait = true, noremap = true })
	end,
})
