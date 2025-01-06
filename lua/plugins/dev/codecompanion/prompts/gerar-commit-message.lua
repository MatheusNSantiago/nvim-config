return {
  strategy = "chat",
  description = "Generate a commit message",
  opts = {
    index = 10,
    is_default = false,
    is_slash_cmd = true,
    auto_submit = true,
  },
  prompts = {
    {
      role = "user",
      content = function()
        return string.format(
          [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

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
