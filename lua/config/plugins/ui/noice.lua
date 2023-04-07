local M = {}

function M.setup()
	return {
		"folke/noice.nvim", -- messages, cmdline and popupmenu
		event = { "VimEnter" },
		config = M.config,
	}
end

function M.config()
	local cmdline_popup = {
		position = { row = 5, col = "50%" },
		size = { width = 60, height = "auto" },
	}

	local popupmenu = {
		relative = "editor",
		position = { row = 8, col = "50%" },
		size = { width = 60, height = 10 },
		border = { style = "rounded", padding = { 0, 1 } },
		win_options = { winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" } },
	}

	local hide_written_messages = {
		filter = { event = "msg_show", kind = "", find = "written" },
		opts = { skip = true },
	}
	local hide_search_virtual_text = {
		filter = { event = "msg_show", kind = "search_count" },
		opts = { skip = true },
	}

	require("noice").setup({
		-- views = {
		-- 	cmdline_popup = cmdline_popup,
		-- 	popupmenu = popupmenu,
		-- },
		cmdline = { view = "cmdline" }, -- classic cmdline
		routes = {
			hide_written_messages,
			hide_search_virtual_text,
		},
		lsp = {
			progress = { enabled = false },
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = false, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false,  -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
	})
end

return M
