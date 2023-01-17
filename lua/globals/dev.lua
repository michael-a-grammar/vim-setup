return function(global_values)
  local cmd    = vim.cmd
  local fn     = vim.fn
  local system = fn.system
  local M      = {}

  M.vim = {}

  if global_values.has_dev_path then
    M.config = {}
    M.dev    = {}
    M.git    = {}

    M.config.delete = function()
      system({ 'rm', '-rf', global_values.lua_path })
      system({ 'rm',        global_values.init_path })

      return M
    end

    M.config.list = function()
      print(system({ 'ls', global_values.config_path }))

      return M
    end

    M.dev.copy = function()
      system({ 'cp', '-rf', global_values.lua_dev_path,  global_values.config_path })
      system({ 'cp',        global_values.init_dev_path, global_values.config_path })

      return M
    end

    M.git.push = function()
      local cwd = system('pwd')

      system({ 'cd',    global_values.dev_path    })
      system({ 'git',   'add',    '.'             })
      system({ 'git',   'commit', '-m', 'Updates' })
      system({ 'git',   'push'                    })
      system({ 'cd',    cwd                       })

      return M
    end
  end

  M.vim.restart = function()
    local pid  = fn.getpid()
    local kill = 'kill -USR1 $(ps -p ' .. pid .. ' -o ppid=)'

    cmd('silent! update')

    system(kill)

    cmd('quitall!')
  end

  return M
end
