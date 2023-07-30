local M = {}

function M.setup()
	return {
		'jose-elias-alvarez/null-ls.nvim',
		config = M.config,
	}
end

function M.config()
	local null_ls = require('null-ls')
	local b = null_ls.builtins

	-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
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
			b.diagnostics.ruff.with({
				extra_args = { '--config', vim.fn.expand(vim.g.vim_dir .. '/lua/lsp/linter-config/ruff.toml') },
			}), -- Fast Linter
			--  ╭──────────────────────────────────────────────────────────╮
			--  │                          JS/TS                           │
			--  ╰──────────────────────────────────────────────────────────╯
			b.formatting.prettierd,
			b.code_actions.eslint_d,
			-- b.formatting.rustywind, -- tailwind (reorganiza classes)
			-- b.diagnostics.eslint_d, -- js/ts
			-- b.diagnostics.xo,
			require('typescript.extensions.null-ls.code-actions'),

			--  ╭──────────────────────────────────────────────────────────╮
			--  │                            C                             │
			--  ╰──────────────────────────────────────────────────────────╯
			b.formatting.clang_format,
			--  ╭──────────────────────────────────────────────────────────╮
			--  │                           Dart                           │
			--  ╰──────────────────────────────────────────────────────────╯
			b.formatting.dart_format,
			--  ╭──────────────────────────────────────────────────────────╮
			--  │                          Outros                          │
			--  ╰──────────────────────────────────────────────────────────╯
			b.formatting.fixjson,  -- json
			b.formatting.yamlfmt,  -- yaml
			b.formatting.fish_indent, -- fish
			b.diagnostics.fish,    -- fish
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
