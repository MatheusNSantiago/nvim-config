local H = require('filetypes.ft_helpers')

local fo = require('cobol-bundle').cobol_config

U.api.augroup('filetype_configs', {
	event = 'Filetype',
	pattern = '*',
	command = function(args)
		local ft = vim.bo.ft
		local get_settings = U.switch(ft, {
			['python'] = H.lazy_require('filetypes.python'),
			[{ 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }] = H.lazy_require('filetypes.js'),
			['c'] = H.lazy_require('filetypes.c'),
			['java'] = H.lazy_require('filetypes.java'),
			-- ['markdown'] = safe_require('filetypes.markdown'),
			['rust'] = H.lazy_require('filetypes.rust'),
			--  ╾───────────────────────────────────────────────────────────────────────────────────╼
			['cobol'] = H.lazy_require('cobol-bundle', 'cobol_config'),
			['copybook'] = H.lazy_require('cobol-bundle', 'copybook_config'),
			['foo'] = H.lazy_require('cobol-foo'),
		})

		if not get_settings then return end
		local settings = get_settings()

		for scope, value in pairs(settings) do
			local apply = U.switch(scope, {
				on_buf_enter = vim.schedule_wrap(function() value(args) end),
				picker = function() create_picker(value.keymap, value.title, value.actions) end,
				plugins = function()
					if type(value) ~= 'table' then return end
					for pkg, callback in pairs(value) do
						local ok, plugin = utils.pcall(require, pkg)
						if ok then callback(plugin) end
					end
				end,
				bo = function()
					for option, setting in pairs(value) do
						vim.bo[option] = setting
					end
				end,
				opt = function()
					for option, setting in pairs(value) do
						vim.opt_local[option] = setting
					end
				end,
				mappings = function()
					Array(value):foreach(function(m)
						assert(m[1] and m[2] and m[3], 'mappings devem ter no mínimo 3 items')

						local opts = utils.fold(function(acc, item, key)
							if type(key) == 'string' then acc[key] = item end
							return acc
						end, m, { buffer = args.buf })

						U.api.keymap(m[1], m[2], m[3], opts)
					end)
				end,
				autocommands = function()
					local commands = vim.tbl_map(function(cmd)
						cmd['once'] = true
						return cmd
					end, value)

					U.api.augroup(ft .. '_filetype_aucommands', unpack(commands))
				end,
			})
			if apply then apply() end
		end
	end,
})
