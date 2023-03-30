return function()
  local cmd    = vim.cmd
  local fn     = vim.fn
  local system = fn.system
  local M      = {}

  M.vim.restart = function()
    local pid  = fn.getpid()
    local kill = 'kill -USR1 $(ps -p ' .. pid .. ' -o ppid=)'

    cmd('silent! update')

    system(kill)

    cmd('quitall!')
  end

  return M
end
