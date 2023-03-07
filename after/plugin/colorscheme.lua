local tokyonight = require("tokyonight")

-- vim.g.jellybeans_overrides = { background = { ctermbg = "none", guibg = "none", }, }
-- vim.cmd("silent! colorscheme jellybeans")

-- local c = require("tokyonight.colors").setup()
local c = require("utils.colors")

local general_highlights = {
	Boolean = { fg = "#F7768E" },
	CursorLineNR = { fg = c.secondary },
	BufferOffset = { fg = c.secondary },
	StatusLineNC = { bg = "None" },
}

local telescope_highlights = {
	TelescopeTitle = { fg = c.secondary, style = "bold" },
	TelescopeNormal = {},
	TelescopeBorder = { fg = "#488dff" },
	TelescopeMatching = { fg = c.secondary },
	MsgArea = {},
}
local cmp_highlights = {
	-- nvim cmp
	PmenuSel = { bg = "#282C34", fg = "NONE" },
	Pmenu = { fg = "#C5CDD9", bg = "#22252A" },
	CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", style = "strikethrough" },
	CmpItemAbbrMatch = { fg = c.secondary, bg = "NONE", style = "bold" },
	CmpItemAbbrMatchFuzzy = { fg = c.secondary, bg = "NONE", style = "bold" },
	CmpItemMenu = { fg = "#C792EA", bg = "NONE", style = "italic" },
	CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
	CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
	CmpItemAbbr = { fg = "White", bg = "NONE" },
	-- cmp item kinds
	CmpItemKindText = { fg = "LightGrey" },
	CmpItemKindFunction = { fg = "#C586C0" },
	CmpItemKindClass = { fg = "Orange" },
	CmpItemKindKeyword = { fg = "#f90c71" },
	CmpItemKindSnippet = { fg = "#565c64" },
	CmpItemKindConstructor = { fg = "#ae43f0" },
	CmpItemKindVariable = { fg = "#9CDCFE", bg = "NONE" },
	CmpItemKindInterface = { fg = "#f90c71", bg = "NONE" },
	CmpItemKindFolder = { fg = "#2986cc" },
	CmpItemKindReference = { fg = "#922b21" },
	CmpItemKindMethod = { fg = "#C586C0" },
	CmpItemKindCopilot = { fg = "#6CC644" },
}

-- Set Colorscheme
tokyonight.setup({
	style = "night",
	transparent = true, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value `:help attr-list`
		comments = "italic",
		keywords = "italic",
		functions = "bold",
		variables = "NONE",
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "transparent", -- style for sidebars, see below
		floats = "dark", -- style for floating windows
	},
	sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false, -- dims inactive windows
	lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
	--- You can override specific color groups to use other groups or a hex color
	--- function will be called with a ColorScheme table
	on_colors = function(colors)
		colors.border = "#1A1B26"
	end,
	--- You can override specific highlights to use other groups or a hex color
	--- fucntion will be called with a Highlights and ColorScheme table
	-- on_highlights = function(highlights, colors) end,
	on_highlights = function(hl, _)
		local all_highlights = {
			general_highlights,
			telescope_highlights,
			cmp_highlights,
		}

		for _, h in ipairs(all_highlights) do
			for group, color in pairs(h) do
				hl[group] = color
			end
		end
	end,
})

vim.cmd("colorscheme tokyonight")

-- Tokyonight Colorscheme Specific Config
-- Lines
-- vim.api.nvim_set_hl(0, "CursorLineNR", { link = "EcovimSecondary" })
-- vim.api.nvim_set_hl(0, "LineNr", { link = "Comment" })

-- Floats/Windows
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "None", fg = "None" })
-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "None", fg = "#488DFF" })
-- vim.api.nvim_set_hl(0, "BufferTabpageFill", { fg = "None" })
-- vim.api.nvim_set_hl(0, "VertSplit", { bg = "#16161e", fg = "#16161e" })
-- vim.api.nvim_set_hl(0, "BqfPreviewBorder", { link = "FloatBorder" })

-- Tree
-- vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { bg = "None", fg = "None" })

-- Diagnostics
