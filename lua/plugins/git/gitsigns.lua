local M = {}

function M.setup()
	return {
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = M.config,
	}
end

function M.config()
	local function on_attach(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		-- Actions
		map({ "n", "v" }, "<leader>gha", ":Gitsigns stage_hunk<CR>", { desc = "[G]it [H]unk [A]dd" })
		map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
		map("n", "<leader>ghA", gs.stage_buffer, { desc = "Stage Buffer" })
		map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
		map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Buffer" })
		map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview Hunk" })
		map("n", "<leader>ghb", function()
			gs.blame_line({ full = true })
		end, { desc = "Blame Line" })
		map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })
		map("n", "<leader>ghd", gs.diffthis, { desc = "Diff This" })
		map("n", "<leader>ghD", function()
			gs.diffthis("~")
		end, { desc = "Diff This ~" })
		map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle Delete" })

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })
	end

	require("gitsigns").setup({
		signs = {
			add = { hl = "GitSignsAdd", text = "▍", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
			change = {
				hl = "GitSignsChange",
				text = "▍",
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
			delete = {
				hl = "GitSignsDelete",
				text = "▸",
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			topdelete = {
				hl = "GitSignsDelete",
				text = "▾",
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			changedelete = {
				hl = "GitSignsChange",
				text = "▍",
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
		},
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		sign_priority = 6,
		status_formatter = nil, -- Use default
		update_debounce = 200,
		max_file_length = 40000,
		preview_config = {
			-- Options passed to nvim_open_win
			border = "rounded",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		yadm = { enable = false },
		on_attach = on_attach,
	})
end

return M