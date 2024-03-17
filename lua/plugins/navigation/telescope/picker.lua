local M = {}

--- Cria um picker pro telescope que funciona para um determinado filetype
---@param keymap string
---@param title string
---@param actions_tbl {name: string, handler: function | string}
function M.create_picker(keymap, title, actions_tbl)
	for _, action in ipairs(actions_tbl) do
		M.normalize_action(action)
	end

	local entry_maker = function(menu_item)
		return {
			value = menu_item,
			ordinal = menu_item.name,
			display = menu_item.name,
		}
	end

	utils.api.keymap({ 'n', 'x' }, keymap, function()
		local delay_ms = 0

		-- Caso estaja em modo visual, o nvim precisa de um pouco de mais tempo
		-- para processar os marks '< e '>, então é necessário adicionar um delay
		local isVisualMode = vim.fn.mode() == 'v' or vim.fn.mode() == 'V'
		if isVisualMode then
			-- Sai do modo visual (para que os registradores '<,'> sejam preenchidos)
			local ESC_FEEDKEY = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
			vim.api.nvim_feedkeys(ESC_FEEDKEY, 'n', true)
			delay_ms = 100
		end

		vim.defer_fn(function()
			require('telescope.pickers')
					.new(require('telescope.themes').get_dropdown({}), {
						prompt_title = title,
						finder = require('telescope.finders').new_table({
							results = actions_tbl,
							entry_maker = entry_maker,
						}),
						sorter = require('telescope.sorters').get_generic_fuzzy_sorter({}),
						attach_mappings = function(prompt_buffer_number)
							local actions = require('telescope.actions')

							-- On item select
							actions.select_default:replace(function()
								local state = require('telescope.actions.state')
								local selection = state.get_selected_entry()

								actions.close(prompt_buffer_number) -- Closing the picker
								selection.value.handler(isVisualMode) -- Executing the callback
							end)
							return true
						end,
					})
					:find()
		end, delay_ms)
	end)
end

--- Normaliza o handler de uma ação
--- * Se for um comando do nvim, seta o handler para executar o comando
--- * Se for um comando do terminal, seta o handler para executar o comando no toggleterm
function M.normalize_action(action)
	local handler = action.handler

	if type(handler) == 'string' then
		local isNvimCmd = handler:sub(1, 1) == ':' or handler:sub(1, 1) == '<'

		if isNvimCmd then
			local startsWithColon = handler:sub(1, 1) == ':'
			local startsWithAngleBracket = handler:sub(1, 1) == '<'

			-- pega só o mando principal
			local cmd = ''
			if startsWithColon then
				cmd = string.match(handler, '^:(.*)<.+>$')
			elseif startsWithAngleBracket then
				cmd = string.match(handler, '^<[Cc][Mm][Dd]>(.*)<.+>$')
			end

			-- Seta o handler de acordo com o modo
			action.handler = function(isVisualMode)
				if isVisualMode then
					vim.cmd("'<,'>" .. cmd)
				else
					vim.cmd(cmd)
				end
			end
		else -- Não é um comando do nvim
			-- Então é um comando do terminal (abrir no toggleterm)
			action.handler = function()
				vim.cmd("TermExec cmd='" .. handler .. "'")
				vim.defer_fn(function() vim.cmd('stopinsert') end, 100)
			end
		end
	else
	end
end

return M.create_picker
