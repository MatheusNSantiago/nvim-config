local set_hls = require("utils").set_hls
local c = require("utils.colors")
local hls = {}
-- https://github.com/numToStr/Sakura.nvim/commit/392a5d5a2e6097b816314b38d727e641a5bde7c9
-- https://github.com/LunarVim/onedarker.nvim/blob/master/lua/onedarker/theme.lua

hls.language = {
	yamlPlainScalar = { fg = c.orange },
	yamlTSField = { fg = c.blue },
	luaFunc = { fg = c.yellow },
	luaFunction = { fg = c.blue },
	hclTSPunctSpecial = { fg = c.alt_fg },
	jsonKeyword = { fg = c.blue },
	yamlBlockMappingKey = { fg = c.blue },
	tomlTSProperty = { fg = c.blue },
}

set_hls(require("utils").flatten(hls))

--  ╭──────────────────────────────────────────────────────────╮
--  │                  Highlights dos Plugins                  │
--  ╰──────────────────────────────────────────────────────────╯

local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins" .. "/**/*.lua", true, true)
for _, file in ipairs(plugin_files) do
	local is_installed, plugin = pcall(require, file:match("/(plugins/.*).lua"):gsub("/", "."))

	if is_installed then
		if type(plugin) == "table" then
			if plugin.highlights then -- plugin has highlights
				set_hls(plugin.highlights)
			end
		end
	end
end
