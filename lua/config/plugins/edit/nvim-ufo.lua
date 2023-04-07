local M = {}

function M.setup()
	return {
		"kevinhwang91/nvim-ufo",
		config = M.config,
	}
end

function M.config()
	local ufo = require("ufo")

	local function set_keymaps()
		-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
		vim.keymap.set("n", "zR", ufo.openAllFolds)
		vim.keymap.set("n", "zM", ufo.closeAllFolds)
	end

	-- ╭──────────────────────────────────────────────────────────╮
	-- │ Custom handler function                                  │
	-- ╰──────────────────────────────────────────────────────────╯
	--
	local handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = ("  %d "):format(endLnum - lnum)
		local sufWidth = vim.fn.strdisplaywidth(suffix)
		local targetWidth = width - sufWidth
		local curWidth = 0

		for _, chunk in ipairs(virtText) do
			local chunkText = chunk[1]
			local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if targetWidth > curWidth + chunkWidth then
				table.insert(newVirtText, chunk)
			else
				chunkText = truncate(chunkText, targetWidth - curWidth)
				local hlGroup = chunk[2]
				table.insert(newVirtText, { chunkText, hlGroup })
				chunkWidth = vim.fn.strdisplaywidth(chunkText)
				-- str width returned from truncate() may less than 2nd argument, need padding
				if curWidth + chunkWidth < targetWidth then
					suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
				end
				break
			end
			curWidth = curWidth + chunkWidth
		end

		table.insert(newVirtText, { suffix, "MoreMsg" })

		return newVirtText
	end

	-- vim.o.foldcolumn = '1' -- '0' is not bad
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true

	-- Option 3: treesitter as a main provider instead
	-- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
	-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
	set_keymaps()

	ufo.setup({
		fold_virt_text_handler = handler,
		-- close_fold_kinds = { "imports" },
		provider_selector = function(_, filetype, buftype)
			local function handleFallbackException(bufnr, err, providerName)
				if type(err) == "string" and err:match("UfoFallbackException") then
					return require("ufo").getFolds(bufnr, providerName)
				else
					return require("promise").reject(err)
				end
			end

			return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
				or function(bufnr)
					return require("ufo")
						.getFolds(bufnr, "lsp")
						:catch(function(err)
							return handleFallbackException(bufnr, err, "treesitter")
						end)
						:catch(function(err)
							return handleFallbackException(bufnr, err, "indent")
						end)
				end
		end,
	})
end

return M
