return {
	strategy = 'chat',
	description = 'Generate a commit message',
	opts = {
		index = 10,
		is_default = false,
		is_slash_cmd = false,
		auto_submit = true,
		short_name = 'gerar_mensagem_de_commit',
		ignore_system_prompt = true,
	},
	prompts = {
		{
			role = 'user',
			content = function()
				local results = string.format(
					[[Você é um especialista em seguir a especificação do Conventional Commits. Dado o diff do git abaixo, gere uma mensagem de commit para mim:

```diff
%s
```
]],
					vim.fn.system('git diff --no-ext-diff --staged')
				)
				vim.cmd([[Git commit]])

				return results
			end,
			opts = {
				contains_code = true,
			},
		},
	},
}
