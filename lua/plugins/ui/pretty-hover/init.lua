local M = {}

M.config = {
	header = {
		detect = { '[\\@]class' },
		styler = '###',
	},
	line = {
		detect = { '[\\@]brief' },
		styler = '**',
	},
	listing = {
		detect = { '[\\@]lia' },
		styler = ' - ',
	},
	references = {
		detect = {
			'[\\@]ref',
			'[\\@]c',
			'[\\@]name',
		},
		styler = { '**', '`' },
	},
	word = {
		detect = {
			'[\\@]param',
			'[\\@]tparam',
			'[\\@]see',
			'[\\@]*param*',
		},
		styler = '`',
	},

	code = {
		start = { '[\\@]code' },
		ending = { '[\\@]endcode' },
	},
	return_statement = {
		'[\\@]return',
		'[\\@]*return*',
	},
	hl = {
		error = {
			color = '#DC2626',
			detect = { '[\\@]error', '[\\@]bug' },
			line = false,
		},
		warning = {
			color = '#FBBF24',
			detect = { '[\\@]warning', '[\\@]thread_safety', '[\\@]throw' },
			line = false,
		},
		info = {
			color = '#2563EB',
			detect = { '[\\@]remark', '[\\@]note', '[\\@]notes' },
		},
	},

	border = 'rounded',
	max_width = nil,
	max_height = nil,
}

local h_util = require('plugins.ui.pretty-hover.util')

--- Parses the response from the server and displays the hover information converted to markdown.
function M.hover()
	require('plugins.ui.pretty-hover.highlight').setup_colors(M.config)

	local util = require('vim.lsp.util')
	local params = util.make_position_params()

	-- Check if the server for this filetype exists and supports hover.
	local client = h_util.get_current_active_clent()
	if not client then
		vim.notify('The hover action is not supported in this filetype', vim.log.levels.INFO)
		return
	end

	vim.lsp.buf_request_all(0, 'textDocument/hover', params, function(responses)
		for _, response in pairs(responses) do
			if response.result and response.result.contents then
				local contents = response.result.contents

				-- We have to do this because of java. Sometimes is the value parameter split
				-- into two chunks. Leaving the rest of the hover message as the second argument
				-- in the received table.
				if contents.language == 'java' then
					for _, content in pairs(contents) do
						local hover_text = content.value or content
						h_util.open_float(hover_text, M.config)
					end
				else
					local hover_text = response.result.contents.value
					h_util.open_float(hover_text, M.config)
				end
			end
		end
	end)
end

--- Setup the plugin to use the given options.
function M.setup()
end

--- Close the opened floating window.
function M.close() h_util.close_float() end

return M
