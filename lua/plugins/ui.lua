local vim = vim
local opts = { silent = true, noremap = true }

--------------------------
-- colorscheme: nightfox, nordfox, palefox
--------------------------
require('onedark').setup()

--------------------------
-- treesitter
--------------------------
require('nvim-treesitter.configs').setup{
  ensure_installed = {
    'c',
    'cpp',
    'go',
    'python',
    'lua',
    'json',
    'toml'
  },
  highlight = {
      enable = true,
  },
}

--------------------------
-- dashboard
--------------------------
local db = require('dashboard')
db.custom_header = {
  '',
  '⡆⣐⢕⢕⢕⢕⢕⢕⢕⢕⠅⢗⢕⢕⢕⢕⢕⢕⢕⠕⠕⢕⢕⢕⢕⢕⢕⢕⢕⢕',
  '⢐⢕⢕⢕⢕⢕⣕⢕⢕⠕⠁⢕⢕⢕⢕⢕⢕⢕⢕⠅⡄⢕⢕⢕⢕⢕⢕⢕⢕⢕',
  '⢕⢕⢕⢕⢕⠅⢗⢕⠕⣠⠄⣗⢕⢕⠕⢕⢕⢕⠕⢠⣿⠐⢕⢕⢕⠑⢕⢕⠵⢕',
  '⢕⢕⢕⢕⠁⢜⠕⢁⣴⣿⡇⢓⢕⢵⢐⢕⢕⠕⢁⣾⢿⣧⠑⢕⢕⠄⢑⢕⠅⢕',
  '⢕⢕⠵⢁⠔⢁⣤⣤⣶⣶⣶⡐⣕⢽⠐⢕⠕⣡⣾⣶⣶⣶⣤⡁⢓⢕⠄⢑⢅⢑',
  '⠍⣧⠄⣶⣾⣿⣿⣿⣿⣿⣿⣷⣔⢕⢄⢡⣾⣿⣿⣿⣿⣿⣿⣿⣦⡑⢕⢤⠱⢐',
  '⢠⢕⠅⣾⣿⠋⢿⣿⣿⣿⠉⣿⣿⣷⣦⣶⣽⣿⣿⠈⣿⣿⣿⣿⠏⢹⣷⣷⡅⢐',
  '⣔⢕⢥⢻⣿⡀⠈⠛⠛⠁⢠⣿⣿⣿⣿⣿⣿⣿⣿⡀⠈⠛⠛⠁⠄⣼⣿⣿⡇⢔',
  '⢕⢕⢽⢸⢟⢟⢖⢖⢤⣶⡟⢻⣿⡿⠻⣿⣿⡟⢀⣿⣦⢤⢤⢔⢞⢿⢿⣿⠁⢕',
  '⢕⢕⠅⣐⢕⢕⢕⢕⢕⣿⣿⡄⠛⢀⣦⠈⠛⢁⣼⣿⢗⢕⢕⢕⢕⢕⢕⡏⣘⢕',
  '⢕⢕⠅⢓⣕⣕⣕⣕⣵⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣷⣕⢕⢕⢕⢕⡵⢀⢕⢕',
  '⢑⢕⠃⡈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⢕⢕⢕',
  '⣆⢕⠄⢱⣄⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢁⢕⢕⠕⢁',
  '⣿⣦⡀⣿⣿⣷⣶⣬⣍⣛⣛⣛⡛⠿⠿⠿⠛⠛⢛⣛⣉⣭⣤⣂⢜⠕⢑⣡⣴⣿',
  '',
  '',
}

db.custom_center = {
    {
        icon = '  ',
        desc = 'Recently latest session                  ',
        shortcut = 'SPC s l',
        action ='SessionLoad'
    },
    {
        icon = '  ',
        desc = 'Recently opened files                   ',
        action =  'DashboardFindHistory',
        shortcut = 'SPC f h'
    },
    {
        icon = '  ',
        desc = 'Find  File                              ',
        action = 'Telescope find_files find_command=rg,--hidden,--files',
        shortcut = 'SPC f f'
    },
    {
        icon = '  ',
        desc ='File Browser                            ',
        action =  'Telescope file_browser',
        shortcut = 'SPC f b'
    },
    {
        icon = '  ',
        desc = 'Find  word                              ',
        action = 'Telescope live_grep',
        shortcut = 'SPC f w'
    }
}

