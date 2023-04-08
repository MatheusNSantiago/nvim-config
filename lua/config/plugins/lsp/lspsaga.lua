local M = {}
local map = require("utils").map
local opts = { noremap = true, silent = true }

function M.setup()
	map("n", "<A-q>", ":Lspsaga hover_doc<CR>", opts) -- Hover Doc
	map("n", "<F2>", ":Lspsaga rename<CR>", opts)  -- Rename F2

	-- Diagnostic jump
	map("n", "[e", ":Lspsaga diagnostic_jump_prev<CR>", opts)
	map("n", "]e", ":Lspsaga diagnostic_jump_next<CR>", opts)

	-- Diagnostic jump with filters such as only jumping to an error
	map("n", "[E", function()
		require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end)
	map("n", "]E", function()
		require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	end)

	map("n", "gp", ":Lspsaga peek_definition<CR>", opts)
	map("n", "gf", ":Lspsaga lsp_finder<CR>", opts)
	map("n", "gd", ":Lspsaga goto_definition<CR>", opts)
	map("n", "gD", ":tab split | Lspsaga goto_definition<CR>", opts)     -- Abre a definição em um novo buffer
	map({ "n", "v" }, "<leader>ca", ":Lspsaga code_action<CR>", opts) -- Code action
	map("n", "gl", ":Lspsaga show_line_diagnostics<CR>", opts)     -- Show line diagnostics

	return {
		"glepnir/lspsaga.nvim",
		config = M.config,
		cmd = { "Lspsaga" },
	}
end

function M.config()
	require("lspsaga").setup({
		ui = {
			title = true,
			-- Border type can be single, double, rounded, solid, shadow.
			border = "single",
			winblend = 0,
			expand = "",
			collapse = "",
			code_action = "💡",
			incoming = " ",
			outgoing = " ",
			hover = " ",
			kind = {},
		},
		rename = {
			quit = "q",
			exec = "<CR>",
			mark = "x",
			confirm = "<CR>",
			in_select = true,
		},
		lightbulb = {
			enable = false,
			enable_in_insert = true,
			sign = false,
			sign_priority = 40,
			virtual_text = true,
		},
		code_action = {
			num_shortcut = true,
			show_server_name = false,
			extend_gitsigns = true,
			keys = {
				-- string | table type
				quit = "q",
				exec = "<CR>",
			},
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
end

return M
