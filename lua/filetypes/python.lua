local function exec(cmd)
  vim.cmd("TermExec cmd='" .. cmd .. "'")
  vim.defer_fn(function() vim.cmd('stopinsert') end, 100)
end

---@type FiletypeSettings
return {
  picker = {
    keymap = '<leader><leader>o',
    title = 'Python Commands',
    actions = {
      {
        name = 'Iniciar Projeto',
        handler = function()
          exec('python -m venv --upgrade-deps .venv')
          exec('source .venv/bin/activate.fish')
          exec('curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore')
          exec('touch main.py')
        end,
      },
      { name = 'install requirements', handler = 'pip install -r requirements.txt' },
    },
  },
  mappings = {
    { 'n', '<leader>r', [[:w<CR>:TermExec cmd='python "%"'<CR>]], desc = 'python: [R]un' },
  },
}
