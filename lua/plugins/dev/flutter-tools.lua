local M = {}

function M.setup()
	return {
		'akinsho/flutter-tools.nvim',
		ft = 'dart',
		config = M.config,
	}
end

function M.config()
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
				device = false,  -- {flutter_tools_decorations.app_version} lualine
				app_version = false, -- {flutter_tools_decorations.device} lualine
			},
		},
		widget_guides = { enabled = true },
		dev_log = {
			enabled = true,
			open_cmd = 'tabedit', -- command to use to open the log buffer
			notify_errors = true, -- if there is an error whilst running then notify the user
		},
		lsp = {
			settings = {
				showTodos = false,
				renameFilesWithClasses = 'prompt', -- "always"
				completeFunctionCalls = true,
				analysisExcludedFolders = {
					vim.fn.expand('~/.pub-cache'),
					'/opt/flutter/packages',
				},
				enableSnippets = true,
				updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
			},
			on_attach = function(client, bufnr)
				local keymap = utils.api.keymap
				local telescope = require('telescope')

				require('lsp').common_on_attach(client, bufnr)
				telescope.load_extension('flutter')

				keymap('n', '<leader>dl', ':tabedit __FLUTTER_DEV_LOG__<CR>', { desc = 'Flutter: Open [D]ev [L]og' })
				keymap('n', '<leader>r', ':FlutterReload<CR>', { desc = 'Flutter: reload' })
				keymap('n', '<leader><leader>r', ':FlutterRestart<CR>', { desc = 'Flutter: restart' })
				keymap('n', '<leader><leader>o', telescope.extensions.flutter.commands, { desc = 'Flutter: open pallete' })
				keymap(
					'n',
					'<leader>br',
					":TermExec cmd='flutter pub run build_runner watch'<CR>",
					{ desc = 'flutter: run code generation' }
				)

				-- Desativar aquela parada de mostrar contexto do hl_chunk
				-- (problema com o widget highlighting do flutter-tools)
				-- local hl_chunk_ok, _ = pcall(require, 'hlchunk')
				-- if hl_chunk_ok then vim.cmd('silent DisableHLChunk') end

				-- hack pra forçar o refresh do highlight
				vim.schedule(function()
					vim.api.nvim_feedkeys(utils.api.replace_termcodes('<ESC>'), 'n', true)
					vim.api.nvim_feedkeys('>>', 'n', true)
					vim.api.nvim_feedkeys('<<', 'n', true)
				end)
			end,
			capabilities = require('lsp').common_capabilities(),
		},
	})
end

return M
