local vim = vim
local opt = { silent = true, noremap = true }

vim.api.nvim_set_keymap('n', '<leader>vq', "<cmd>lua require('custom.search').search_in_word(vim.fn.input('Search Word ➜ '))<cr>", opt)
vim.api.nvim_set_keymap('n', '<leader>vw', "<cmd>lua require('custom.search').search_in_regexp(vim.fn.input('Search Regexp ➜ '))<cr>", opt)
vim.api.nvim_set_keymap('n', '<leader>ve', "<cmd>lua require('custom.search').find_in_word(vim.fn.input('Find Word ➜ '))<cr>", opt)
vim.api.nvim_set_keymap('n', '<leader>vr', "<cmd>lua require('custom.search').find_in_regexp(vim.fn.input('Search Regexp ➜ '))<cr>", opt)


vim.api.nvim_set_keymap('n', '<leader>p', "<cmd>lua require('custom.tips').keymap()<cr>", opt)
