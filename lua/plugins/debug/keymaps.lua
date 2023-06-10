local api = vim.api
local M = {}
M.keymap_restore = {}
M.keymap_temporary = {}

function M.setup()
	local dap_ok, dap = pcall(require, 'dap')
	local dapui_ok, dapui = pcall(require, 'dapui')
	local keymap = utils.api.keymap
	if not (dap_ok or dapui_ok) then return end
	local widgets = require('dap.ui.widgets')
	--  ╾───────────────────────────────────────────────────────────────────────────────────╼
	local set_log_breakpoint = function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end
	local set_condition_breakpoint = function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end

	keymap('n', '<leader>dap', dapui.toggle, { desc = 'dap ui: toggle' })
	keymap('n', '<leader>db', dap.toggle_breakpoint, { desc = 'dap: toggle breakpoint' })
	keymap('n', '<leader>dL', set_log_breakpoint, { desc = 'dap: set log breakpoint' })
	keymap('n', '<leader>dC', set_condition_breakpoint, { desc = 'dap: set condition breakpoint' })
	keymap('n', '<leader>ds', dap.continue, { desc = 'dap: start/continue debug' })
	keymap('n', '<leader>dl', dap.run_last, { desc = 'dap: run last' })
	keymap('n', '<leader>dc', dap.run_to_cursor, { desc = 'dap: run to cursor' })
	keymap('n', '<leader>dh', widgets.hover, { desc = 'dap: hover' })

	-- Enquanto o debug estiver ativo adiciona as keymaps temporárias
	dap.listeners.after.event_initialized['me'] = function()
		keymap('n', '<leader>dr', dap.repl.toggle, { desc = 'dap: toggle repl' })
		keymap('n', '<F3>', dap.terminate, { desc = 'dap: hover' })
		-- M._force_temporary_keymap('K', ui_widgets.hover)
		-- M._force_temporary_keymap('e', dapui.eval)
		-- M._force_temporary_keymap('u', dap.step_out)
		-- M._force_temporary_keymap('i', dap.step_into)
		-- M._force_temporary_keymap('o', dap.step_over)
		-- M._force_temporary_keymap('t', dap.repl.toggle)
		-- M._force_temporary_keymap('<leader>q', dap.close)
		keymap('n', '<up>', dap.restart_frame)
		keymap('n', '<down>', dap.step_over)
		keymap('n', '<left>', dap.step_out)
		keymap('n', '<right>', dap.step_into)
	end

	-- restora as keymaps originais quando o debug é finalizado
	local after_session = function()
		vim.keymap.del('n', '<leader>dr')
		vim.keymap.del('n', '<F3>')

		vim.keymap.del('n', '<up>')
		vim.keymap.del('n', '<down>')
		vim.keymap.del('n', '<left>')
		vim.keymap.del('n', '<right>')

		-- -- Restaura as keymaps originais
		-- for _, original_keymap in pairs(M.keymap_restore) do
		-- 	keymap(original_keymap.mode, original_keymap.lhs, original_keymap.rhs,
		-- 		{ silent = original_keymap.silent == 1 })
		-- end
		--
		-- -- Deleta as keymaps temporárias
		-- for _, sequence in pairs(M.keymap_temporary) do
		-- 	M._delete_keymap(sequence)
		-- end
		--
		-- M.keymap_restore = {}
		-- M.keymap_temporary = {}
	end
	dap.listeners.after.event_terminated['me'] = after_session
	dap.listeners.after.disconnect['me'] = after_session
end

function M._force_temporary_keymap(sequence, new_command)
	-- Deleta as keymaps que tem a mesma sequencia
	-- Caso ela não exista, adiciona a sequência da nova keymap na lista de keymaps temporárias (para serem apagadas futuramente)
	if not M._delete_keymap(sequence) then table.insert(M.keymap_temporary, sequence) end

	utils.api.keymap('n', sequence, new_command, { silent = true })
end

function M._delete_keymap(sequence)
	local already_exists = false

	for _, buf in pairs(api.nvim_list_bufs()) do
		local keymaps = api.nvim_buf_get_keymap(buf, 'n')
		for _, keymap in pairs(keymaps) do
			if keymap.lhs == sequence then
				already_exists = true
				table.insert(M.keymap_restore, keymap)
				api.nvim_buf_del_keymap(buf, 'n', sequence)
			end
		end
	end

	return already_exists
end

return M
