local settings = utils.ft_helpers.filetype_settings

local base_style = {
    bo = {
        tabstop = 2, -- number of columns occupied by a tab character
        shiftwidth = 2, -- width for autoindents
        softtabstop = 2, -- see multiple spaces as tabstops
    },
}

settings({
    checkhealth = { opt = { spell = false } },
    [{ 'gitcommit', 'gitrebase' }] = { bo = { bufhidden = 'delete' } },
    dart = base_style,
    [{ 'tsx', 'jsx', 'ts', 'js' }] = base_style,
    c = base_style,
    cu = base_style,
    netrw = {
        g = {
            netrw_liststyle = 3,
            netrw_banner = 0,
            netrw_browse_split = 0,
            netrw_winsize = 25,
            netrw_altv = 1,
            netrw_fastbrowse = 0,
        },
        bo = { bufhidden = 'wipe' },
        mappings = {
            { 'n', 'q',  '<Cmd>q<CR>' },
            { 'n', 'ç', '<CR>' },
            { 'n', 'j',  '<CR>' },
            { 'n', 'o',  '<CR>' },
        },
    },
})
