local M = {}

function M.setup()
	vim.filetype.add({ extension = { ipynb = 'ipynb' } })

	return { ---@type LazyPluginSpec
		dir = vim.fn.stdpath('config') .. '/lua/plugins/dev/ipynb.nvim',
		name = 'ipynb.nvim',
		lazy = false,
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'neovim/nvim-lspconfig',
			'williamboman/mason-lspconfig.nvim',
			'nvim-tree/nvim-web-devicons',
			'folke/snacks.nvim',
		},
		config = M.config,
	}
end

local function save_notebook(buf)
	local state_mod = require('ipynb.state')
	local state = state_mod.get(buf) or state_mod.get_from_edit_buf(buf)
	if not state then return end

	require('ipynb.io').save_notebook(state.facade_buf)
	vim.bo[buf].modified = false
end

local function setup_save_mapping(buf)
	vim.keymap.set({ 'n', 'v' }, '<leader>w', function()
		save_notebook(buf)
	end, { buffer = buf, desc = 'Notebook save' })
end

local function setup_facade_mappings(buf)
	setup_save_mapping(buf)
	vim.keymap.set('n', 'p', '<Nop>', { buffer = buf, desc = 'Notebook paste disabled; use <leader>kp' })
	vim.keymap.set('n', 'P', '<Nop>', { buffer = buf, desc = 'Notebook paste disabled; use <leader>kP' })
end

local function setup_write_mappings()
	local group = vim.api.nvim_create_augroup('user_ipynb_mappings', { clear = true })
	vim.api.nvim_create_autocmd('FileType', {
		group = group,
		pattern = 'ipynb',
		callback = function(args) setup_facade_mappings(args.buf) end,
	})

	vim.api.nvim_create_autocmd('BufEnter', {
		group = group,
		callback = function(args)
			if vim.b[args.buf].ipynb_edit_lang and not vim.b[args.buf].ipynb_write_keymap then
				vim.b[args.buf].ipynb_write_keymap = true
				setup_save_mapping(args.buf)
			end
		end,
	})
end

function M.config()
	require('ipynb').setup({
		keymaps = {
			paste_cell_below = '<leader>kp',
			paste_cell_above = '<leader>kP',
		},
		float = {
			edit_in_place = true,
		},
		shadow = {
			location = 'workspace',
		},
	})

	setup_write_mappings()
end

return M
