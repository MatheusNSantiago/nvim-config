local M = {}

function M.setup()
	return {
		'SmiteshP/nvim-navbuddy',
		dependencies = {
			'neovim/nvim-lspconfig',
			'SmiteshP/nvim-navic',
			'MunifTanjim/nui.nvim',
			'numToStr/Comment.nvim', -- Optional
			'nvim-telescope/telescope.nvim', -- Optional
		},
		config = M.config,
		-- keys = M.keys,
		keys = {
			{ '<leader>o', function() require('nvim-navbuddy').open() end, desc = 'navbuddy: open pannel' },
		},
	}
end

function M.config()
	local navbuddy = require('nvim-navbuddy')
	local actions = require('nvim-navbuddy.actions')

	local function get_kinds_padded()
		local kinds = require('utils.icons').lspkind
		local result = {}
		for k, v in pairs(kinds) do
			result[k] = v .. ' '
		end
		return result
	end

	navbuddy.setup({
		window = {
			border = 'single', -- "rounded", "double", "solid", "none"
			-- or an array with eight chars building up the border in a clockwise fashion
			-- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
			size = '60%', -- Or table format example: { height = "40%", width = "100%"}
			position = '50%', -- Or table format example: { row = "100%", col = "0%"}
			scrolloff = nil, -- scrolloff value within navbuddy window
			sections = {
				left = {
					size = '20%',
					border = nil, -- You can set border style for each section individually as well.
				},
				mid = {
					size = '40%',
					border = nil,
				},
				right = {
					-- No size option for right most section. It fills to
					-- remaining area.
					border = nil,
					preview = 'leaf', -- Right section can show previews too.
					-- Options: "leaf", "always" or "never"
				},
			},
		},
		node_markers = {
			enabled = true,
			icons = { leaf = '  ', leaf_selected = ' → ', branch = ' ' },
		},
		icons = get_kinds_padded(),
		use_default_mappings = false, -- If set to false, only mappings set
		mappings = {
			['<esc>'] = actions.close(), -- Close and cursor to original location
			['q'] = actions.close(),

			['k'] = actions.next_sibling(), -- down
			['l'] = actions.previous_sibling(), -- up

			['j'] = actions.parent(), -- Move to left panel
			['ç'] = actions.children(), -- Move to right panel
			['0'] = actions.root(), -- Move to first panel

			['v'] = actions.visual_name(), -- Visual selection of name
			['V'] = actions.visual_scope(), -- Visual selection of scope

			['y'] = actions.yank_name(), -- Yank the name to system clipboard "+
			['Y'] = actions.yank_scope(), -- Yank the scope to system clipboard "+

			['i'] = actions.insert_name(), -- Insert at start of name
			['I'] = actions.insert_scope(), -- Insert at start of scope

			['a'] = actions.append_name(), -- Insert at end of name
			['A'] = actions.append_scope(), -- Insert at end of scope

			['r'] = actions.rename(), -- Rename currently focused symbol

			['d'] = actions.delete(), -- Delete scope

			['f'] = actions.fold_create(), -- Create fold of current scope
			['F'] = actions.fold_delete(), -- Delete fold of current scope

			['c'] = actions.comment(), -- Comment out current scope

			['<enter>'] = actions.select(), -- Goto selected symbol
			['o'] = actions.select(),

			['<A-k>'] = actions.move_down(), -- Move focused node down
			['<A-l>'] = actions.move_up(), -- Move focused node up

			['t'] = actions.telescope({ -- Fuzzy finder at current level.
				layout_config = {
					-- All options that can be
					height = 0.60, -- passed to telescope.nvim's
					width = 0.60, -- default can be passed here.
					prompt_position = 'top',
					preview_width = 0.50,
				},
				layout_strategy = 'horizontal',
			}),

			['?'] = actions.help(), -- Open mappings help window
		},
		lsp = {
			auto_attach = false, -- If set to true, you don't need to manually use attach function
			preference = nil, -- list of lsp server names in order of preference
		},
		source_buffer = {
			follow_node = true, -- Keep the current node in focus on the source buffer
			highlight = true, -- Highlight the currently focused node
			reorient = 'smart', -- "smart", "top", "mid" or "none"
			scrolloff = nil, -- scrolloff value when navbuddy is open
		},
	})
end

M.highlights = {
	NavbuddyNormalFloat = { bg = c.transparent },
	-- NavbuddyCursorLine
	-- NavbuddyCursor
	-- NavbuddyName
	-- NavbuddyScope
	-- NavbuddyFloatBorder
}

return M
