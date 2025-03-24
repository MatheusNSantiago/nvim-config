return {
  strategy = "chat",
  description = "Generate a commit message",
  opts = {
    index = 10,
    is_default = false,
    is_slash_cmd = true,
    auto_submit = true,
		short_name = 'gerar_mensagem_de_commit',
  },
  prompts = {
    {
      role = "user",
      content = function()
        return string.format(
          [[Você é um especialista em seguir a especificação do Conventional Commits. Dado o diff do git abaixo, gere uma mensagem de commit para mim:

```diff
%s
```
]],
          vim.fn.system("git diff --no-ext-diff --staged")
        )
      end,
      opts = {
        contains_code = true,
      },
    },
  },
}
