local vim = vim
local opt = { silent = true, noremap = true }

--------------------------
-- comments
--------------------------
local kommentary_config = require('kommentary.config')
kommentary_config.use_extended_mappings()
kommentary_config.configure_language("default", {
    prefer_single_line_comments = true,
})

--------------------------
-- autopairs
--------------------------
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

--------------------------
-- hop
--------------------------
require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", opt)
vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", opt)
vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", opt)
vim.api.nvim_set_keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", opt)
vim.api.nvim_set_keymap('', 's', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", opt)
vim.api.nvim_set_keymap('', 'S', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", opt)
vim.api.nvim_set_keymap('', '2s', "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", opt)
vim.api.nvim_set_keymap('', '2S', "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", opt)
vim.api.nvim_set_keymap('n', '3s', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", opt)
vim.api.nvim_set_keymap('v', '3s', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", opt)
vim.api.nvim_set_keymap('o', '3s', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, inclusive_jump = true })<cr>", opt)
