---@type FiletypeSettings
return {
    picker = {
        keymap = '<leader><leader>o',
        title = 'Python Commands',
        actions_tbl = {
            { name = 'Criar venv',           handler = 'python -m venv --upgrade-deps .venv' },
            { name = 'install requirements', handler = 'pip install -r requirements.txt' },
        },
    },
    mappings = {
        { 'n', '<leader>rp', [[:w<CR>:TermExec cmd='python "%"'<CR>]], desc = 'python: [R]un [P]rogram' },
    },
}
