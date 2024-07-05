local M = {}

function M.setup()
    return {
        'ggandor/leap.nvim',
		commit = 'c507733b04af71aefe6f025e9f5b53cc5560f757',
        config = M.config,
    }
end

function M.config()
    local leap = require('leap')

    leap.add_default_mappings()
    leap.setup({
        max_highlighted_traversal_targets = 10,
        case_sensitive = false,
        safe_labels = {},
        labels = { 'a', 's', 'd', 'f', 'n', 'j', 'k', 'l', 'ç' },
        special_keys = {
            repeat_search = '<enter>',
            next_phase_one_target = '<enter>',
            next_target = { '<enter>', ';' },
            prev_target = { '<tab>', ',' },
            next_group = '<space>',
            prev_group = '<tab>',
            multi_accept = '<enter>',
            multi_revert = '<backspace>',
        },
    })
end

local c = require('utils.colors')
M.highlights = {
    -- Matches that can be reached directly, without having to use a label (By default, this is only used for traversal mode, or when a match covers a label, indicating the conflict)
    LeapMatch = { fg = c.red, bold = true, underline = true, nocombine = true },
    -- The character needed tu be pressed to jump to the match position, after the whole search pattern has been given. It appears once the first input has been entered, right next to the pair.
    LeapLabelPrimary = { fg = c.red, bold = true, nocombine = true },
    -- If the number of matches exceeds the available target labels, the next group of labeled targets are shown with a different color. Those can be reached by pressing `<space>` (`special_keys.next_group`) before the label character.
    LeapLabelSecondary = { fg = 'Yellow', bold = true, nocombine = true },
    -- Labels that are selected for the action in |leap-multiselect| mode.
    -- LeapLabelSelected = {},
    -- In some cases it might be useful or even necessary to apply certain settings on the rest of the area, like disabling all `gui` attributes, or adding a uniform grey foreground color, to make Leap matches and labels more distinguishable. This group is not set by default.
    -- LeapBackdrop = {},
}

return M
