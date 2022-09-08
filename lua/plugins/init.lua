local packer = require('packer')

packer.startup({function(use)
    -- 包管理
    use 'wbthomason/packer.nvim'
    -- 依赖
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    -- 语法高亮
    use 'nvim-treesitter/nvim-treesitter'
    -- 配色方案
    use 'ful1e5/onedark.nvim'

    -- 首页
    use 'glepnir/dashboard-nvim'
    -- buffer 管理
    use 'romgrk/barbar.nvim'
    -- 状态栏
    use 'nvim-lualine/lualine.nvim'
    -- 文件树
    use 'kyazdani42/nvim-tree.lua'
    -- 缩进线
    use 'lukas-reineke/indent-blankline.nvim'
    -- 模糊搜索
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    -- 快速跳转
    use { 'phaazon/hop.nvim', branch = 'v1'}
    -- git提示
    use 'lewis6991/gitsigns.nvim'
    -- 智能括号
    use 'tpope/vim-surround'
    use 'windwp/nvim-autopairs'
    -- 智能注释
    use 'b3nj5m1n/kommentary'
    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'folke/trouble.nvim'
    -- symbols
    use 'simrat39/symbols-outline.nvim'
    use 'rcarriga/nvim-notify'
end, config = {
    git = {
        default_url_format = 'https://hub.fastgit.xyz/%s'
    }
}})

require('plugins.ui')
require('plugins.edit')
require('plugins.fuzzyfind')
require('plugins.lsp')
require('plugins.git')
