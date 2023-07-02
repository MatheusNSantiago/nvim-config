local M = {}

M.handlers = {
    ['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        { virtual_text = false }
    ),
}

M.settings = {
    pyright = { autoImportCompletion = true },
    python = {
        analysis = {
            autoSearchPaths = true,
            diagnosticMode = 'openFilesOnly',
            useLibraryCodeForTypes = true,
            completeFunctionParens = true,
            typeCheckingMode = 'off',
        },
    },
}

M.on_attach = function(client, bufnr)
    require('lsp').common_on_attach(client, bufnr)

    local custom_picker = require('plugins.navigation.telescope.picker')
    custom_picker.create_picker('Python', '<leader><leader>o', {
        {
            name = 'Criar venv',
            handler = 'python -m venv --upgrade-deps .venv',
        },
        {
            name = 'install requirements',
            handler = 'pip install -r requirements.txt',
        },
    })

    utils.api.keymap(
        'n',
        '<leader>r',
        [[:w<CR>:TermExec cmd='python "%"'<CR>]],
        { buffer = bufnr, desc = 'python: [R]un' }
    )
end

return M
