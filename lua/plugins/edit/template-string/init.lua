local handler = require('plugins.edit.template-string.langs')
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local M = {}

function M.handle_text_changed()
	local filetype = vim.opt.filetype:get()

	if filetype == 'python' then
		handler.python.on_type()
	else
		handler.js.on_type()
	end
end

function M.setup()
	local options = {
		filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'python' },
		jsx_brackets = true,
		remove_template_string = false,
		restore_quotes = {
			normal = [[']],
			jsx = [["]],
		},
	}

	M.group = augroup('TemplateString', { clear = true })
	autocmd('FileType', {
		group = M.group,
		pattern = options.filetypes,
		callback = function(ev)
			vim.api.nvim_clear_autocmds({
				event = { 'TextChanged', 'TextChangedI' },
				buffer = ev.buf,
				group = M.group,
			})

			autocmd({ 'TextChanged', 'TextChangedI' }, {
				group = M.group,
				buffer = ev.buf,
				callback = M.handle_text_changed,
			})
		end,
	})
end

return M
