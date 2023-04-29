local M = {}

M.setup = function()
	M.create_winbar()

	return {
		'SmiteshP/nvim-navic',
		config = M.config,
	}
end

M.config = function()
	local icons = require('utils.icons')
	local kind = icons.lspkind

	require('nvim-navic').setup({
		icons = {
			Array = kind.Array .. ' ',
			Boolean = kind.Boolean,
			Class = kind.Class .. ' ',
			Color = kind.Color .. ' ',
			Constant = kind.Constant .. ' ',
			Constructor = kind.Constructor .. ' ',
			Enum = kind.Enum .. ' ',
			EnumMember = kind.EnumMember .. ' ',
			Event = kind.Event .. ' ',
			Field = kind.Field .. ' ',
			File = kind.File .. ' ',
			Folder = kind.Folder .. ' ',
			Function = kind.Function .. ' ',
			Interface = kind.Interface .. ' ',
			Key = kind.Key .. ' ',
			Keyword = kind.Keyword .. ' ',
			Method = kind.Method .. ' ',
			Module = kind.Module .. ' ',
			Namespace = kind.Namespace .. ' ',
			Null = kind.Null .. ' ',
			Number = kind.Number .. ' ',
			Object = kind.Object .. ' ',
			Operator = kind.Operator .. ' ',
			Package = kind.Package .. ' ',
			Property = kind.Property .. ' ',
			Reference = kind.Reference .. ' ',
			Snippet = kind.Snippet .. ' ',
			String = kind.String .. ' ',
			Struct = kind.Struct .. ' ',
			Text = kind.Text .. ' ',
			TypeParameter = kind.TypeParameter .. ' ',
			Unit = kind.Unit .. ' ',
			Value = kind.Value .. ' ',
			Variable = kind.Variable .. ' ',
		},
		highlight = true,
		separator = ' ' .. icons.ui.ChevronRight .. ' ',
		depth_limit = 4,
		depth_limit_indicator = '..',
	})
end

M.get_filename = function()
	local icons = require('utils.icons')
	local filename = vim.fn.expand('%:t')
	local extension = vim.fn.expand('%:e')
	local f = require('utils')

	if not f.isempty(filename) then
		local file_icon, hl_group
		local devicons_ok, devicons = pcall(require, 'nvim-web-devicons')
		if devicons_ok then
			file_icon, hl_group = devicons.get_icon(filename, extension, { default = true })

			if f.isempty(file_icon) then file_icon = icons.kind.File end
		else
			file_icon = ''
			hl_group = 'Normal'
		end

		local buf_ft = vim.bo.filetype

		if buf_ft == 'dapui_breakpoints' then file_icon = icons.ui.Bug end

		if buf_ft == 'dapui_stacks' then file_icon = icons.ui.Stacks end

		if buf_ft == 'dapui_scopes' then file_icon = icons.ui.Scopes end

		if buf_ft == 'dapui_watches' then file_icon = icons.ui.Watches end

		-- if buf_ft == "dapui_console" then
		--   file_icon = icons.ui.DebugConsole
		-- end

		return ' ' .. '%#' .. hl_group .. '#' .. file_icon .. '%*' .. ' ' .. '%#Winbar#' .. filename .. '%*'
	end
end

M.winbar_filetype_exclude = function() -- winbar_filetype_exclude
	return vim.tbl_contains({
		'help',
		'startify',
		'dashboard',
		'lazy',
		'neo-tree',
		'neogitstatus',
		'NvimTree',
		'Trouble',
		'alpha',
		'lir',
		'Outline',
		'spectre_panel',
		'toggleterm',
		'DressingSelect',
		'Jaq',
		'harpoon',
		'dap-repl',
		'dap-terminal',
		'dapui_console',
		'dapui_hover',
		'lab',
		'notify',
		'noice',
		'neotest-summary',
		'',
	}, vim.bo.filetype)
end

M.get_winbar = function()
	local icons = require('utils.icons')
	local f = require('utils')

	if M.winbar_filetype_exclude() then return end

	local get_gps = function()
		local status_gps_ok, gps = pcall(require, 'nvim-navic')
		if not status_gps_ok then return '' end

		local status_ok, gps_location = pcall(gps.get_location, {})
		if not status_ok then return '' end

		if not gps.is_available() or gps_location == 'error' then return '' end

		if not f.isempty(gps_location) then
			return '%#NavicSeparator#' .. icons.ui.ChevronRight .. '%* ' .. gps_location
		else
			return ''
		end
	end

	local value = M.get_filename()

	if not f.isempty(value) then
		local gps_value = get_gps()
		value = value .. ' ' .. gps_value
	end

	local status_ok, _ = pcall(vim.api.nvim_set_option_value, 'winbar', value, { scope = 'local' })
	if not status_ok then return end
end

M.create_winbar = function()
	vim.api.nvim_create_augroup('_winbar', {})
	vim.api.nvim_create_autocmd({
		'BufWinEnter',
		'BufFilePost',
		'InsertEnter',
		'BufWritePost',
		'TabClosed',
		'TabEnter',
		'CursorMoved',
	}, {
		group = '_winbar',
		callback = function()
			local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, 'lsp_floating_window')
			if not status_ok then vim.defer_fn(M.get_winbar, 10) end
		end,
	})
end

local c = require('utils.colors')
M.highlights = {
	NavicIconsFile = { fg = c.fg, bg = c.transparent },
	NavicIconsModule = { fg = c.cyan, bg = c.transparent },
	NavicIconsNamespace = { fg = c.fg, bg = c.transparent },
	NavicIconsPackage = { fg = c.fg, bg = c.transparent },
	NavicIconsClass = { fg = c.cyan, bg = c.transparent },
	NavicIconsMethod = { fg = c.blue, bg = c.transparent },
	NavicIconsProperty = { fg = c.red, bg = c.transparent },
	NavicIconsField = { fg = c.red, bg = c.transparent },
	NavicIconsConstructor = { fg = c.cyan, bg = c.transparent },
	NavicIconsEnum = { fg = c.cyan, bg = c.transparent },
	NavicIconsInterface = { fg = c.cyan, bg = c.transparent },
	NavicIconsFunction = { fg = c.blue, bg = c.transparent },
	NavicIconsVariable = { fg = c.red, bg = c.transparent },
	NavicIconsConstant = { fg = c.orange, bg = c.transparent },
	NavicIconsString = { fg = c.green, bg = c.transparent },
	NavicIconsNumber = { fg = c.orange, bg = c.transparent },
	NavicIconsBoolean = { fg = c.orange, bg = c.transparent },
	NavicIconsArray = { fg = c.cyan, bg = c.transparent },
	NavicIconsObject = { fg = c.cyan, bg = c.transparent },
	NavicIconsKey = { fg = c.purple, bg = c.transparent },
	NavicIconsKeyword = { fg = c.purple, bg = c.transparent },
	NavicIconsNull = { fg = c.orange, bg = c.transparent },
	NavicIconsEnumMember = { fg = c.orange, bg = c.transparent },
	NavicIconsStruct = { fg = c.cyan, bg = c.transparent },
	NavicIconsEvent = { fg = c.yellow, bg = c.transparent },
	NavicIconsOperator = { fg = c.fg, bg = c.transparent },
	NavicIconsTypeParameter = { fg = c.red, bg = c.transparent },
	NavicText = { fg = c.context, bg = c.transparent },
	NavicSeparator = { fg = c.context, bg = c.transparent },
}

return M
