local M = {}

function M.setup()
	return {
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		config = M.config,
	}
end

function M.config()
	-- local exclude_filetypes = { 'cobol', 'copybook' }

	-- utils.api.augroup('auto_pairs_and_completion_augroup', {
	-- 	desc = 'make autopairs and completion work together',
	-- 	event = 'BufEnter',
	-- 	pattern = '*',
	-- 	command = function(arg)
	-- 		local cmp_status_ok, cmp = pcall(require, 'cmp')
	-- 		if cmp_status_ok then --
	-- 			cmp.event:on('confirm_done', function()
	-- 				if vim.tbl_contains(exclude_filetypes, vim.bo.filetype) then return end
	-- 				require('nvim-autopairs.completion.cmp').on_confirm_done()
	-- 			end)
	-- 		end
	-- 	end,
	-- })

	require('nvim-autopairs').setup({
		check_ts = true,
		close_triple_quotes = true,
		ts_config = {
			lua = { 'string', 'source' },
			javascript = { 'string', 'template_string' },
			java = false,
		},
		enable_check_bracket_line = true, -- (|)) =digita=> ( =fica=> ((|))
		disable_filetype = { 'TelescopePrompt', 'vim', 'bigfile' },
	})
end

return M
