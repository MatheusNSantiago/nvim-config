local M = {}

function M.setup()
	return {
		'mfussenegger/nvim-dap',
		config = M.config,
		keys = {
			{ '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'dap: toggle breakpoint' },
			{
				'<leader>dL',
				function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
				desc = 'dap: set log breakpoint',
			},
			{
				'<leader>dC',
				function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
				desc = 'dap: set condition breakpoint',
			},
			{ '<leader>ds', function() require('dap').continue() end, desc = 'dap: start/continue debug' },
			{ '<leader>dc', function() require('dap').run_to_cursor() end, desc = 'dap: run to cursor' },
		},
	}
end

function M.config()
	local dap = require('dap')

	-- SETUP LISTENERS
	dap.listeners.after.event_initialized['me'] = function()
		M._force_temporary_keymap('K', function() require('dapui').eval() end)
		M._force_temporary_keymap('<leader>q', dap.terminate)
		M._force_temporary_keymap('<leader>j', dap.step_out)
		M._force_temporary_keymap('<leader>k', dap.step_over)
		M._force_temporary_keymap('<leader>l', dap.restart_frame)
		M._force_temporary_keymap('<leader>ç', dap.step_into)
	end

	-- restora as keymaps originais quando o debug é finalizado
	local after_session = function()
		-- Deleta as keymaps temporárias
		for _, sequence in pairs(M.keymap_temporary) do
			vim.keymap.del('n', sequence)
		end

		-- Restaura as keymaps originais
		for _, m in pairs(M.keymap_restore) do
			vim.keymap.set('n', m.lhs, m.callback, { silent = m.silent, desc = m.desc, noremap = m.noremap })
		end

		M.keymap_restore = {}
		M.keymap_temporary = {}
	end
	dap.listeners.after.event_terminated['me'] = after_session
	dap.listeners.after.disconnect['me'] = after_session
end

M.keymap_restore = {}
M.keymap_temporary = {}

function M._force_temporary_keymap(sequence, new_command)
	-- Deleta as keymaps que tem a mesma sequencia
	-- Caso ela não exista, adiciona a sequência da nova keymap na lista de keymaps temporárias (para serem apagadas futuramente)
	M._delete_keymap(sequence)
	table.insert(M.keymap_temporary, sequence)

	vim.keymap.set('n', sequence, new_command, { silent = true })
end

function M._delete_keymap(sequence)
	local keymaps = vim.api.nvim_buf_get_keymap(0, 'n')
	for _, keymap_ in pairs(keymaps) do
		if keymap_['lhs'] == sequence then
			table.insert(M.keymap_restore, keymap_)
			vim.keymap.del('n', sequence, { buffer = 0 })
		end
	end
end

M.highlights = {
	DapBreakpoint = { fg = c.red, bg = c.red },
	DapStopped = { fg = c.green },
}

return M
