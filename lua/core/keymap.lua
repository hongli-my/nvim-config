local vim = vim

-- leader map
vim.g.mapleader = " "
vim.api.nvim_set_keymap('n', ' ', '',{noremap = true})
vim.api.nvim_set_keymap('x', ' ', '',{noremap = true})

local opt = {
    silent = true,
    noremap = true
}
-- Buffer 保存
vim.api.nvim_set_keymap('n', '<c-s>', ':w<CR>', opt)
-- Buffer 取消高亮
vim.api.nvim_set_keymap('n', '<leader>c', ':noh<cr>', opt)
-- Buffer 关闭Buffer
vim.api.nvim_set_keymap('n', '<c-q>', ':bd!<cr>', opt)

-- 窗口宽度增大
vim.api.nvim_set_keymap('n', '<M-=>', '<cmd>res +5<cr>', opt)
-- 窗口宽度减小
vim.api.nvim_set_keymap('n', '<M-->', '<cmd>res -5<cr>', opt)
-- 窗口高度增大
vim.api.nvim_set_keymap('n', '<M-]>', '<cmd>vertical res +5<cr>', opt)
-- 窗口高度减小
vim.api.nvim_set_keymap('n', '<M-[>', '<cmd>vertical res -5<cr>', opt)

