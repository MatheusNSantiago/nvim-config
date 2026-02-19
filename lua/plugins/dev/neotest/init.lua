local M = {}

function M.setup()
	return {
		'nvim-neotest/neotest',
		dependencies = {
			'nvim-neotest/nvim-nio',
			'nvim-lua/plenary.nvim',
			'antoinemadec/FixCursorHold.nvim',
			'nvim-treesitter/nvim-treesitter',
			--  ─────────────────────────────
			'nvim-neotest/neotest-jest',
			'nvim-neotest/neotest-python',
			-- 'arthur944/neotest-bun',
		},
		config = M.config,

		keys = {
			{ '<leader>tr', function() M.run_tests_on_file() end, desc = 'neotest: [T]est [R]un' },
			{ '<leader>ts', function() M.toggle_summary() end, desc = 'neotest: [T]oggle [S]ummary' },
		},
	}
end

function M.config()
	M.setup_smart_close_autocommand()

	require('neotest').setup({
		adapters = {
			require('neotest-jest')({
				jestCommand = 'npm test --',
				jestConfigFile = 'custom.jest.config.ts',
				env = { CI = true },
				cwd = function(_) return vim.fn.getcwd() end,
			}),
			require('neotest-python')({
				args = { '-s' }, -- desabilita captura de stdout (mostra print() no output)
				python = function(root)
					local dir = root
					while dir and dir ~= '/' do
						if vim.fn.filereadable(dir .. '/uv.lock') == 1 then
							return { 'uv', 'run', 'python' }
						end
						dir = vim.fn.fnamemodify(dir, ':h')
					end
					return require('neotest-python.base').get_python_command(root)
				end,
			}),
			-- require('neotest-bun'),
			require('plugins.dev.neotest.neotest-bun'),
		},
		benchmark = { enabled = true },
		consumers = {},
		default_strategy = 'integrated',
		diagnostic = { enabled = true, severity = 1 },
		discovery = { concurrent = 0, enabled = true },
		floating = {
			border = 'rounded',
			max_height = 0.6,
			max_width = 0.6,
			options = {},
		},
		highlights = {
			adapter_name = 'NeotestAdapterName',
			border = 'NeotestBorder',
			dir = 'NeotestDir',
			expand_marker = 'NeotestExpandMarker',
			failed = 'NeotestFailed',
			file = 'NeotestFile',
			focused = 'NeotestFocused',
			indent = 'NeotestIndent',
			marked = 'NeotestMarked',
			namespace = 'NeotestNamespace',
			passed = 'NeotestPassed',
			running = 'NeotestRunning',
			select_win = 'NeotestWinSelect',
			skipped = 'NeotestSkipped',
			target = 'NeotestTarget',
			test = 'NeotestTest',
			unknown = 'NeotestUnknown',
			watching = 'NeotestWatching',
		},
		icons = {
			child_indent = '│',
			child_prefix = '├',
			collapsed = '─',
			expanded = '╮',
			failed = '',
			final_child_indent = ' ',
			final_child_prefix = '╰',
			non_collapsible = '─',
			notify = '',
			passed = '',
			running = '',
			running_animated = { '/', '|', '\\', '-', '/', '|', '\\', '-' },
			skipped = '',
			unknown = '',
			watching = '',
		},
		jump = { enabled = true },
		log_level = 3,
		output = { enabled = true, open_on_run = 'short' },
		output_panel = {
			enabled = true,
			open = 'botright split | resize 15',
		},
		projects = {},
		quickfix = { enabled = true, open = false },
		run = { enabled = true },
		running = { concurrent = true },
		state = { enabled = true },
		status = {
			enabled = true,
			signs = true,
			virtual_text = false,
		},
		strategies = {
			integrated = { height = 40, width = 120 },
		},
		summary = {
			animated = true,
			count = true,
			enabled = true,
			expand_errors = true,
			follow = true,
			mappings = {
				attach = 'a',
				clear_marked = 'M',
				clear_target = 'T',
				debug = 'd',
				debug_marked = 'D',
				expand = { '<CR>', '<2-LeftMouse>' },
				expand_all = 'e',
				help = '?',
				jumpto = 'i',
				mark = 'm',
				next_failed = 'J',
				output = 'o',
				prev_failed = 'K',
				run = 'r',
				run_marked = 'R',
				short = 'O',
				stop = 'u',
				target = 't',
				watch = 'w',
			},
			open = 'botright vsplit | vertical resize 50',
		},
	})
end

M.is_first_time_opening_summary = true
M.toggle_summary = function()
	local summary_is_closed = M._get_summary_window() == nil

	if summary_is_closed then
		require('neotest').summary.open() -- abre
		vim.api.nvim_set_current_win(M._get_summary_window()) -- coloca o cursor no sumário

		-- Existe demora para abrir o sumário pela primeira vez
		-- Para botar o cursor no sumário do teste mais perto do teste do buffer principal, precisamos
		-- fazer um hackzinho de sair e voltar do buffer
		if M.is_first_time_opening_summary then -- faz o hack
			vim.defer_fn(function()
				vim.cmd('wincmd w') -- Volta para o buffer principal

				-- Espera um pouco para o neotest gravar a localização
				-- Ao voltar p/ o sumário, o cursor será colocado no teste mais perto
				vim.defer_fn(function()
					vim.cmd('wincmd w') -- Volta pro sumário (mouse no teste mais próximo)
				end, 100)
			end, 1000)
			M.is_first_time_opening_summary = false
		end
	else
		require('neotest').summary.close()
	end
end

M._get_summary_window = function()
	local wins = vim.api.nvim_list_wins()
	for _, win in ipairs(wins) do
		local buf = vim.fn.winbufnr(win)
		if vim.bo[buf].ft == 'neotest-summary' then return win end
	end
end

M.run_tests_on_file = function()
	require('neotest').run.run(vim.fn.expand('%'))

	local summary_win = M._get_summary_window()

	local summary_pannel_is_open = summary_win ~= nil
	if summary_pannel_is_open then --
		vim.api.nvim_set_current_win(summary_win)
	else
		M.toggle_summary()
	end
end

---@see https://github.com/akinsho/dotfiles/blob/4831310bbf0ecfc5d563a21494353216c1fc0693/.config/nvim/plugin/autocommands.lua#L86C1-L97C1b
M.setup_smart_close_autocommand = function()
	utils.api.augroup('smart_close_neotest', {
		desc = 'Fecha a janela do neotest com q',
		event = { 'FileType' },
		pattern = { 'neotest-*' },
		command = function(args)
			utils.api.keymap('n', 'q', function() vim.api.nvim_win_close(0, true) end, {
				buffer = args.buf,
				nowait = true,
			})
		end,
	})
end

return M
