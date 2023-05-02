local M = {}
local keymap = utils.api.keymap

function M.setup()
	local is_installed, telescope = pcall(require, 'telescope')

	if is_installed then
		local b = require('telescope.builtin')
		local e = telescope.extensions
		keymap('n', '<leader>sf', b.find_files, { desc = '[S]earch [F]iles' })
		keymap('n', '<leader>smf', e.media_files.media_files, { desc = '[S]earch [M]edia [F]iles' })
		keymap('n', '<leader>sg', e.live_grep_args.live_grep_args, { desc = '[S]earch by [G]rep' })
		keymap('n', '<leader>s/', b.current_buffer_fuzzy_find, { desc = 'Search in file' })
		keymap('n', '<leader>sk', b.keymaps, { desc = '[S]earch [K]eymaps' })
		keymap('n', '<leader>sof', b.oldfiles, { desc = '[S]earch [O]ld [F]iles' })
		keymap('n', '<leader>sh', b.help_tags, { desc = '[S]earch [H]elp' })
		keymap('n', '<leader>sw', ':Telescope grep_string<CR>', { desc = '[S]earch [W]ord' })
	end

	return {
		'nvim-telescope/telescope.nvim',
		event = { 'VimEnter' },
		config = M.config,
	}
end

local c = require('utils.colors')
M.highlights = {
	TelescopeTitle = { fg = c.secondary, bold = true },
	TelescopeNormal = { bg = 'None', ctermbg = 'White' }, -- ctermbg white faz ficar transparente
	TelescopeBorder = { fg = '#488dff' },
	TelescopeMatching = { fg = c.secondary },
	TelescopePromptPrefix = { bg = 'None', ctermbg = 'White' },
	TelescopePromptCounter = { bg = 'None', ctermbg = 'White' },
}

function M.config()
	local telescope = require('telescope')
	local icons = require('utils.icons')

	local git_icons = {
		added = icons.git.Add,
		changed = icons.git.Mod,
		copied = '>',
		deleted = icons.git.Remove,
		renamed = icons.git.Rename,
		unmerged = icons.git.Unmerged,
		untracked = icons.git.Untracked,
	}

	telescope.setup({
		defaults = {
			-- Default configuration for telescope goes here:
			-- config_key = value,
			file_ignore_patterns = { 'node_modules', '.venv' },
			mappings = {
				i = {
					-- map actions.which_key to <C-h> (default: <C-/>)
					-- actions.which_key shows the mappings for your picker,
					-- e.g. git_{create, delete, ...}_branch for the git_branches picker
					['<C-k>'] = 'move_selection_next',
					['<C-l>'] = 'move_selection_previous',
					['<CR>'] = 'select_default',
					['<C-h>'] = 'which_key',
					['<C-c>'] = 'close',
				},
				n = {
					['t'] = 'select_tab',
					['<C-k>'] = 'move_selection_next',
					['k'] = 'move_selection_next',
					['<C-l>'] = 'move_selection_previous',
					['l'] = 'move_selection_previous',
					['v'] = 'select_vertical',
					['<C-c>'] = 'close',
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,       -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = 'smart_case', -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
			},
		},
		layout_config = {
			horizontal = { preview_cutoff = 120 },
			prompt_position = 'top',
		},
		file_sorter = require('telescope.sorters').get_fzy_sorter,
		prompt_prefix = '  ',
		color_devicons = true,
		git_icons = git_icons,
		sorting_strategy = 'ascending',
		file_previewer = require('telescope.previewers').vim_buffer_cat.new,
		grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
		qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
	})

	telescope.load_extension('fzf')
	telescope.load_extension('media_files')
end

return M
