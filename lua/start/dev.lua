local cmd    = vim.cmd
local fn     = vim.fn
local exec   = vim.api.nvim_exec
local system = fn.system
local opts   = vim.g.elden.opts
local M      = {}

local dev_path     = opts.dev_path
local has_dev_path = fn.isdirectory(dev_path)

if has_dev_path then
  local lua_dev_path  = fn.expand(dev_path .. '/lua')
  local init_dev_path = fn.expand(dev_path .. '/init.lua')

  local config_path   = fn.stdpath('config')
  local lua_path      = config_path .. '/lua'
  local init_path     = config_path .. '/init.lua'
  local plugins_path  = config_path .. '/plugin'

  M.copy = function()
    system({ 'cp', '-rf', lua_dev_path,  config_path })
    system({ 'cp',        init_dev_path, config_path })

    return M
  end

  M.delete = function()
    system({ 'rm', '-rf', lua_path })
    system({ 'rm',        init_path })

    return M
  end

  M.push = function()
    local cwd = system('pwd')

    system({ 'cd',    dev_path                  })
    system({ 'git',   'add',    '.'             })
    system({ 'git',   'commit', '-m', 'Updates' })
    system({ 'git',   'push'                    })
    system({ 'cd',    cwd                       })

    return M
  end

  M.list = function()
    print(system({ 'ls', config_path }))

    return M
  end
end

M.restart = function()
  local pid  = fn.getpid()
  local kill = 'kill -USR1 $(ps -p ' .. pid .. ' -o ppid=)'

  cmd('silent! update')

  system(kill)

  cmd('quitall!')
end

return M
