local Job = require('plenary.job')
local Path = require('plenary.path')

local M = {}

M.elixir = {}
M.elixir.modules = {}

M.telescope = {}
M.telescope.elixir = {}
M.telescope.elixir.modules = {}

local function get_cwd()
  if true then
    return Path:new(Path:new('~/crash'):expand())
  else
    return Path:new(vim.fn.getcwd())
  end
end

local function get_project_directory()
  local path = get_cwd()

  local git_path = path:find_upwards('.git')

  if git_path == nil then
    return false
  end

  local project_path = git_path:parent()
  local mix_path = Path:new(project_path.filename .. '/mix.exs')

  if not mix_path:exists() then
    return false
  end

  return project_path
end

M.elixir.modules.project = function(with_modules)
  return function()
    local project_directory = get_project_directory()

    if not project_directory then
      return false
    end

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
        if code == 0 then
          local modules = {}

          for _, module in ipairs(self:result()) do
            local path, line_number, column_number, module_name =
              string.match(module, '(.*):(.*):(.*):(.*)')

            table.insert(modules, {
              path = path,
              line_number = line_number,
              column_number = column_number,
              module_name = module_name,
            })
          end

          with_modules(modules)
        end
      end,
      on_stderr = function(error, _)
        vim.notify(error)
      end,
    }):start()

    return true
  end
end

M.telescope.elixir.modules.project = function()
  local project_directory = get_project_directory()

  if not project_directory then
    return false
  end

  local config = require('telescope.config')
  local finders = require('telescope.finders')
  local pickers = require('telescope.pickers')

  local config_values = config.values

  pickers
    :new({
      prompt_title = ' Project Modules',

      finder = finders.new_oneshot_job({
        'rg',
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
      }, {
        entry_maker = function(entry)
          local path, line_number, column_number, module_name =
            string.match(entry, '(.*):(.*):(.*):(.*)')

          return {
            col = tonumber(column_number),
            display = module_name,
            lnum = tonumber(line_number),
            ordinal = module_name,
            path = path,
            value = entry,
          }
        end,
      }),

      previewer = config_values.grep_previewer({}),
      sorter = config_values.generic_sorter({}),
    })
    :find()

  return true
end

M.telescope.elixir.modules.tests = function()
  local project_directory = get_project_directory()

  if not project_directory then
    return false
  end

  local config = require('telescope.config')
  local finders = require('telescope.finders')
  local pickers = require('telescope.pickers')

  local config_values = config.values

  pickers
    :new({
      prompt_title = ' Tests',

      finder = finders.new_oneshot_job({
        'rg',
        '--case-sensitive',
        '--trim',
        '--vimgrep',
        '--with-filename',
        '--word-regexp',
        '--glob',
        '*.exs',
        '--replace',
        '$1',
        '--regexp',
        'defmodule ([a-zA-Z.]*)Test do$',
        project_directory.filename,
      }, {
        entry_maker = function(entry)
          local path, line_number, column_number, module_name =
            string.match(entry, '(.*):(.*):(.*):(.*)')

          return {
            col = tonumber(column_number),
            display = module_name,
            lnum = tonumber(line_number),
            ordinal = module_name,
            path = path,
            value = entry,
          }
        end,
      }),

      previewer = config_values.grep_previewer({}),
      sorter = config_values.generic_sorter({}),
    })
    :find()

  return true
end

_G.mona = M

return M
