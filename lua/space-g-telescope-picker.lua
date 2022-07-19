local pickers      = require 'telescope.pickers'
local finders      = require 'telescope.finders'
local config       = require 'telescope.config'
local themes       = require 'telescope.themes'
local actions      = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

local config_values = config.values

local colors = function(opts)
  opts = opts or {}

  pickers.new(opts, {
    prompt_title = 'colors',

    --finder = finders.new_table {
      --results = { 'red', 'green', 'blue' }
      --},

      finder = finders.new_table {
        results = {
          { "red", "#ff0000" },
          { "green", "#00ff00" },
          { "blue", "#0000ff" },
        },
        entry_maker = function(entry)
          return {
            display = entry[1],
            ordinal = entry[1],
            value = entry,
          }
        end
      },

      sorter = config_values.generic_sorter(opts),

      attach_mappings = function(prompt_bufnr, map)
        map('n', 'n', function(a)
          print(vim.inspect(a))
        end)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          --print(vim.inspect(selection))
          vim.api.nvim_put({ selection[1] }, '', false, true)
        end)
        return true
      end,
    }):find()
  end

  --print(vim.inspect(actions))
  colors(themes.get_dropdown{})