-- dashboard 不显示statusline
vim.cmd('autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2')


--------------------------
-- barbar
--------------------------
vim.g.bufferline = {
  animation = true,
  auto_hide = true,
  tabpages = true,
  closable = false,
  clickable = false,
  icons = true,
  icon_custom_colors = false,
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab = nil,
  icon_close_tab_modified = '●',
  icon_pinned = '車',
  insert_at_end = false,
  insert_at_start = false,
  maximum_padding = 1,
  maximum_length = 30,
  semantic_letters = true,
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
  no_name_title = nil,
}

-- Move to previous/next
vim.api.nvim_set_keymap('n', '<Tab>', ':BufferNext<CR>', opts)
vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferPrevious<CR>', opts)
-- Re-order to previous/next
vim.api.nvim_set_keymap('n', '<A-,>', ':BufferMovePrevious<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-.>', ' :BufferMoveNext<CR>', opts)
-- Goto buffer in position...
vim.api.nvim_set_keymap('n', '<A-1>', ':BufferGoto 1<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-2>', ':BufferGoto 2<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-3>', ':BufferGoto 3<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-4>', ':BufferGoto 4<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-5>', ':BufferGoto 5<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-6>', ':BufferGoto 6<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-7>', ':BufferGoto 7<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-8>', ':BufferGoto 8<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-9>', ':BufferGoto 9<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-0>', ':BufferLast<CR>', opts)
-- Close buffer
vim.api.nvim_set_keymap('n', '<A-c>', ':BufferClose<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-a>', ':BufferCloseAllButCurrent<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-l>', ':BufferCloseBuffersLeft<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-r>', ':BufferCloseBuffersRight<CR>', opts)
-- Magic buffer-picking mode
vim.api.nvim_set_keymap('n', '<C-p>', ':BufferPick<CR>', opts)


--------------------------
-- lualine
--------------------------
require('lualine').setup({
  options = {
    component_separators = '|',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      'dashboard',
      'NvimTree',
      'Outline',
      'dap-repl',
      'dapui-watches',
      'dapui-stacks',
      'dapui-breakpoints',
      'dapui-scopes',
    },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'diff', 'diagnostics' },
    lualine_x = { 'fileformat', 'encoding' },
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
})

--------------------------
-- indentline
--------------------------
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")
require("indent_blankline").setup {
    bufname_exclude = { 'dashboard', 'NvimTree' },
    buftype_exclude = { 'Terminal' },
    show_end_of_line = true,
    space_char_blankline = " ",
}


--------------------------
-- nvim-tree
--------------------------
vim.g.nvim_tree_icons = {
    git = {
        unstaged  = "",
        staged    = "✓",
        unmerged  = "",
        renamed   = "➜",
        untracked = "★",
        deleted   = ""
    }
}
require'nvim-tree'.setup {
    disable_netrw       = true,
    hijack_netrw        = true,
    open_on_setup       = false,
    ignore_ft_on_setup  = {},
    open_on_tab         = false,
    renderer = {
        indent_markers = {
            enable = false,
            icons = {
              corner = "└ ",
              edge = "│ ",
              none = "  ",
            },
        },
        icons = {
            webdev_colors = true,
        },
    },
    hijack_cursor       = false,
    view = {
        width = 30,
        side = 'left',
    },
    git = {
       enable = true,
       ignore = false,
       timeout = 400,
    },

}
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<cr>', opts)
-- 在文件树中定位当前文件
vim.api.nvim_set_keymap('n', '<leader>l', ':NvimTreeFindFile<cr>', opts)


--------------------------
-- notifications
--------------------------
require("notify").setup({
  -- Animation style (see below for details)
  stages = "fade_in_slide_out",
  -- Function called when a new window is opened, use for changing win settings/config
  on_open = nil,
  -- Function called when a window is closed
  on_close = nil,
  -- Render function for notifications. See notify-render()
  render = "default",
  -- Default timeout for notifications
  timeout = 5000,
  -- Max number of columns for messages
  max_width = nil,
  -- Max number of lines for a message
  max_height = nil,
  -- For stages that change opacity this is treated as the highlight behind the window
  -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
  background_colour = "Normal",
  -- Minimum width for notification windows
  minimum_width = 50,
  -- Icons for the different levels
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },
})
