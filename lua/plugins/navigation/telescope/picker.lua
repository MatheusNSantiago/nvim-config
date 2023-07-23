--- Cria um picker pro telescope que funciona para um determinado filetype
---@param title string
---@param keymap string
---@param actions_tbl {name: string, handler: function | string}
local function create_picker(title, keymap, actions_tbl)
	-- faz com que strings funcionem com o handler
	for _, action in ipairs(actions_tbl) do
		local handler = action.handler
		if type(handler) == 'string' then action.handler = function()
			vim.cmd("TermExec cmd='"..handler.."'")
		end end
	end

	local entry_maker = function(menu_item)
		return {
			value = menu_item,
			ordinal = menu_item.name,
			display = menu_item.name,
		}
	end

	local finder = require('telescope.finders').new_table({
		results = actions_tbl,
		entry_maker = entry_maker,
	})
	local sorter = require('telescope.sorters').get_generic_fuzzy_sorter({})
	local dropdown_theme = require('telescope.themes').get_dropdown({})

	utils.api.keymap('n', keymap, function()
		require('telescope.pickers')
			.new(dropdown_theme, {
				prompt_title = title,
				finder = finder,
				sorter = sorter,
				attach_mappings = function(prompt_buffer_number)
					local actions = require('telescope.actions')

					-- On item select
					actions.select_default:replace(function()
						local state = require('telescope.actions.state')
						local selection = state.get_selected_entry()

						actions.close(prompt_buffer_number) -- Closing the picker
						selection.value.handler() -- Executing the callback
					end)
					return true
				end,
			})
			:find()
	end)
end

return create_picker
