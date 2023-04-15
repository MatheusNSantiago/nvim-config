local M = {}

function M.setup()
	local cmp = require("cmp")
	local types = require("cmp.types.cmp")

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	-- `:` cmdline setup.
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		confirmation = {
			default_behavior = types.ConfirmBehavior.Replace,
			select = true,
		},
		sources = cmp.config.sources({
			{ name = "path" },
		}, { { name = "cmdline" } }),
	})
end

return M
