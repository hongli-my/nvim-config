local vim = vim
local opt = { silent = true, noremap = true }
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local telescope = require('telescope')
local trouble = require("trouble.providers.telescope")

-- 不显示二进制
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end
  }):sync()
end

telescope.setup{
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = {
      width = 0.9,
      height = 0.95,
      center = {
        prompt_position = 'top'
      },
      preview_width = 0.5
    },
    path_display = { 'smart' },
    prompt_prefix = ' ',
    selection_caret = ' ',
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim"
    },
    mappings = {
      n = {
        ["<M-p>"] = action_layout.toggle_preview,
        ["<C-t>"] = trouble.open_with_trouble
      },
      i = {
        ["<M-p>"] = action_layout.toggle_preview,
        ["<esc>"] = actions.close,
        ["<C-t>"] = trouble.open_with_trouble
      },
    },
    buffer_previewer_maker = new_maker,
  },
  extensions = {
    fzf = {
      fuzzy = false,                   -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}
telescope.load_extension('fzf')
telescope.load_extension("notify")

-- 全局查找文件
vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", opt)
-- 全局查找字符串
vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", opt)
-- 全局查找指定字符串
vim.api.nvim_set_keymap('n', '<leader>fa', "<cmd>lua require('telescope.builtin').grep_string()<cr>", opt)
-- 全局查找缓冲区
vim.api.nvim_set_keymap('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", opt)
-- 全局查找命令
vim.api.nvim_set_keymap('n', '<leader>fc', "<cmd>lua require('telescope.builtin').commands()<cr>", opt)
