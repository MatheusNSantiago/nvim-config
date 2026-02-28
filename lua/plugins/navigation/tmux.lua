local M = {}

function M.setup()
	return {
		'aserowy/tmux.nvim',
		event = 'VeryLazy',
		config = M.config,
	}
end

function M.config()
	local tmux = require('tmux')

	tmux.setup({
		copy_sync = { enable = false },
		navigation = { enable_default_keybindings = false },
		resize = { enable_default_keybindings = false },
		swap = { enable_default_keybindings = false },
	})

	-- Navegação JKLÇ (esquerda/baixo/cima/direita)
	vim.keymap.set('n', '<C-j>', tmux.move_left, { desc = 'tmux: move left' })
	vim.keymap.set('n', '<C-k>', tmux.move_bottom, { desc = 'tmux: move down' })
	vim.keymap.set('n', '<C-l>', tmux.move_top, { desc = 'tmux: move up' })
	vim.keymap.set('n', '<C-ç>', tmux.move_right, { desc = 'tmux: move right' })

	-- Resize
	vim.keymap.set('n', '<C-S-A-j>', tmux.resize_left, { desc = 'tmux: resize left' })
	vim.keymap.set('n', '<C-S-A-k>', tmux.resize_bottom, { desc = 'tmux: resize down' })
	vim.keymap.set('n', '<C-S-A-l>', tmux.resize_top, { desc = 'tmux: resize up' })
	vim.keymap.set('n', '<C-S-A-ç>', tmux.resize_right, { desc = 'tmux: resize right' })

	-- Swap
	vim.keymap.set('n', '<leader>J', tmux.swap_left, { desc = 'tmux: swap left' })
	vim.keymap.set('n', '<leader>K', tmux.swap_bottom, { desc = 'tmux: swap down' })
	vim.keymap.set('n', '<leader>L', tmux.swap_top, { desc = 'tmux: swap up' })
	vim.keymap.set('n', '<leader>Ç', tmux.swap_right, { desc = 'tmux: swap right' })
end

return M
