local M = {}

function M.setup()
	return {
		'akinsho/flutter-tools.nvim',
		requires = 'plenary.nvim',
		config = M.config,
	}
end

function M.config()
	--  ╭──────────────────────────────────────────────────────────╮
	--  │                      Pubspec Assist                      │
	--  ╰──────────────────────────────────────────────────────────╯

	require('pubspec-assist').setup({})

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                      Flutter Tools                       │
	--  ╰──────────────────────────────────────────────────────────╯

	require('flutter-tools').setup({
		ui = {
			border = 'rounded', -- e.g. "single" | "shadow" | {<table-of-eight-chars>}
			notification_style = 'plugin',
		},
		debugger = {},
		decorations = {
			statusline = {
				device = true, -- {flutter_tools_decorations.app_version} lualine
				app_version = true, -- {flutter_tools_decorations.device} lualine
			},
		},
		widget_guides = { enabled = true },
		dev_log = { enabled = true, open_cmd = 'tabedit' },
		lsp = {
			settings = {
				showTodos = true,
				renameFilesWithClasses = 'prompt',
			},
			on_attach = function(client, bufnr)
				require('lsp').common_on_attach(client, bufnr)
				local keymap = utils.api.keymap

				require('telescope').load_extension('flutter')

				keymap('n', '<leader>r', ':FlutterReload<CR>', { desc = 'Flutter: reload' })
				keymap('n', '<leader><leader>r', ':FlutterRestart<CR>', { desc = 'Flutter: restart' })
				keymap(
					'n',
					'<leader><leader>o',
					require('telescope').extensions.flutter.commands,
					{ desc = 'Flutter: open pallete' }
				)
				keymap(
					'n',
					'<leader>br',
					":TermExec cmd='flutter pub run build_runner watch'<CR>",
					{ desc = 'flutter: run code generation' }
				)

				-- hack pra forçar o refresh do highlight
				vim.defer_fn(function()
					vim.api.nvim_feedkeys('>>', 'n', true)
					vim.api.nvim_feedkeys('<<', 'n', true)
				end, 3000)
			end,
			capabilities = require('lsp').common_capabilities(),
		},
	})
end

return M
