--[[
配置基础的全局属性
--]]
local utils = require('utils')


local function load_global_options()
    local global_options = {
        bs            = 'eol,start,indent';  -- 设置 Backspace 键模式
        autoindent    = true;                -- 自动缩进
        winaltkeys    = 'no';                -- Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
        nowrap        = true;                -- 关闭自动换行
        ttimeout      = true;                -- 打开功能键超时检测（终端下功能键为一串 ESC 开头的字符串）
        ttimeoutlen   = 50;                  -- 功能键超时检测 50 毫秒
        ruler         = true;                -- 显示光标位置
        ignorecase    = true;                -- 搜索时忽略大小写
        smartcase     = true;                -- 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写>字母
        hlsearch      = true;                -- 高亮搜索内容
        incsearch     = true;                -- 查找输入时动态增量显示查找结果
        encoding      = 'utf-8';             -- 内部工作编码
        fileencodings = 'utf-8,gbk,gbk2312'; -- 文件默认编码
        showmatch     = true;                -- 显示匹配的括号
        matchtime     = 5;                   -- 显示括号匹配的时间
        display       = 'lastline';          -- 显示最后一行
        wildmenu      = true;                -- 允许下方显示目录
        lazyredraw    = true;                -- 延迟绘制（提升性能）
        formatoptions = 'tcqmM';
        ffs           = 'unix,dos,mac';      -- 文件换行符，默认使用 unix 换行符
        nobackup      = true;                -- 不允许备份
        nowritebackup = true;                -- 不允许保存时备份
        noswapfile    = true;                -- 禁用交换文件
        noundofile    = true;                -- 禁用undo文件
        clipboard     = 'unnamedplus';       -- 使用系统剪切板
        hidden        = true;                -- buf隐藏（终端）
        completeopt   = 'menuone,noselect';  -- compe
    }
    utils.load_options(global_options)
end


-- 加载全局配置
load_global_options()
