local M = {}

function M.setup()
	return {
		"mg979/vim-visual-multi",
		init = M.config,
	}
end

function M.config()
	vim.g.VM_default_mappings = 0
	vim.g.VM_show_warnings = 0

	vim.api.nvim_set_var("VM_leader", {
		default = " ",
		visual = " ",
		buffer = "z",
	})

	vim.api.nvim_set_var("VM_maps", {
		["Undo"] = "u",
		["Redo"] = "<C-r>",
		["Find Under"] = "<C-n>",
		["Find Subword Under"] = "<C-n>",
		["Select All"] = "<leader>A",
		["Add Cursor Up"] = "<C-M-l>",
		["Add Cursor Down"] = "<C-M-k>",
	})

	vim.g.VM_custom_motions = {
		["j"] = "h",
		["k"] = "j",
		["l"] = "k",
		["ç"] = "l",
	}
end

return M
