local set_hls = require("utils").set_hls

--  ╭──────────────────────────────────────────────────────────╮
--  │                     Highlights Base                      │
--  ╰──────────────────────────────────────────────────────────╯

local base_hls = require("config.base_highlights")
set_hls(base_hls)

--  ╭──────────────────────────────────────────────────────────╮
--  │                  Highlights dos Plugins                  │
--  ╰──────────────────────────────────────────────────────────╯

local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/config/plugins" .. "/**/*.lua", true, true)

for _, file in ipairs(plugin_files) do
	local plugin = require(file:match("/(config/.*).lua"):gsub("/", "."))

	if plugin.highlights then
		set_hls(plugin.highlights)
	end
end

--
-- local colorizer_is_installed, colorizer = pcall(require, "colorizer")
-- if colorizer_is_installed then
-- 	colorizer.setup()
-- end
