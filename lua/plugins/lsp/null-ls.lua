local M = {}

function M.setup()
	return {
		'nvimtools/none-ls.nvim',
		config = M.config,
	}
end

function M.config()
	local null_ls = require('null-ls')
	local b = null_ls.builtins

	-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
	null_ls.setup({
		sources = {
			--  ╭──────────────────────────────────────────────────────────╮
			--  │                           Lua                            │
			--  ╰──────────────────────────────────────────────────────────╯
			b.formatting.stylua.with({
				extra_args = { '--config-path', vim.fn.expand('~/.config/nvim/lua/lsp/linter-config/stylua.toml') },
			}),
			b.completion.luasnip,
			--  ╭──────────────────────────────────────────────────────────╮
			--  │                          Python                          │
			--  ╰──────────────────────────────────────────────────────────╯
			b.formatting.black,
			-- b.diagnostics.ruff.with({
			-- 	extra_args = { '--config', vim.fn.expand(vim.g.vim_dir .. '/lua/lsp/linter-config/ruff.toml') },
			-- }), -- Fast Linter
			b.formatting.isort,
			b.formatting.black,

			--  ╭──────────────────────────────────────────────────────────╮
			--  │                          JS/TS                           │
			--  ╰──────────────────────────────────────────────────────────╯
			b.formatting.prettierd,
			b.formatting.rustywind,
			-- b.code_actions.eslint_d,
			-- b.formatting.rustywind, -- tailwind (reorganiza classes)
			-- b.diagnostics.eslint_d, -- js/ts
			-- b.diagnostics.xo,
			-- require('typescript.extensions.null-ls.code-actions'),

			--  ╾─────────────────────────────────────────────────────────╼
			b.formatting.clang_format, -- C/C++
			b.formatting.dart_format, -- Dart
			b.formatting.yamlfmt,   -- yaml
			b.formatting.fish_indent, -- fish
			b.diagnostics.fish,     -- fish
		},
		on_attach = function(client, bufnr)
			if client.supports_method('textDocument/formatting') then
				vim.keymap.set(
					'n',
					'<Leader>ff',
					function() vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf(), timeout_ms = 3000 }) end,
					{ buffer = bufnr, desc = '[lsp] format' }
				)
			end
		end,
	})
end

return M
