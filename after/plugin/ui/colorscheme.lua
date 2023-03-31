local tokyonight = require("tokyonight")

-- local colors = require("tokyonight.colors")
local c = require("utils.colors")

local general_highlights = {
	CursorLineNR = { fg = c.secondary },
	BufferOffset = { fg = c.secondary },
	-- StatusLineNC = { bg = "None" },
	-- """ Vim editor
	-- LineNr= { fg = "#5B6268", bg = "None" },
	FloatBorder  = { bg = "None" },
	Boolean = { fg = c.red },
	Conditional = { fg = c.purple },
	-- Cursor = { fg = c.bg, bg = c.white },
	-- CursorColumn = { fg = c.bg },
	-- CursorLine = { fg = c.white, bg = c.black },
	-- Directory = { fg = c.comments, bg = c.bg },
	-- EndOfBuffer = { fg = "None", bg = "None" },
	ErrorMsg = { fg = c.red, bg = c.bg, underline = true },
	Float = { fg = c.red },
	Folded = { fg = c.bg, bg = c.comments },
	Keyword = { fg = c.purple },
	Label = { fg = c.green },
	LineNr = { fg = c.comments },
	MatchParen = { fg = c.white, bg = c.comments },
	ModeMsg = { fg = "None", bg = "None" },
	NonText = { fg = c.invisibles, bg = c.bg },
	-- Normal = { fg = c.white, bg = c.bg },
	Number = { fg = c.orange },
	-- Pmenu = { fg = c.white, bg = c.invisibles },
	-- PmenuSel = { fg = c.bg, bg = c.yellow },
	-- PmenuSbar = { bg = c.invisibles },
	-- PmenuThumb = { bg = c.comments },
	Search = { fg = c.bg, bg = c.secondary },
	SpecialComment = { fg = c.comments },
	SpecialKey = { fg = c.invisibles, bg = c.bg },
	-- StatusLine = { fg = c.red, bg = c.comments },
	-- StatusLineNC = { fg = c.red, bg = c.comments },
	StorageClass = { fg = c.purple },
	-- TabLine = { fg = c.comments },
	-- TabLineFill = { fg = "None", bg = "None" },
	-- TabLineSel = { fg = c.cyan },
	Tag = { fg = c.purple },
	-- Terminal = { fg = "None", bg = "None" },
	Title = { fg = c.red },
	VertSplit = { fg = c.black, bg = c.black },
	Visual = { fg = "None", bg = c.invisibles },
}

local telescope_highlights = {
	TelescopeTitle = { fg = c.secondary, style = "bold" },
	TelescopeNormal = { bg = "None", ctermbg = "White" }, -- ctermbg white faz ficar transparente (por algum motivo)
	TelescopeBorder = { fg = "#488dff" },
	TelescopeMatching = { fg = c.secondary },
	TelescopePromptPrefix = { bg = "None" },
	TelescopePromptCounter = {bg = "None"},
}

local cmp_highlights = {
	-- nvim cmp
	-- PmenuSel = { fg = "NONE", bg = "#282C34" },
	-- Pmenu = { fg = "#C5CDD9", bg = "#22252A" },
	CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", style = "strikethrough" },
	CmpItemAbbrMatch = { fg = c.secondary, bg = "NONE", style = "bold" },
	CmpItemAbbrMatchFuzzy = { fg = c.secondary, bg = "NONE", style = "bold" },
	CmpItemMenu = { fg = "#C792EA", bg = "NONE", style = "italic" },
	CmpItemKindColor = { fg = "#D8EEEB", bg = "None" },
	CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "None" },
	-- CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
	-- CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
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

local nvim_tree_highlights = {
	-- NvimTreeFolderName = { fg = "None" },
	-- NvimTreeGitDirty = { fg = "None" },
	-- NvimTreeGitNew = { fg = "None" },
	-- NvimTreeIndentMarker = { fg = "None" },
	-- NvimTreeOpenedFolderName = { fg = "None" },
	-- NvimTreeGitIgnored = { fg = "None" },
	NvimTreeCursorLine = { fg = c.secondary, bold = true },
	-- NvimTreeGitDeleted = { fg = colors.red },
	-- NvimTreeSpecialFile = { fg = colors.yellow, bold = true },
}

-- Set Colorscheme
tokyonight.setup({
	style = "night",
	transparent = true,   -- Enable this to disable setting the background color
	terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value `:help attr-list`
		comments = "italic",
		keywords = "italic",
		functions = "bold",
		variables = "NONE",
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "transparent", -- style for sidebars, see below
		floats = "dark",    -- style for floating windows
	},
	-- sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3,          -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false,          -- dims inactive windows
	lualine_bold = false,          -- When `true`, section headers in the lualine theme will be bold
	--- You can override specific color groups to use other groups or a hex color
	--- function will be called with a ColorScheme table
	on_colors = function(colors)
		-- colors.border = "#1A1B26"
	end,
	--- You can override specific highlights to use other groups or a hex color
	--- fucntion will be called with a Highlights and ColorScheme table
	-- on_highlights = function(highlights, colors) end,
	on_highlights = function(hl, _)
		local all_highlights = {
			telescope_highlights,
			cmp_highlights,
			nvim_tree_highlights,
			general_highlights,
		}

		for _, h in ipairs(all_highlights) do
			for group, color in pairs(h) do
				hl[group] = color
			end
		end
	end,
})
vim.cmd("colorscheme tokyonight")

vim.api.nvim_set_hl(0, "Comment", { fg = c.comments })
vim.api.nvim_set_hl(0, "Todo", { fg = c.comments })
vim.api.nvim_set_hl(0, "Constant", { fg = c.yellow })
vim.api.nvim_set_hl(0, "String", { fg = c.green })
vim.api.nvim_set_hl(0, "Identifier", { fg = c.cyan, bg = c.bg })
vim.api.nvim_set_hl(0, "Type", { fg = c.purple })
vim.api.nvim_set_hl(0, "Function", { fg = c.yellow })
vim.api.nvim_set_hl(0, "Statement", { fg = c.purple })
vim.api.nvim_set_hl(0, "Operator", { fg = c.purple })
vim.api.nvim_set_hl(0, "WarningMsg", { fg = c.orange })
vim.api.nvim_set_hl(0, "PreProc", { fg = c.purple })
vim.api.nvim_set_hl(0, "Define", { fg = c.purple })
vim.api.nvim_set_hl(0, "Special", { fg = c.red })
vim.api.nvim_set_hl(0, "Conceal", { fg = c.orange, bg = c.bg })
vim.api.nvim_set_hl(0, "Character", { fg = c.green })
vim.api.nvim_set_hl(0, "Include", { fg = c.cyan })
vim.api.nvim_set_hl(0, "Macro", { fg = c.purple })
vim.api.nvim_set_hl(0, "Structure", { fg = c.cyan })
vim.api.nvim_set_hl(0, "Underlined", { fg = "None" })
vim.api.nvim_set_hl(0, "Error", { fg = c.red, underline = true })
