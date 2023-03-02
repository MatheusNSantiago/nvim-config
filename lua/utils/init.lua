local function contains(table, value)
    if type(table) ~= "table" then return false end

    for _, j in pairs(table) do
        if j == value then
            return true
        end
    end

    return false
end

---@diagnostic disable-next-line: lowercase-global
function map(mode, remap, command, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    if contains(mode, 'i') then
        vim.keymap.set(mode, remap, "<ESC>" .. tostring(command), options)
    else
        vim.keymap.set(mode, remap, command, options)
    end

end
