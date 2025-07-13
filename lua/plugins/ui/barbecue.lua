local M = {}

function M.setup()
	return {
		'utilyre/barbecue.nvim',
		event = 'VeryLazy',
		version = '*',
		dependencies = {
			'SmiteshP/nvim-navic',
			'nvim-tree/nvim-web-devicons', -- optional dependency
		},

		config = M.config,
	}
end

function M.config()
	local kind = require('utils.icons').lspkind

	require('barbecue').setup({
		---Whether to attach navic to language servers automatically.
		attach_navic = true,

		---Whether to create winbar updater autocmd.
		create_autocmd = false, -- Criei um autocomando que respeita os exclude_filetypes. ele está no final do arquivo

		---Buftypes to enable winbar in.
		include_buftypes = { '' },

		---Filetypes not to enable winbar in.
		exclude_filetypes = {
			'netrw',
			'toggleterm',
		},
		modifiers = {
			---Filename modifiers applied to dirname.
			---See: `:help filename-modifiers`
			dirname = ':~:.',

			---Filename modifiers applied to basename.
			---See: `:help filename-modifiers`
			basename = '',
		},

		---Whether to display path to file.
		show_dirname = true,

		---Whether to display file name.
		show_basename = true,

		---Whether to replace file icon with the modified symbol when buffer is
		---modified.
		show_modified = false,

		---Get modified status of file. This can be used to get file modified status from SCM (e.g. git)
		---@type fun(bufnr: number): boolean
		modified = function(bufnr) return vim.bo[bufnr].modified end,

		---Whether to show/use navic in the winbar.
		show_navic = true,

		---Get leading custom section contents.
		---This function shouldn't do any expensive actions as it is run on each render.
		---@type fun(bufnr: number, winnr: number): barbecue.Config.custom_section
		lead_custom_section = function() return ' ' end,

		---@diagnostic disable-next-line: duplicate-doc-alias
		---@alias barbecue.Config.custom_section
		---|string # Literal string.
		---|{ [1]: string, [2]: string? }[] # List-like table of `[text, highlight?]` tuples in which `highlight` is optional.
		---Get custom section contents.
		---NOTE This function shouldn't do any expensive actions as it is run on each render.
		---@type fun(bufnr: number, winnr: number): barbecue.Config.custom_section
		custom_section = function() return ' ' end,

		---Whether context text should follow its icon's color.
		---@type boolean
		context_follow_icon_color = false,

		symbols = {
			---Modification indicator.
			---@type string
			modified = '●',

			---Truncation indicator.
			---@type string
			ellipsis = '…',

			---Entry separator.
			---@type string
			separator = '',
		},
		---|false # Disable kind icons.
		---|table<string, string> # Type to icon mapping.
		---Icons for different context entry kinds.
		kinds = {
			Boolean = kind.Boolean,
			Class = kind.Class,
			Color = kind.Color,
			Constant = kind.Constant,
			Constructor = kind.Constructor,
			Enum = kind.Enum,
			EnumMember = kind.EnumMember,
			Event = kind.Event,
			Field = kind.Field,
			File = kind.File,
			Folder = kind.Folder,
			Function = kind.Function,
			Interface = kind.Interface,
			Key = kind.Key,
			Keyword = kind.Keyword,
			Method = kind.Method,
			Module = kind.Module,
			Namespace = kind.Namespace,
			Null = kind.Null,
			Number = kind.Number,
			Object = kind.Object,
			Operator = kind.Operator,
			Package = kind.Package,
			Property = kind.Property,
			Reference = kind.Reference,
			Snippet = kind.Snippet,
			String = kind.String,
			Struct = kind.Struct,
			Text = kind.Text,
			TypeParameter = kind.TypeParameter,
			Unit = kind.Unit,
			Value = kind.Value,
			Variable = kind.Variable,
		},
		theme = 'tokyonight',
	})

	utils.api.augroup('barbecue.updater', {
		event = {
			'WinResized',
			-- 'BufWinEnter',
			'CursorMoved',
			'InsertLeave',
			'LspAttach',
		},
		command = function(args)
			local ft = vim.bo[args.buf].filetype

			if vim.list_contains({ 'toggleterm' }, ft) then return end
			require('barbecue.ui').update()
		end,
	})
end

return M
