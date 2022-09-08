--[[
全局目录配置
--]]
local config = {}
local vim = vim
local utils = require('utils')

-- 配置目录-XDG_CONFIG_HOME
config['home'] = vim.fn.stdpath('config')

-- 数据配置目录-XDG_CONFIG_DATA
config['data'] = vim.fn.stdpath('data')

-- 语言服务器目录（部分语言服务器必须手动归档放置--lua）
config['language_server_root'] = vim.fn.stdpath('data')..'/language-server'

-- 格式检查配置目录
config['linters'] = vim.fn.stdpath('config')..'/linters'

local lua_bin = config['language_server_root']..'/lua/bin/'..utils.get_os_name()..'/lua-language-server'

config['language_server_bin_map'] = {
    Windows = {
        lua = lua_bin,
        bashls = 'bash-language-server.cmd',
        html = 'html-languageserver.cmd',
        cssls = 'css-languageserver.cmd',
        tsserver = 'typescript-language-server.cmd',
        vue = 'vls.cmd',
        diagnosticls = 'diagnostic-languageserver.cmd',
        dart = 'dart.bat'
    },
    macOS = {
        lua = lua_bin,
        bashls = "bash-language-server",
        html = 'html-languageserver',
        cssls = 'css-languageserver',
        tsserver = 'typescript-language-server',
        vue = 'vls',
        diagnosticls = 'diagnostic-languageserver',
        dart = 'dart'
    },
    Linux = {
        lua = lua_bin,
        bashls = "bash-language-server",
        html = 'html-languageserver',
        cssls = 'css-languageserver',
        tsserver = 'typescript-language-server',
        vue = 'vls',
        diagnosticls = 'diagnostic-languageserver',
        dart = 'dart'
    }
}


return config

