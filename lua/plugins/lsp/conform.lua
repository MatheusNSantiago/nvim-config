local M = {}

function M.setup()
	return {
		'stevearc/conform.nvim',
		event = { 'BufWritePre' },
		cmd = { 'ConformInfo' },
		keys = {
			{
				'<leader>ff',
				function() require('conform').format({ async = true }) end,
				desc = 'Format buffer',
			},
		},
		config = M.config,
	}
end

function M.config()
	local conform = require('conform')
	conform.setup({

		formatters_by_ft = {
			lua = { 'stylua' },
			c = { 'clang-format' },
			dart = { 'dart_format' },
			yamlfmt = { 'yamlfmt' },
			fish = { 'fish_indent' },
			javascript = { 'prettierd', 'rusty' },
			typescript = { 'prettierd', 'rusty' },
			javascriptreact = { 'prettierd' },
			typescriptreact = { 'prettierd' },
			html = { 'prettierd' },
			python = function(bufnr)
				if conform.get_formatter_info('ruff_format', bufnr).available then
					return { 'ruff_format' }
				else
					return { 'isort', 'black' }
				end
			end,
		},
		default_format_opts = { lsp_format = 'fallback' },
		-- Set the log level. Use `:ConformInfo` to see the location of the log file.
		log_level = vim.log.levels.ERROR,
		-- Conform will notify you when a formatter errors
		notify_on_error = true,
		-- Conform will notify you when no formatters are available for the buffer
		notify_no_formatters = true,
		-- Custom formatters and overrides for built-in formatters
		---@see https://github.com/stevearc/conform.nvim?tab=readme-ov-file#options
		formatters = {
			stylua = {
				append_args = {
					'--config-path',
					vim.fn.expand('~/.config/nvim/lua/lsp/linter-config/stylua.toml'),
				},
			},
		},
	})
end

return M
