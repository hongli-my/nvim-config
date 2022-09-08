local utils = {}
local vim = vim


-- 加载一个属性
function utils.load_option(k, v)
    if v == true or v == false then
        vim.cmd('set ' .. k)
    else
        vim.cmd('set ' .. k .. '=' .. v)
    end
end


-- 加载多个属性
function utils.load_options(options)
    for k, v in pairs(options) do
        if v == true or v == false then
            vim.cmd('set ' .. k)
        else
            vim.cmd('set ' .. k .. '=' .. v)
        end
    end
end


-- 运行一个Nvim命令
function utils.run_cmd(cmd)
    vim.cmd(cmd)
end


-- 连续运行多个Nvim命令
function utils.run_cmds(cmds)
    for _, v in ipairs(cmds) do
        vim.cmd(v)
    end
end


function utils.get_os_name()
    local system_name = ''
    if vim.fn.has("mac") == 1 then
        system_name = "macOS"
    elseif vim.fn.has("unix") == 1 then
        system_name = "Linux"
    elseif vim.fn.has('win32') == 1 then
        system_name = "Windows"
    else
        print("Unsupported system for sumneko")
    end
    return system_name
end

return utils
