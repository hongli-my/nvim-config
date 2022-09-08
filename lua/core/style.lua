--[[
基础UI风格
--]]
local utils = require('utils')


local function load_global_options()
  local global_options = {
    number        = true;    -- 设置行号
    sw            = 4;       -- 设置缩进宽度
    ts            = 4;       -- 设置 TAB 宽度
    et            = true;    -- 展开tab
    softtabstop   = 4;       -- 如果后面设置了 expandtab 那么展开 tab 为多少字符
    laststatus    = 2;       -- 总是显示状态栏
    signcolumn    = 'yes:1'; -- 总是显示侧边栏（用于显示 mark/gitdiff/诊断信息）
    showtabline   = 2;       -- 总是显示标签栏
    list          = true;    -- 设置显示制表符等隐藏字符
    showcmd       = true;    -- 右下角显示命令
    splitright    = true;    -- 水平切割窗口时，默认在右边显示新窗口
    cursorline    = true;    -- 高亮当前行
    background    = 'dark';  -- 设置黑色背景
    termguicolors = true;    -- 允许 256 色
  }
  utils.load_options(global_options)
end


load_global_options()

-- 语言缩进: 默认为4
utils.run_cmd('autocmd filetype lua setlocal ts=2 sw=2 sts=2 et')
utils.run_cmd('autocmd filetype dart setlocal ts=2 sw=2 sts=2 et')
