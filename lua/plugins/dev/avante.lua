local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'yetone/avante.nvim',
		config = M.config,
		build = 'make',
		cmd = {
			'AvanteAsk',
			'AvanteBuild',
			'AvanteEdit',
			'AvanteRefresh',
			'AvanteSwitchProvider',
			'AvanteChat',
			'AvanteToggle',
			'AvanteClear',
		},
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'stevearc/dressing.nvim',
			'nvim-lua/plenary.nvim',
			'MunifTanjim/nui.nvim',
		},
		keys = {
			{
				'<leader>ak',
				function() require('avante.api').ask() end,
				desc = 'avante: ask',
				mode = { 'n', 'v' },
			},
			{
				'<leader>af',
				function() require('avante.api').focus() end,
				desc = 'avante: focus',
				mode = 'n',
			},
			{
				'<leader>ae',
				function() require('avante.api').edit() end,
				desc = 'avante: edit',
				mode = { 'n', 'v' },
			},
		},
	}
end

function M.config()
	require('avante').setup({
		provider = 'openai', -- Only recommend using Claude
		---@type AvanteSupportedProvider
		openai = {
			endpoint = 'https://api.openai.com/v1',
			model = 'gpt-4o',
			timeout = 30000, -- Timeout in milliseconds
			temperature = 0,
			max_tokens = 4096,
			['local'] = false,
		},
		---Specify the behaviour of avante.nvim
		---1. auto_apply_diff_after_generation: Whether to automatically apply diff after LLM response.
		---                                     This would simulate similar behaviour to cursor. Default to false.
		---2. auto_set_keymaps                : Whether to automatically set the keymap for the current line. Default to true.
		---                                     Note that avante will safely set these keymap. See https://github.com/yetone/avante.nvim/wiki#keymaps-and-api-i-guess for more details.
		---3. auto_set_highlight_group        : Whether to automatically set the highlight group for the current line. Default to true.
		---4. support_paste_from_clipboard    : Whether to support pasting image from clipboard. This will be determined automatically based whether img-clip is available or not.
		behaviour = {
			auto_suggestions = false, -- Experimental stage
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = false,
		},
		highlights = {
			---@type AvanteConflictHighlights
			diff = {
				current = 'DiffText',
				incoming = 'DiffAdd',
			},
		},
		mappings = {
			---@class AvanteConflictMappings
			diff = {
				ours = 'co',
				theirs = 'ct',
				all_theirs = 'ca',
				both = 'cb',
				cursor = 'cc',
				next = ']x',
				prev = '[x',
			},
			suggestion = {
				accept = '<M-l>',
				next = '<M-]>',
				prev = '<M-[>',
				dismiss = '<C-]>',
			},
			jump = {
				next = ']]',
				prev = '[[',
			},
			submit = {
				normal = '<CR>',
				insert = '<C-s>',
			},
			ask = '<leader>ak',
			edit = '<leader>ae',
			refresh = '<leader>ar',
			focus = '<leader>af',
			toggle = {
				default = '<leader>at',
				debug = '<leader>ad',
				hint = '<leader>ah',
				suggestion = '<leader>as',
				repomap = '<leader>aR',
			},
			sidebar = {
				apply_all = 'A',
				apply_cursor = 'a',
				switch_windows = '<Tab>',
				reverse_switch_windows = '<S-Tab>',
			},
		},
		windows = {
			---@class AvantePosition
			position = 'right',
			wrap = true, -- similar to vim.o.wrap
			width = 30, -- default % based on available width in vertical layout
			height = 30, -- default % based on available height in horizontal layout
			sidebar_header = {
				enabled = false, -- true, false to enable/disable the header
				align = 'center', -- left, center, right for title
				rounded = true,
			},
			input = {
				prefix = '> ',
				height = 8, -- Height of the input window in vertical layout
			},
			edit = {
				border = 'rounded',
				start_insert = true, -- Start insert mode when opening the edit window
			},
			ask = {
				floating = false, -- Open the 'AvanteAsk' prompt in a floating window
				border = 'rounded',
				start_insert = true, -- Start insert mode when opening the ask window
				---@class AvanteInitialDiff
				focus_on_apply = 'ours', -- which diff to focus after applying
			},
		},
		--- @class AvanteConflictConfig
		diff = {
			autojump = true,
			--- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
			--- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
			--- Disable by setting to -1.
			override_timeoutlen = 500,
		},
		--- @class AvanteHintsConfig
		hints = { enabled = false },
	})
end

return M
