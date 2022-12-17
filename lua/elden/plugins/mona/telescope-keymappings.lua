return function()
  local telescope    = require'telescope.builtin'
  local buffer_dir   = require'telescope.utils'.buffer_dir
  local file_browser = require'telescope'.extensions.file_browser.file_browser
  local map          = require'elden.plugins.cartographer'.map

  local find_command = { 'rg', '--type', 'elixir', '--files' }

  map(function()
    nx_local_leader_with 's' {
      'f',
      function()
        telescope.find_files {
          find_command = find_command
        }
      end,
      'Find files',

      'ss',
      function()
        telescope.live_grep {
          glob_pattern = '*.ex*',
          type_filer   = 'elixir'
        }
      end,
      'Grep'
    }

    nx_local_leader_with 'u' {
      'uf',
      function()
        telescope.find_files{
          find_command = find_command,
          cwd          = buffer_dir()
        }
      end,
      'Find files',

      'us',
      function()
        telescope.live_grep{
          glob_pattern = '*.ex*',
          type_filer   = 'elixir',
          cwd          = buffer_dir()
        }
      end,
      'Grep'
    }
  end)
end
