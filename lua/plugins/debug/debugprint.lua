local M = {}
local keymap = utils.api.keymap

function M.setup()
	local is_installed, debugprint = pcall(require, 'debugprint')

	if is_installed then
		keymap('n', '<leader>dp', function() debugprint.debugprint({ variable = true }) end, {
			desc = 'debugprint: cursor',
			expr = true,
		})
		keymap('n', '<leader>dp', function() debugprint.debugprint({ variable = true }) end, {
			desc = 'debugprint: operator',
			expr = true,
		})
		keymap('n', '<leader>dc', ':DeleteDebugPrints<CR>', {
			desc = 'debugprint: clear all',
			expr = true,
		})
	end

	return {
		'andrewferrier/debugprint.nvim',
		config = M.config,
	}
end

function M.config()
	require('debugprint').setup({
		create_keymaps = false,
		create_commands = false,
	})
end

return M
