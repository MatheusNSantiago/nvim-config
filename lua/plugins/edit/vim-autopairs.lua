local M = {}

function M.setup()
	-- make autopairs and completion work together
	local cmp_status_ok, cmp = pcall(require, 'cmp')
	if cmp_status_ok then cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done()) end

	return {
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		config = M.config,
	}
end

function M.config()
	require('nvim-autopairs').setup({
		check_ts = true,
		close_triple_quotes = true,
		ts_config = {
			lua = { 'string', 'source' },
			javascript = { 'string', 'template_string' },
			java = false,
		},
		enable_check_bracket_line = false, -- (  |)) => ( => (  (|))
		disable_filetype = { 'TelescopePrompt', 'vim' },
	})
end

return M
