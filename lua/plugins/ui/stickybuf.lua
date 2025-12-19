local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'stevearc/stickybuf.nvim',
		config = M.config,
	}
end

function M.config()
	require('stickybuf').setup({
		get_auto_pin = function(bufnr)
			-- You can return "bufnr", "buftype", "filetype", or a custom function to set how the window will be pinned.
			-- You can instead return an table that will be passed in as "opts" to `stickybuf.pin`.
			-- The function below encompasses the default logic. Inspect the source to see what it does.

      -- Filetypes suportardos built-in
			-- "aerial", "nerdtree", "neotest-summary", "startuptime", "toggleterm", "fugitive", "notify", "fugitiveblame",
			-- "neo-tree", "GoogleKeepList", "GoogleKeepMenu", "NvimTree", "OverseerList", "spectre_panel", "grug-far",

			return require('stickybuf').should_auto_pin(bufnr)
		end,
	})
end

return M
