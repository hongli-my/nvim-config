local vim = vim
local utils = require('utils')
local cmp = require('cmp')
local config = require('core.config')
local opts = { silent = false, noremap = true }

--------------------------
-- lspconfig
--------------------------
local lspconfig = require('lspconfig')
-- 配置lsp显示UI
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false
})

-- 配置SigeColumn的Icon
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- 语言服务器可执行文件
local language_server = config['language_server_bin_map'][utils.get_os_name()]
-- 语言服务器配置
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
  buf_set_keymap("n", "<leader>m", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
  buf_set_keymap("v", "<leader>m", "<cmd>lua vim.lsp.buf.range_formatting()<cr>", opts)
end

--------------------------
-- nvim-cmp
--------------------------
local kind_icons = {
  Text = '',
  Method = '',
  Function = 'ƒ',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '𝓒',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '了',
  Snippet = "",
  Keyword = '',
  Color = '',
  File = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = 'פּ',
  Event = "",
  Operator = "",
  TypeParameter = ""
}
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  }),

  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
      })[entry.source.name]
      return vim_item
    end
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--------------------------
-- 语言服务器
--------------------------
-- lua 语言服务器
lspconfig.sumneko_lua.setup {
    cmd = {language_server.lua, '-E',  config.language_server_root..'/lua/main.lua'};
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

-- lsp workspace
-- 获取指定文件所在目录
local function get_root_dir(language, fname)
    local language_map = {
        python = { 'setup.py', '.git', '.gitignore' },
        go = { '.git', '.gitignore', 'go.mod' },
        linter = { '.git', '.gitignore' },
    }
    return lspconfig.util.root_pattern(language_map[language])(fname) or lspconfig.util.path.dirname(fname)
end

-- Python 语言服务器
lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function(fname)
        return get_root_dir('python', fname)
    end,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true
            }
        }
    }
}

-- Go 语言服务器
lspconfig.gopls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = function(fname)
      return get_root_dir('go', fname)
  end,
}

-- linter
lspconfig.diagnosticls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {language_server.diagnosticls, "--stdio"},
    filetypes = { 'python' },
    root_dir = function(fname)
        return get_root_dir('linter', fname)
    end,
    init_options = {
        filetypes = {
            python = {"flake8", "pylint"},
        },
        linters = {
            flake8 = {
                command = "flake8",
                sourceName = 'flake8',
                debounce = 100,
                args = { "--max-line-length=120", "--format=%(row)d,%(col)d,%(code).1s,[%(code)s]:%(text)s", "-" },
                offsetLine = 0,
                offsetColumn =  0,
                formatLines = 1,
                formatPattern = {
                    "(\\d+),(\\d+),([A-Z]),(.*)(\\r|\\n)*$",
                    {
                        line = 1,
                        column = 2,
                        security = 3,
                        message = 4
                    }
                },
                securities = {
                    W = "warning",
                    E = "error",
                    F = "error",
                    C = "error",
                    N = "error"
                },
            },
            pylint = {
                command = "pylint",
                sourceName = "pylint",
                args = {
                    "--rcfile",
                    config.linters .. '/.pylintrc',
                    "%file"
                },
                formatPattern = {
                    "^(\\d+):(\\d+):([a-z]+):(.*)(\\r|\\n)*$",
                    {
                      line = 1,
                      column = 2,
                      security = 3,
                      message = 4
                    }
                },
                rootPatterns = { "setup.py", '.git' },
                securities = {
                    informational = "hint",
                    refactor = "info",
                    convention = "info",
                    warning = "warning",
                    error = "error",
                    fatal = "error"
                },
                offsetColumn = 1,
                formatLines = 1
            }
        },
        formatFiletypes = {
            python = {'yapf'},
        },
        formatters = {
            yapf = {
                command = "yapf",
                args = {'--quiet'}
            }
        }
    }
}


--------------------------
-- symbols
--------------------------
vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false,
    position = 'right',
    relative_width = true,
    width = 50,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    keymaps = {
        close = "<Esc>",
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "p",
        rename_symbol = "r",
        code_actions = "a",
    },
    lsp_blacklist = {},
}
-- 打开大纲
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>SymbolsOutline<cr>', opts)


--------------------------
-- trouble
--------------------------
local trouble = require('trouble')
trouble.setup {
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "document_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    action_keys = { -- key mappings for actions in the trouble list
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "R", -- manually refresh
        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small poup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatyically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
    },
    use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xc", "<cmd>Trouble document_diagnostics<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xr", "<cmd>Trouble lsp_references<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble lsp_definitions<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xi", "<cmd>Trouble lsp_implementations<cr>", opts)

