local M = {}
local keymap = utils.api.keymap

M.setup = function()
	keymap('n', '<A-e>', ':NvimTreeToggle<CR>')

	return {
		'nvim-tree/nvim-tree.lua',
		config = M.config,
	}
end

M.config = function()
	local tree = require('nvim-tree')

	local lib = require('nvim-tree.lib')
	local api = require('nvim-tree.api')

	-- Automatically open file upon creation
	api.events.subscribe(api.events.Event.FileCreated, function(file) vim.cmd('edit ' .. file.fname) end)

	local function open_nvim_tree(data)
		local IGNORED_FT = { 'gitcommit' }

		-- buffer is a real file on the disk
		local is_real_file = (vim.fn.filereadable(data.file) == 1)

		-- buffer is a [No Name]
		local no_name = data.file == '' and vim.bo[data.buf].buftype == ''

		-- &ft
		local filetype = vim.bo[data.buf].ft

		-- only files please
		if not is_real_file and not no_name then return end

		-- skip ignored filetypes
		if vim.tbl_contains(IGNORED_FT, filetype) then return end

		local is_directory = (vim.fn.isdirectory(data.file) == 1)
		if is_directory then
			vim.cmd.enew() -- create a new, empty buffer
			vim.cmd.bw(data.buf) -- wipe the directory buffer
			vim.cmd.cd(data.file) -- change to the directory
		end

		api.tree.toggle({ focus = false, find_file = true })
	end

	vim.api.nvim_create_autocmd('VimEnter', { callback = open_nvim_tree })

	local function tab_win_closed(winnr)
		local tabnr = vim.api.nvim_win_get_tabpage(winnr)
		local bufnr = vim.api.nvim_win_get_buf(winnr)
		local buf_info = vim.fn.getbufinfo(bufnr)[1]
		local tab_wins = vim.tbl_filter(function(w) return w ~= winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
		local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
		if buf_info.name:match('.*NvimTree_%d*$') then -- close buffer was nvim tree
			-- Close all nvim tree on :q
			if not vim.tbl_isempty(tab_bufs) then -- and was not the last window (not closed automatically by code below)
				api.tree.close()
			end
		else                                            -- else closed buffer was normal buffer
			if #tab_bufs == 1 then                      -- if there is only 1 buffer left in the tab
				local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
				if last_buf_info.name:match('.*NvimTree_%d*$') then -- and that buffer is nvim tree
					vim.schedule(function()
						if #vim.api.nvim_list_wins() == 1 then -- if its the last buffer in vim
							-- vim.cmd "quit" -- then close all of vim
						else                            -- else there are more tabs open
							vim.cmd('NvimTreeOpen')
							vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
						end
					end)
				end
			end
		end
	end

	vim.api.nvim_create_autocmd('WinClosed', {
		callback = function()
			local winnr = tonumber(vim.fn.expand('<amatch>'))
			vim.schedule_wrap(pcall(tab_win_closed, winnr))
		end,
		nested = true,
	})

	local swap_then_open_tab = function()
		local node = lib.get_node_at_cursor()
		if node == nil then return end
		vim.cmd('wincmd l')
		api.node.open.tab(node)
	end

	local function collapse_all() require('nvim-tree.actions.tree-modifiers.collapse-all').fn() end

	local function expand()
		-- open as vsplit on current node
		local node = lib.get_node_at_cursor()
		if node == nil then return end

		if node.nodes ~= nil then lib.expand_or_collapse(node) end
	end

	local git_add = function()
		local node = lib.get_node_at_cursor()
		local gs = node.git_status.file

		-- If the file is untracked, unstaged or partially staged, we stage it
		if gs == '??' or gs == 'MM' or gs == 'AM' or gs == ' M' then
			vim.cmd('silent !git add ' .. node.absolute_path)

			-- If the file is staged, we unstage
		elseif gs == 'M ' or gs == 'A ' then
			vim.cmd('silent !git restore --staged ' .. node.absolute_path)
		end
	end

	local function open_tab_silent(node)
		api.node.open.tab(node)
		vim.cmd.tabprev()
	end

	local icons = require('utils.icons')

	tree.setup({
		tab = {
			sync = {
				open = true,
				close = true,
				ignore = { 'gitcommit' },
			},
		},
		disable_netrw = false,               -- disables netrw completely
		hijack_netrw = true,                 -- hijack netrw window on startup
		hijack_cursor = false,               -- hijack the cursor in the tree to put it at the start of the filename
		hijack_unnamed_buffer_when_opening = true, -- opens in place of the unnamed buffer if it's empty
		open_on_tab = false,                 -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
		update_cwd = true,                   -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
		--false by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree
		respect_buf_cwd = false,
		-- show lsp diagnostics in the signcolumn
		notify = { threshold = vim.log.levels.WARN },
		diagnostics = {
			enable = false,
			show_on_dirs = false,
			icons = {
				hint = icons.diagnostics.Hint,
				info = icons.diagnostics.Information,
				warning = icons.diagnostics.Warning,
				error = icons.diagnostics.Error,
			},
		},
		on_attach = function(bufnr)
			local function opts(desc)
				return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end
			vim.keymap.set('n', 'o', api.node.open.no_window_picker, opts('Open: No Window Picker'))
			vim.keymap.set('n', 't', swap_then_open_tab, opts('swap_then_open_tab'))
			vim.keymap.set('n', 'ç', expand, opts('expand'))
			vim.keymap.set('n', 'j', api.node.navigate.parent_close, opts('Close Directory'))
			vim.keymap.set('n', 'J', collapse_all, opts('Collapse'))
			vim.keymap.set('n', 'ga', git_add, opts('git_add'))
			vim.keymap.set('n', 'T', open_tab_silent, opts('open_tab_silent'))
			vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
			vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
			vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
			vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
			vim.keymap.set('n', 'L', api.node.navigate.sibling.first, opts('First Sibling'))
			vim.keymap.set('n', 'K', api.node.navigate.sibling.last, opts('Last Sibling'))
			vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
			vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
			vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
			vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
			vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
			vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
			vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
			vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
			vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
			vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
			vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
			vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
			vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
			vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
			vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
		end,
		renderer = {
			add_trailing = false,
			group_empty = false, -- folders that only contain a single folder into one node in the file tree
			highlight_git = true,
			highlight_opened_files = 'none',
			root_folder_modifier = ':~',
			indent_markers = { enable = false },
			root_folder_label = ':~:s?$?/..?',
			icons = {
				glyphs = {
					default = icons.ui.Text,
					symlink = icons.ui.FileSymlink,
					bookmark = icons.ui.BookMark,
					folder = {
						arrow_closed = icons.ui.TriangleShortArrowRight,
						arrow_open = icons.ui.TriangleShortArrowDown,
						default = icons.ui.Folder,
						open = icons.ui.FolderOpen,
						empty = icons.ui.EmptyFolder,
						empty_open = icons.ui.EmptyFolderOpen,
						symlink = icons.ui.FolderSymlink,
						symlink_open = icons.ui.FolderOpen,
					},
					git = {
						unstaged = icons.git.Unstaged, --"",
						staged = icons.git.Staged, --"",
						unmerged = icons.git.Unmerged, --"",
						renamed = icons.git.Rename, --"➜",
						untracked = icons.git.Untracked, --"",
						deleted = icons.git.Remove, --"",
						ignored = icons.git.Ignore, --"◌",
					},
				},
			},
		},
		-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
		hijack_directories = {
			enable = true,
			auto_open = true,
		},
		update_focused_file = {
			enable = true,
			update_cwd = true, -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
			ignore_list = { 'gitcommit' },
		},
		-- configuration options for the system open command (`s` in the tree by default)
		system_open = {
			-- the command to run this, leaving nil should work in most cases
			cmd = '',
			-- the command arguments as a list
			args = {},
		},
		filters = {
			dotfiles = false,
			git_clean = false,
			no_buffer = false,
			custom = { 'node_modules', '\\.cache', '.null-ls.*' },
			exclude = {},
		},
		git = { enable = true, ignore = false, timeout = 500 },
		actions = {
			use_system_clipboard = true,
			change_dir = {
				enable = true,
				global = false,
				restrict_above_cwd = false,
			},
			open_file = {
				quit_on_open = false,
				resize_window = true, -- if true the tree will resize itself after opening a file
			},
		},
		view = {
			-- adaptive_size = false, -- Ajusta o seu tamanho automaticamente com base no tamanho do nome dos arquivos do projeto.
			-- width of the window, can be either a number (columns) or a string in `%`
			width = 30,
			-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
			side = 'left',
			number = false,
			relativenumber = false,
		},
		trash = {
			cmd = 'trash',
			require_confirm = true,
		},
	})
end

local c = require('utils.colors')
M.highlights = {
	-- NvimTreeGitDirty = { fg = "None" },
	-- NvimTreeGitNew = { fg = "None" },
	-- NvimTreeGitIgnored = { fg = "None" },
	-- NvimTreeOpenedFile = { fg = c.primary, bold = true },
	NvimTreeCursorLine = { fg = c.secondary, bg = c.bg_highlight, bold = true },
	-- NvimTreeGitDeleted = { fg = colors.red },
	-- NvimTreeSpecialFile = { fg = colors.yellow, bold = true },
	-- NvimTree
	-- hl(0, "NvimTreeFolderIcon", { link = "Directory" })
	-- hl(0, "NvimTreeIndentMarker", { fg = c.context, bg = "NONE" })
	-- hl(0, "NvimTreeNormal", { fg = c.fg, bg = c.alt_bg })
	-- hl(0, "NvimTreeVertSplit", { fg = c.alt_bg, bg = c.alt_bg })
	-- hl(0, "NvimTreeFolderName", { link = "Directory" })
	-- hl(0, "NvimTreeOpenedFolderName", { fg = c.folder_blue, bg = "NONE", bold = true, italic = true })
	-- hl(0, "NvimTreeEmptyFolderName", { fg = c.gray, bg = "NONE", italic = true })
	-- hl(0, "NvimTreeGitIgnored", { fg = c.gray, bg = "NONE", italic = true })
	-- hl(0, "NvimTreeImageFile", { fg = c.light_gray, bg = "NONE" })
	-- hl(0, "NvimTreeSpecialFile", { fg = c.orange, bg = "NONE" })
	-- hl(0, "NvimTreeEndOfBuffer", { fg = c.alt_bg, bg = "NONE" })
	-- hl(0, "NvimTreeCursorLine", { fg = "NONE", bg = c.line })
	-- hl(0, "NvimTreeGitStaged", { fg = c.sign_add_alt, bg = "NONE" })
	-- hl(0, "NvimTreeGitNew", { fg = c.sign_add_alt, bg = "NONE" })
	-- hl(0, "NvimTreeGitRenamed", { fg = c.sign_add_alt, bg = "NONE" })
	-- hl(0, "NvimTreeGitDeleted", { fg = c.sign_delete, bg = "NONE" })
	-- hl(0, "NvimTreeGitMerge", { fg = c.sign_change_alt, bg = "NONE" })
	-- hl(0, "NvimTreeGitDirty", { fg = c.sign_change_alt, bg = "NONE" })
	-- hl(0, "NvimTreeSymlink", { fg = c.cyan, bg = "NONE" })
	-- hl(0, "NvimTreeRootFolder", { fg = c.fg, bg = "NONE", bold = true })
	-- hl(0, "NvimTreeExecFile", { fg = "#9FBA89", bg = "NONE" })
}

return M
