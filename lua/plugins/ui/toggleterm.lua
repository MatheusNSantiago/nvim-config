local M = {}
local map = require("utils").map

function M.setup()
	map("n", "<leader>lg", M.toggle_lazygit)
	map({ "i", "n", "t" }, "<A-f>", '<CMD>execute v:count . "ToggleTerm direction=float"<CR>')
	map({ "i", "n", "t" }, "<A-i>", "<CMD>execute v:count . 'ToggleTerm direction=horizontal'<CR>")

	-- Seta os keymaps que só funcionam no terminal
	vim.api.nvim_create_autocmd({ "TermOpen" }, {
		pattern = "term://*",
		callback = function()
			map("t", "<ESC>", [[<C-\><C-n>]], { buffer = 0 })

			-- foco
			map("t", "<C-j>", [[<Cmd>wincmd h<CR>]], { buffer = 0 })
			map("t", "<C-k>", [[<Cmd>wincmd j<CR>]], { buffer = 0 })
			map("t", "<C-l>", [[<C-\><C-n>:wincmd k<CR>]], { buffer = 0 })
			map("t", "<C-ç>", [[<ESC><Cmd>wincmd l<CR>]], { buffer = 0 })
		end,
	})

	-- Faz com que sempre esteje no insert mode
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		pattern = "*toggleterm#*", -- if you only want these mappings for toggle term use term://*toggleterm#* instead
		callback = function()
			vim.defer_fn(function()
				vim.cmd("startinsert")
			end, 10)
		end,
	})

	return {
		"akinsho/toggleterm.nvim",
		tag = "*",
		cmd = { "ToggleTerm", "TermExec", "TermOpen" },
		config = M.config,
		module = { "toggleterm", "toggleterm.terminal" },
	}
end

function M.config()
	require("toggleterm").setup({
		-- size can be a number or function which is passed the current terminal
		size = function(term)
			if term.direction == "horizontal" then
				return vim.o.lines * 0.30
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.25
			end
		end,
		hide_numbers = true, -- hide the number column in toggleterm buffers
		shade_filetypes = {},
		shade_terminals = false,
		shading_factor = "0", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
		start_in_insert = true,
		insert_mappings = false, -- whether or not the open mapping applies in insert mode
		persist_size = false,
		on_open = function(t)
			if t.direction == "horizontal" then
				local nvim_tree_ok, api = pcall(require, "nvim-tree.api")
				local tree = api.tree

				if nvim_tree_ok then
					if tree.is_visible() then
						tree.close()
						tree.toggle({ focus = false })
					end
				end
			end
		end, -- function to run when the terminal opens
		on_close = function(t)
			-- local lualine_ok, lualine = pcall(require, "lualine")
			-- lualine.hide({ unhide = true })
		end,                -- function to run when the terminal closes
		direction = "horizontal", --'horizontal', -- 'vertical' | 'horizontal' | 'window' | 'float',
		close_on_exit = true, -- close the terminal window when the process exits
		shell = vim.o.shell, -- change the default shell
		-- This field is only relevant if direction is set to 'float'
		float_opts = {
			-- The border key is *almost* the same as 'nvim_open_win'
			-- see :h nvim_open_win for details on borders however
			-- the 'curved' border is a custom border type
			-- not natively supported but implemented in this plugin.
			border = "curved", --'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
			width = math.floor(vim.o.columns * 0.65),
			height = 15,
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
		highlights = {
			-- highlights which map to a highlight group name and a table of it's values
			-- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
			Normal = {
				-- guifg = "red",
			},
		},
		winbar = {
			enabled = false,
			name_formatter = function(term) --  term: Terminal
				return term.name
			end,
		},
	})
end

function M.toggle_lazygit()
	local Terminal = require("toggleterm.terminal").Terminal

	local lazygit = Terminal:new({
		cmd = "lazygit",
		dir = "git_dir",
		close_on_exit = true,
		hidden = true,
		direction = "float",
		float_opts = {
			width = 10000, -- math.floor(vim.o.columns * 0.65),
			height = 10000, -- math.floor(vim.o.lines * 0.70),
			border = "none", --'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
		-- function to run on opening the terminal
		on_open = function(term)
			vim.cmd("startinsert!")
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		end,
		-- function to run on closing the terminal
		on_close = function(_)
			vim.cmd("startinsert!")
		end,
	})

	return lazygit:toggle()
end

return M
