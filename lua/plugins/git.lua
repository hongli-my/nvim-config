local vim = vim
local opts = { noremap = true, silent = true }

--------------------------
-- gitsigns
--------------------------
local gitsigns = require('gitsigns')
gitsigns.setup {
    signs = {
        add          = {hl = 'GitGutterAdd', text = '▋', numhl='GitSignsAddNr', linehl='GitSignsAddLn'},
        change       = {hl = 'GitGutterChange', text= '▋', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitGutterDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitGutterDeleteChange',text = '▔', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitGutterChange', text = '▎', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    keymaps = {
         -- Default keymap options
        noremap = false,
        buffer = false,
    },
    watch_gitdir = {
        interval = 100,
        follow_files = true
    }
}

vim.api.nvim_set_keymap('n', '<leader>hp', '<cmd>lua require"gitsigns".preview_hunk()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>hr', '<cmd>lua require"gitsigns".reset_hunk()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>hR', '<cmd>lua require"gitsigns".reset_buffer()<CR>', opts)
vim.api.nvim_set_keymap('n', ']c', '<cmd>lua require\"gitsigns\".next_hunk()<CR>', opts)
vim.api.nvim_set_keymap('n', '[c', '<cmd>lua require\"gitsigns\".prev_hunk()<CR>', opts)
