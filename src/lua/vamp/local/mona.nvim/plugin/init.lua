local Job = require('plenary.job')
local Path = require('plenary.path')

local M = {}

local function get_cwd()
  local path = (false and '~/crash') or vim.fn.getcwd()

  return Path:new(path)
end

local function get_project_directory(path)
  path = path or get_cwd()

  local git_path = path:find_upwards('.git')

  if git_path == nil then
    return false
  end

  local project_path = git_path:parent()
  local mix_path = path:new(project_path.filename .. '/mix.exs')

  if not mix_path:exists() then
    return false
  end

  return project_path
end

M.elixir_modules = function()
  local project_directory = get_project_directory()

  if not project_directory then
    return false
  end

  -- rg --case-sensitive --glob '*.ex' --replace '$1' --trim --vimgrep --with-filename --word-regexp --regexp 'defmodule ([a-zA-Z.]*) do$'

  Job:new({
    command = 'rg',
    args = {
      '--case-sensitive',
      '--trim',
      '--vimgrep',
      '--with-filename',
      '--word-regexp',
      '--glob',
      '*.ex',
      '--replace',
      '$1',
      '--regexp',
      'defmodule ([a-zA-Z.]*) do$',
      project_directory.filename,
    },
    cwd = project_directory.filename,
    env = vim.env,
    on_exit = function(self, code)
      vim.print(vim.inspect(self:result()))
      vim.print(code)
    end,
    on_stderr = function(error, data)
      vim.print(error)
      vim.inspect(data)
    end,
  }):start()

  return true
end

_G.mona = M

return M
