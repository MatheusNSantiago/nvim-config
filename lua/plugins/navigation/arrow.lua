local M = {}

function M.setup()
	return {
		'otavioschwanck/arrow.nvim',
		config = M.config,
		keys = { { ';', desc = 'arrow: toggle' } },
	}
end

function M.config()
	require('arrow').setup({
		show_icons = true,
		leader_key = ';',
		always_show_path = false,
		separate_by_branch = false, -- Bookmarks will be separated by git branch
		hide_handbook = false, -- set to true to hide the shortcuts on menu.
		mappings = {
			edit = 'e',
			delete_mode = 'd',
			clear_all_items = 'C',
			open_vertical = 'v',
			open_horizontal = 'h',
			quit = 'q',
			next_item = ']',
		},
		custom_actions = {
			-- open = function(target_file_name, current_file_name) end,
			split_vertical = function(target_file_name, _)
				vim.cmd(':vsplit ' .. target_file_name)
				vim.cmd('wincmd L')
			end,
			-- split_horizontal = function(target_file_name, current_file_name) end,
		},
		window = { -- controls the appearance and position of an arrow window (see nvim_open_win() for all options)
			width = 'auto',
			height = 'auto',
			row = 'auto',
			col = 'auto',
			border = 'rounded',
		},
		separate_save_and_remove = false, -- if true, will remove the toggle and create the save/remove keymaps.
		index_keys = '123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP', -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
	})
end

return M
