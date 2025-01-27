local M = {}

function M.setup()
	return {
		'nvim-telescope/telescope.nvim',
		config = M.config,
		dependencies = {
			'nvim-telescope/telescope-media-files.nvim', -- mostra arquivos de mídia
			'debugloop/telescope-undo.nvim', -- undo true
			'danielfalk/smart-open.nvim',
			'fdschmidt93/telescope-egrepify.nvim',
			'kkharji/sqlite.lua',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make', -- no wsl, é necessário fazer um `make ~/.local/share/nvim/lazy/telescope-fzf-native.nvim`
			},
			'nvim-telescope/telescope-fzy-native.nvim',
		},
		keys = {
			--  ╭──────────────────────────────────────────────────────────╮
			--  │                         Builtin                          │
			--  ╰──────────────────────────────────────────────────────────╯
			{
				'<leader>sg',
				function() require('telescope').extensions.egrepify.egrepify() end,
				desc = '[S]earch by [G]rep',
			},

			-- Procurar palavra (buffer)
			{
				'<leader>sb',
				function() require('telescope.builtin').current_buffer_fuzzy_find() end,
				desc = '[S]earch [B]uffer',
			},
			{
				'<leader>sb',
				function()
					local selection = utils.get_visual_selection()
					require('telescope.builtin').current_buffer_fuzzy_find()
					vim.schedule(function() utils.api.feedkeys('i' .. selection) end)
				end,
				mode = 'x',
				desc = '[S]earch [B]uffer',
			},

			-- Procurar palavra (global)
			{
				'<leader>sw',
				function() require('telescope.builtin').grep_string() end,
				desc = '[S]earch [W]ord',
			},
			{
				'<leader>sw',
				function() require('telescope.builtin').grep_string({ search = '"' .. utils.get_visual_selection() .. '"' }) end,
				mode = 'x',
				desc = '[S]earch [W]ord',
			},
			{
				'<leader>sk',
				function() require('telescope.builtin').keymaps() end,
				desc = '[S]earch [K]eymaps',
			},
			{
				'<leader>sh',
				function() require('telescope.builtin').help_tags() end,
				desc = '[S]earch [H]elp',
			},
			--  ╭──────────────────────────────────────────────────────────╮
			--  │                        Extension                         │
			--  ╰──────────────────────────────────────────────────────────╯
			{
				'<leader>sf',
				function() require('telescope').extensions.smart_open.smart_open({ cwd_only = true }) end,
				desc = '[S]earch [F]iles',
			},
			{
				'<leader>smf',
				function() require('telescope').extensions.media_files.media_files() end,
				desc = '[S]earch [M]edia [F]iles',
			},
			{
				'<leader>sy',
				function() require('telescope').extensions.neoclip.default() end,
				desc = '[S]earch [Y]anks',
			},
			{
				'<leader>su',
				function() require('telescope').extensions.undo.undo() end,
				desc = '[S]earch [U]ndos',
			},
		},
	}
end

function M.config()
	local telescope = require('telescope')
	local icons = require('utils.icons')

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
					---@diagnostic disable-next-line: undefined-field
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
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = 'smart_case', -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
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
				vim_diff_opts = { ctxlen = 6 },
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
			egrepify = {
				AND = true,
				permutations = false,
				lnum = false,
				mappings = {},
			},
		},
	})

	telescope.load_extension('fzf')
	telescope.load_extension('undo')
	telescope.load_extension('media_files')
	telescope.load_extension('smart_open')
	telescope.load_extension('neoclip')
	telescope.load_extension('egrepify')
end

M.highlights = {
	TelescopeTitle = { fg = c.secondary, bold = true },
	TelescopeNormal = { bg = 'None', ctermbg = 'White' }, -- ctermbg white faz ficar transparente
	TelescopePromptBorder = { fg = '#488dff' },
	TelescopeBorder = { fg = '#488dff' },
	TelescopeMatching = { fg = c.secondary },
	TelescopePromptPrefix = { bg = 'None', ctermbg = 'White' },
	TelescopePromptCounter = { bg = 'None', ctermbg = 'White' },
}

return M
