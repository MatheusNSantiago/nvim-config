return {
	strategy = 'chat',
	description = 'Explain how code in a buffer works',
	opts = {
		index = 5,
		is_default = false,
		is_slash_cmd = false,
		modes = { 'v' },
		auto_submit = true,
		user_prompt = false,
		stop_context_insertion = true,
	},
	prompts = {
		{
			role = 'system',
			content = [[When asked to explain code, follow these steps:

1. Identify the programming language.
2. Describe the purpose of the code and reference core concepts from the programming language.
3. Explain each function or significant block of code, including parameters and return values.
4. Highlight any specific functions or methods used and their roles.
5. Provide context on how the code fits into a larger application if applicable.]],
			opts = { visible = false },
		},
		{
			role = 'user',
			content = function(context)
				local code = require('codecompanion.helpers.actions').get_code(context.start_line, context.end_line)

				return string.format(
					[[Please explain this code from buffer %d:

```%s
%s
```
]],
					context.bufnr,
					context.filetype,
					code
				)
			end,
			opts = { contains_code = true },
		},
	},
}
