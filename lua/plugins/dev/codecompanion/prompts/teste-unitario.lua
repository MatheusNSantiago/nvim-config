return {
	strategy = 'chat',
	description = 'Gerar testes unitários para o código selecionado',
	opts = {
		index = 6,
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
			content = [[Ao gerar testes unitários, siga estas etapas:

1. Identifique a linguagem de programação.
2. Identifique o propósito da função ou módulo a ser testado.
3. Liste os casos de borda e casos típicos que devem ser cobertos nos testes e compartilhe o plano com o usuário.
4. Gere testes unitários usando um framework de teste apropriado para a linguagem de programação identificada.
5. Certifique-se de que os testes cubram:
      - Casos normais
      - Casos de borda (edge cases)
      - Tratamento de erros (se aplicável)
6. Forneça os testes unitários gerados de maneira clara e organizada, sem explicações adicionais ou conversa.]],
			opts = { visible = false },
		},
		{
			role = 'user',
			content = function(context)
				local code = require('codecompanion.helpers.actions').get_code(context.start_line, context.end_line)

				return string.format(
					[[Por favor, gere testes unitários para este código do buffer %d:

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
