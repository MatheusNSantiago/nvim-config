return {
    commands = function()
        create_picker('<leader><leader>o', 'Python Commands', {
            { name = 'Criar venv',           handler = 'python -m venv --upgrade-deps .venv' },
            { name = 'install requirements', handler = 'pip install -r requirements.txt' },
        })
    end,
    mappings = {
        { 'n', '<leader>r', [[:w<CR>:TermExec cmd='python "%"'<CR>]], desc = 'python: [R]un' },
    },
}
