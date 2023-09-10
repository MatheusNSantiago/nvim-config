return {
    mappings = {
        { 'n', '<leader>r', [[:w<CR>:TermExec cmd='gcc % -o exec; ./exec'<CR>]], desc = 'C: [R]un' },
    },
}
