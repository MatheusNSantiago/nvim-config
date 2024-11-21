local M = {}

function M.setup()
	return {
		'L3MON4D3/LuaSnip',
		config = M.config,
		event = 'InsertEnter',
		-- install jsregexp (optional!).
		build = 'make install_jsregexp',
		dependencies = {
			'friendly-snippets', -- Set of preconfigured snippets for different languages.
		},
	}
end

function M.config()
	local luasnip = require('luasnip')

	-- forget the current snippet when leaving the insert mode. ref: https://github.com/L3MON4D3/LuaSnip/issues/656#issuecomment-1313310146
	utils.api.augroup('UnlinkSnippetOnModeChange', {
		desc = 'Forget the current snippet when leaving the insert mode',
		event = 'ModeChanged',
		pattern = { 's:n', 'i:*' },
		command = function(evt)
			if luasnip.session and luasnip.session.current_nodes[evt.buf] and not luasnip.session.jump_active then
				luasnip.unlink_current()
			end
		end,
	})

	luasnip.filetype_extend('typescriptreact', { 'html', 'typescript' })
	luasnip.filetype_extend('javascriptreact', { 'html', 'javascript' })

	require('luasnip.loaders.from_vscode').lazy_load()
	require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets' })

	luasnip.config.set_config({
		region_check_events = 'CursorMoved',
	})
end

return M
