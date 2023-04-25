local M = {}
local map = require("utils").map

function M.setup()
	map("n", "<leader>sf", ":Telescope find_files<CR>", { desc = "[S]earch [F]iles" })
	map("n", "<leader>smf", ":Telescope media_files<CR>", { desc = "[S]earch [M]edia [F]iles" })
	map("n", "<leader>sg", ":Telescope live_grep<CR>", { desc = "[S]earch by [G]rep" })
	map("n", "<leader>s/", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Search in file" })
	map("n", "<leader>sk", ":Telescope keymaps<CR>", { desc = "[S]earch [K]eymaps" })
	map("n", "<leader>sof", ":Telescope oldfiles<CR>", { desc = "[S]earch [O]ld [F]iles" })
	map("n", "<leader>sh", ":Telescope help_tags<CR>", { desc = "[S]earch [H]elp" })
	map("n", "<leader>sw", ":Telescope grep_string<CR>", { desc = "[S]earch [W]ord" })
	map("n", "<leader>sd", ":Telescope diagnostics<CR>", { desc = "[S]earch [D]iagnostics" })

	return {
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		event = { "VimEnter" },
		config = M.config,
	}
end

local c = require("utils.colors")
M.highlights = {
	TelescopeTitle = { fg = c.secondary, bold = true },
	TelescopeNormal = { bg = "None", ctermbg = "White" }, -- ctermbg white faz ficar transparente
	TelescopeBorder = { fg = "#488dff" },
	TelescopeMatching = { fg = c.secondary },
	TelescopePromptPrefix = { bg = "None", ctermbg = "White" },
	TelescopePromptCounter = { bg = "None", ctermbg = "White" },
}

function M.config()
	local telescope = require("telescope")
	local icons = require("utils.icons")

	local git_icons = {
		added = icons.git.Add,
		changed = icons.git.Mod,
		copied = ">",
		deleted = icons.git.Remove,
		renamed = icons.git.Rename,
		unmerged = icons.git.Unmerged,
		untracked = icons.git.Untracked,
	}

	telescope.setup({
		defaults = {
			-- Default configuration for telescope goes here:
			-- config_key = value,
			file_ignore_patterns = { "node_modules", ".venv" },
			mappings = {
				i = {
					-- map actions.which_key to <C-h> (default: <C-/>)
					-- actions.which_key shows the mappings for your picker,
					-- e.g. git_{create, delete, ...}_branch for the git_branches picker
					["<C-k>"] = "move_selection_next",
					["<C-l>"] = "move_selection_previous",
					["<CR>"] = "select_default",
					["<C-h>"] = "which_key",
					["<C-c>"] = "close",
				},
				n = {
					["t"] = "select_tab",
					["<C-k>"] = "move_selection_next",
					["k"] = "move_selection_next",
					["<C-l>"] = "move_selection_previous",
					["l"] = "move_selection_previous",
					["v"] = "select_vertical",
					["<C-c>"] = "close",
				},
			},
		},
		pickers = {
			-- Default configuration for builtin pickers goes here:
			-- picker_name = {
			--   picker_config_key = value,
			--   ...
			-- }
			-- Now the picker_config_key will be applied every time you call this
			-- builtin picker
		},
		extensions = {
			-- Your extension configuration goes here:
			-- extension_name = {
			--   extension_config_key = value,
			-- }
			-- please take a look at the readme of the extension you want to configure
			fzf = {
				override_generic_sorter = false,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
		-- vimgrep_arguments = {
		-- 	"rg",
		-- 	"--color=never",
		-- 	"--no-heading",
		-- 	"--with-filename",
		-- 	"--line-number",
		-- 	"--column",
		-- 	"--smart-case",
		-- },
		layout_config = {
			horizontal = {
				preview_cutoff = 120,
			},
			prompt_position = "top",
		},
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		prompt_prefix = "  ",
		color_devicons = true,
		git_icons = git_icons,
		sorting_strategy = "ascending",
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
	})

	telescope.load_extension("fzf")
	telescope.load_extension("media_files")
end

return M
