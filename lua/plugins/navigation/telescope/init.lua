local M = {}

function M.setup()
	return {
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		config = M.config,
		lazy = true,
		keys = M.keys,
	}
end

function M.keys()
	local telescope_ok, telescope = pcall(require, 'telescope')
	if not telescope_ok then return {} end

	local b, e = require('telescope.builtin'), telescope.extensions
	local mappings = {
		-- Builtin
		{ '<leader>sg',  b.live_grep,                 desc = '[S]earch by [G]rep' },
		{ '<leader>sb',  b.current_buffer_fuzzy_find, desc = '[S]earch [B]uffer' },
		{ '<leader>sk',  b.keymaps,                   desc = '[S]earch [K]eymaps' },
		{ '<leader>sof', b.oldfiles,                  desc = '[S]earch [O]ld [F]iles' },
		{ '<leader>sh',  b.help_tags,                 desc = '[S]earch [H]elp' },
		{ '<leader>sw',  b.grep_string,               desc = '[S]earch [W]ord' },
		{
			'<leader>sw',
			function() return b.grep_string({ search = '"' .. utils.get_visual_selection() .. '"' }) end,
			mode = 'x',
			desc = '[S]earch [W]ord',
		},
		-- Extension
		{
			'<leader>sf',
			function() e.smart_open.smart_open({ cwd_only = true }) end,
			desc = '[S]earch [F]iles',
		},
		{ '<leader>smf', e.media_files.media_files, desc = '[S]earch [M]edia [F]iles' },
		{ '<leader>sy',  e.neoclip.default,         desc = '[S]earch [Y]anks' },
		{ '<leader>su',  e.undo.undo,               desc = '[S]earch [U]ndos' },
	}
	for _, mapping in ipairs(mappings) do
		mapping.silent = true
	end
	return mappings
end

function M.config()
	local telescope = require('telescope')
	local icons = require('utils.icons')

	-- Por algum motivo, as vezes as keys que eu botei no lazy não funcionam
	-- Isso aqui é um workaround pra fazer as keympas funcionarem
	for _, mapping in ipairs(M.keys()) do
		utils.api.keymap(mapping.mode or 'n', mapping[1], mapping[2], { desc = mapping.desc })
	end

	-- Custom previewer
	local previewers = require('telescope.previewers')
	local Job = require('plenary.job')
	local preview_maker = function(filepath, bufnr, opts)
		filepath = vim.fn.expand(filepath)
		Job:new({
			command = 'file',
			args = { '--mime-type', '-b', filepath },
			on_exit = function(j)
				local mime_type = vim.split(j:result()[1], '/')[1]

				if mime_type == 'text' then
					-- Check file size
					vim.loop.fs_stat(filepath, function(_, stat)
						if not stat then return end
						if stat.size > 500000 then
							return
						else
							previewers.buffer_previewer_maker(filepath, bufnr, opts)
						end
					end)
				else
					vim.schedule(function() vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY FILE' }) end)
				end
			end,
		}):sync()
	end

	local ignore_patterns = {
		'.git',
		'.venv',
		'node_modules',
		'*.jpg',
		'*.jpeg',
		'*.png',
		'*.lock',
		-- Flutter/Dart/Pub related
		'.dart_tool/',
		'.idea',
		'android',
		'build/',
		'out/',
		'ios',
		'linux',
		'macos',
		'web',
		'windows',
		'.metadata',
		'%.iml',
	}

	local get_mappings = require('plugins.navigation.telescope.mappings')

	telescope.setup({
		defaults = { mappings = get_mappings() },
		selection_caret = ' ',
		buffer_previewer_maker = preview_maker,
		pickers = {
			find_files = {
				file_ignore_patterns = ignore_patterns,
				hidden = true,
			},
			live_grep = {
				glob_pattern = vim.tbl_map(function(pattern) return '!' .. pattern end, ignore_patterns),
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,               -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = 'smart_case',   -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
			},
			media_files = {
				filetypes = { 'png', 'webp', 'jpg', 'jpeg', 'pdf', 'mp4', 'webm' },
				find_cmd = 'fd',
			},
			smart_open = {
				show_scores = false,
				ignore_patterns = ignore_patterns,
				match_algorithm = 'fzf',
				disable_devicons = false,
			},
			undo = {
				use_delta = true,
				diff_context_lines = vim.o.scrolloff,
				entry_format = '#$ID, $STAT, $TIME',
				side_by_side = true,
				layout_strategy = 'vertical',
				layout_config = { preview_height = 0.70 },
				time_format = '',
				mappings = {
					i = {
						['<cr>'] = require('telescope-undo.actions').yank_additions,
						['<S-cr>'] = require('telescope-undo.actions').yank_deletions,
						['<C-cr>'] = require('telescope-undo.actions').restore,
					},
					n = {
						['y'] = require('telescope-undo.actions').yank_additions,
						['Y'] = require('telescope-undo.actions').yank_deletions,
						['u'] = require('telescope-undo.actions').restore,
					},
				},
			},
		},
		layout_config = {
			horizontal = { preview_cutoff = 120 },
			prompt_position = 'top',
		},
		file_sorter = require('telescope.sorters').get_fzy_sorter,
		prompt_prefix = '  ',
		color_devicons = true,
		git_icons = {
			added = icons.git.Add,
			changed = icons.git.Mod,
			copied = '>',
			deleted = icons.git.Remove,
			renamed = icons.git.Rename,
			unmerged = icons.git.Unmerged,
			untracked = icons.git.Untracked,
		},
		sorting_strategy = 'ascending',
		file_previewer = require('telescope.previewers').vim_buffer_cat.new,
		grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
		qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
	})

	telescope.load_extension('fzf')
	telescope.load_extension('undo')
	telescope.load_extension('media_files')
	telescope.load_extension('smart_open')
	telescope.load_extension('neoclip')
end

M.highlights = {
	TelescopeTitle = { fg = c.secondary, bold = true },
	TelescopeNormal = { bg = 'None', ctermbg = 'White' }, -- ctermbg white faz ficar transparente
	TelescopeBorder = { fg = '#488dff' },
	TelescopeMatching = { fg = c.secondary },
	TelescopePromptPrefix = { bg = 'None', ctermbg = 'White' },
	TelescopePromptCounter = { bg = 'None', ctermbg = 'White' },
}

return M
