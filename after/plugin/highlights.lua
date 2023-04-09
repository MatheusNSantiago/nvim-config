local set_hls = require("utils").set_hls

--  ╭──────────────────────────────────────────────────────────╮
--  │                     Highlights Base                      │
--  ╰──────────────────────────────────────────────────────────╯

local base_hls = require("config.base_highlights")
set_hls(base_hls)

--  ╭──────────────────────────────────────────────────────────╮
--  │                  Highlights dos Plugins                  │
--  ╰──────────────────────────────────────────────────────────╯

local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/config" .. "/**/*.lua", true, true)

for _, file in ipairs(plugin_files) do
	local plugin = require(file:match("/(config/.*).lua"):gsub("/", "."))

	if type(plugin) == "table" then
		if plugin.highlights then -- plugin has highlights
			set_hls(plugin.highlights)
		end
	end
end
