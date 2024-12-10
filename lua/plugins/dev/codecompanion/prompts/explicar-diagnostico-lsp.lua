return {
	strategy = 'chat',
	description = 'Explain the LSP diagnostics for the selected code',
	opts = {
		index = 9,
		is_default = false,
		is_slash_cmd = false,
		modes = { 'v' },
		short_name = 'lsp',
		auto_submit = true,
		user_prompt = false,
		stop_context_insertion = true,
	},
	prompts = {
		{
			role = 'system',
			content = [[You are an expert coder and helpful assistant who can help debug code diagnostics, such as warning and error messages. When appropriate, give solutions with code snippets as fenced codeblocks with a language identifier to enable syntax highlighting.]],
			opts = { visible = false },
		},
		{
			role = 'user',
			content = function(context)
				local diagnostics =
					require('codecompanion.helpers.actions').get_diagnostics(context.start_line, context.end_line, context.bufnr)

					log(diagnostics)

				local concatenated_diagnostics = ''
				for i, diagnostic in ipairs(diagnostics) do
					concatenated_diagnostics = concatenated_diagnostics
						.. i
						.. '. Issue '
						.. i
						.. '\n  - Location: Line '
						.. diagnostic.line_number
						.. '\n  - Buffer: '
						.. context.bufnr
						.. '\n  - Severity: '
						.. diagnostic.severity
						.. '\n  - Message: '
						.. diagnostic.message
						.. '\n'
				end

				return string.format(
					[[The programming language is %s. This is a list of the diagnostic messages:

%s
]],
					context.filetype,
					concatenated_diagnostics
				)
			end,
		},
		{
			role = 'user',
			content = function(context)
				local code = require('codecompanion.helpers.actions').get_code(
					context.start_line,
					context.end_line,
					{ show_line_numbers = true }
				)
				return string.format(
					[[
This is the code, for context:

```%s
%s
```
]],
					context.filetype,
					code
				)
			end,
			opts = { contains_code = true },
		},
	},
}
