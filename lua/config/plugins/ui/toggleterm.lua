local M = {}
local map = require("utils").map

function M.setup()
	M.set_keymaps()

	return {
		"akinsho/toggleterm.nvim",
		tag = "*",
		cmd = { "ToggleTerm", "TermExec", "TermOpen" },
		config = M.config,
		module = { "toggleterm", "toggleterm.terminal" },
	}
end

function M.set_keymaps()
	map({ "n", "t" }, "<A-f>", '<Cmd>execute v:count . "ToggleTerm direction=float"<CR>', { silent = true })
	map({ "n", "t" }, "<A-h>", '<Cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>', { silent = true })

	function _G.set_terminal_keymaps()
		local opts = { buffer = 0 }
		vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], opts)

		-- foco
		vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd h<CR>]], opts)
		vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd j<CR>]], opts)
		vim.keymap.set("t", "<C-l>", [[<C-\><C-n>:wincmd k<CR>]], opts)
		vim.keymap.set("t", "<C-ç>", [[<Cmd>wincmd l<CR>]], opts)
	end

	-- if you only want these mappings for toggle term use term://*toggleterm#* instead
	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
end

function M.config()
	-- local Terminal = require("toggleterm.terminal").Terminal
	-- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

	-- local lazygit = Terminal:new({
	-- 	cmd = "lazygit",
	-- 	dir = "git_dir",
	-- 	direction = "float",
	-- 	float_opts = {
	-- 		border = "double",
	-- 	},
	-- 	-- function to run on opening the terminal
	-- 	on_open = function(term)
	-- 		vim.cmd("startinsert!")
	-- 		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	-- 	end,
	-- 	-- function to run on closing the terminal
	-- 	on_close = function(term)
	-- 		vim.cmd("startinsert!")
	-- 	end,
	-- })

	-- local function _lazygit_toggle()
	-- 	lazygit:toggle()
	-- end
	--
	-- vim.api.nvim_set_keymap("n", "<leader>g", _lazygit_toggle, { noremap = true, silent = true })

	require("toggleterm").setup({
		-- size can be a number or function which is passed the current terminal
		size = function(term)
			if term.direction == "horizontal" then
				return vim.o.lines * 0.30
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.25
			end
		end,
		open_mapping = [[<c-x>]],
		hide_numbers = true, -- hide the number column in toggleterm buffers
		shade_filetypes = {},
		shade_terminals = false,
		shading_factor = "0", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
		start_in_insert = true,
		insert_mappings = false, -- whether or not the open mapping applies in insert mode
		persist_size = false,
		on_open = function(t)
			if t.direction == "horizontal" then
				local is_installed, tree_view = pcall(require, "nvim-tree.view")

				if is_installed then
					-- check if NvimTree is open
					if tree_view.is_visible() then
						vim.cmd("stopinsert")
						vim.cmd("NvimTreeClose")
						vim.cmd("NvimTreeOpen")
						vim.cmd("wincmd l") -- Vai para a direita
						vim.cmd("wincmd j") -- Vai para baixo
					end
				end

				-- -- close NvimTree
				-- tree.close()
			end
		end,                -- function to run when the terminal opens
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
	})
end

return M
