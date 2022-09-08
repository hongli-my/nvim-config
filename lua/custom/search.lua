local vim = vim
local M = {}
local result, buf
local opt = { silent = true, noremap = true }
local notify = require('notify')


local function format_without_filename()
  local index, detla, line, content
  -- 获取最大宽度
  local width = string.find(result[#result-1], ':')

  for k,v in pairs(result) do
    -- 分割
    index = string.find(v, ':')
    line = string.sub(v, 1, index)
    content = string.sub(v, index + 1)
    -- 对齐
    detla = width - string.len(line)
    if (detla > 0) then
      line = string.rep(' ', detla) .. line
    end
    result[k] = line .. ' ' .. content
  end
end

local function format_with_filename()
end

local function set_keymap()
  -- 上下文
  vim.api.nvim_buf_set_keymap(buf, 'n', 'c', 'lua require("custom.search").set_context(vim.fn.input("Context > "))', opt)
end

local function create_display_buffer(cmd)
  vim.b.cmd = cmd
  buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'hide')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'Search')
  set_keymap()
  vim.api.nvim_win_set_buf(0, buf)
end

local function update_view()
  vim.api.nvim_buf_set_option(buf, 'modifiable', true)
  vim.api.nvim_buf_set_lines(buf, 0, #result, false, result)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
end

--------------------------------------
--
-- 当前Buffer
-- 全字搜索
--
--------------------------------------
function M.search_in_word(word)
  if string.len(word) == 0 then
    notify("search content is null", "warn", {title='Search'})
    return
  end
  local name = vim.fn.bufname()
  if string.len(name) == 0 then
    return
  end

  local cmd = string.format('rg --fixed-strings "%s" "%s" -n --trim', word, name)
  create_display_buffer(cmd)

  result = vim.fn.systemlist(cmd)
  if #result > 0 then
    format_without_filename()
  end

  update_view()
end

--------------------------------------
--
-- 当前Buffer
-- 正则搜索
--
--------------------------------------
function M.search_in_regexp(word)
  if string.len(word) == 0 then
    notify("search content is null", "warn", {title='Search'})
    return
  end
  local name = vim.fn.bufname()
  if string.len(name) == 0 then
    return
  end

  local cmd = string.format('rg -e "%s" "%s" -n --trim', word, name)
  create_display_buffer(cmd)
  result = vim.fn.systemlist(cmd)
  if #result > 0 then
    format_without_filename()
  end

  update_view()
end

--------------------------------------
--
-- 全局
-- 全字搜索
--
--------------------------------------
function M.find_in_word(word)
  if string.len(word) == 0 then
    notify("search content is null", "warn", {title='Search'})
    return
  end

  local name = vim.fn.getcwd()
  if string.len(name) == 0 then
    return
  end

  local cmd = string.format('rg --fixed-strings "%s" "%s" -n --trim', word, name)
  create_display_buffer(cmd)
  result = vim.fn.systemlist(cmd)
  if #result > 0 then
    format_with_filename()
  end

  update_view()
end
--------------------------------------
--
-- 全局
-- 正则搜索
--
--------------------------------------
function M.find_in_regexp(word)
  if string.len(word) == 0 then
    notify("search content is null", "warn", {title='Search'})
    return
  end
  local name = vim.fn.getcwd()
  if string.len(name) == 0 then
    return
  end

  local cmd = string.format('rg -e "%s" "%s" -n --trim', word, name)
  create_display_buffer(cmd)
  result = vim.fn.systemlist(cmd)
  if #result > 0 then
    format_with_filename()
  end

  update_view()
end

--------------------------------------
--
-- 设置上下文
--
--------------------------------------
function M.set_context(word)
  if vim.b.cmd == nil then
    print("no context")
    return
  end
  if tonumber(word) == nil then
    print("context error")
    return
  end

  local cmd = vim.b.cmd .. ' --context ' .. word

  result = vim.fn.systemlist(cmd)
  if #result > 0 then
    format_without_filename()
  end

  update_view()
end

return M
