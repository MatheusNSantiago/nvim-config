local M = {}

function M.setup()
	local is_installed = pcall(require, 'colorizer')

	if is_installed then
		utils.api.augroup('AttatchColorizer', {
			event = { 'BufEnter', 'BufWritePost' },
			pattern = '*',
			command = function()
				if vim.bo.filetype == 'NvimTree' then return end
				return vim.cmd([[ColorizerAttachToBuffer]])
			end,
		})
	end

	return {
		'norcalli/nvim-colorizer.lua',
		config = M.config,
	}
end

function M.config()
	require('colorizer').setup({
		filetypes = { '*', '!NvimTree' },
		user_default_options = {
			names = false,
			tailwind = 'both',
			mode = 'background',
		},
	})
end

return M
