local M = {}

function M.setup()
    local cmp = require('cmp')
    local lspkind = require('lspkind')

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline({
            ['<C-l>'] = cmp.mapping({
                c = function(fallback)
                    if cmp.visible() then return cmp.select_prev_item() end
                    fallback()
                end,
            }),
            ['<C-k>'] = cmp.mapping({
                c = function(fallback)
                    if cmp.visible() then return cmp.select_next_item() end
                    fallback()
                end,
            }),
            ['<Tab>'] = cmp.mapping({
                c = function(fallback)
                    if cmp.visible() then
                        return cmp.confirm({
                            behavior = cmp.ConfirmBehavior.Replace, -- e.g. console.log -> console.inlog -> console.info
                            select = true,     -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                        })
                    else
                        return fallback()
                    end
                end,
            }),
        }),
        sources = { { name = 'buffer' } },
        formatting = {
            fields = { 'abbr', 'kind' },
            format = lspkind.cmp_format({
                mode = 'symbol_text', -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
                maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                before = function(_, vim_item)
                    if vim_item.kind == 'Text' then
                        vim_item.kind = ''
                        return vim_item
                    end
                    -- just show the icon
                    vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
                    return vim_item
                end,
            }),
        },
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({
            ['<C-l>'] = cmp.mapping({
                c = function(fallback)
                    if cmp.visible() then return cmp.select_prev_item() end
                    fallback()
                end,
            }),
            ['<C-k>'] = cmp.mapping({
                c = function(fallback)
                    if cmp.visible() then return cmp.select_next_item() end
                    fallback()
                end,
            }),
            ['<Tab>'] = cmp.mapping({
                c = function()
                    if cmp.visible() then
                        return cmp.select_next_item()
                    else
                        cmp.complete()
                        cmp.select_next_item()
                        return
                    end
                end,
            }),
            ['<S-Tab>'] = cmp.mapping({
                c = function()
                    if cmp.visible() then
                        return cmp.select_prev_item()
                    else
                        cmp.complete()
                        cmp.select_next_item()
                        return
                    end
                end,
            }),
        }),
        confirmation = {
            default_behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        sources = {
            { name = 'path' },
            {
                name = 'cmdline',
                option = { ignore_cmds = { 'Man', '!' } },
            },
        },
        formatting = {
            fields = { 'abbr', 'kind' },
            format = lspkind.cmp_format({
                mode = 'symbol_text', -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
                maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                before = function(_, vim_item)
                    if vim_item.kind == 'Variable' then
                        vim_item.kind = ''
                        return vim_item
                    end
                    -- just show the icon
                    vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
                    return vim_item
                end,
            }),
        },
    })
end

return M
