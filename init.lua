-- 加载核心配置
require('core.options')
require('core.keymap')
require('core.config')
require('core.style')
-- 加载自定义
require('custom')
-- 加载插件
require('plugins')
vim.wo.relativenumber = true