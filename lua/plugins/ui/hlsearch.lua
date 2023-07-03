local M = {}

function M.setup()
    return {
        'nvimdev/hlsearch.nvim',
        event = 'BufRead',
        config = M.config,
    }
end

function M.config()
    --
    require('hlsearch').setup()
    --
end

return M
