return function()
  local telescope    = require'telescope.builtin'
  local buffer_dir   = require'telescope.utils'.buffer_dir
  local file_browser = require'telescope'.extensions.file_browser.file_browser
  local set          = require'milque.cartographer'.nx_local_leader

  local find_command = { 'rg', '--type', 'elixir', '--files' }

  set(
    'sf',
    function()
      telescope.find_files {
        find_command = find_command
      }
    end,
    'Find files')

  set(
    'ss',
    function()
      telescope.live_grep {
        glob_pattern = '*.ex*',
        type_filer   = 'elixir'
      }
    end,
    'Grep')

  set(
    'uf',
    function()
      telescope.find_files{
        find_command = find_command,
        cwd          = buffer_dir()
      }
    end,
    'Find files')

  set(
    'us',
    function()
      telescope.live_grep{
        glob_pattern = '*.ex*',
        type_filer   = 'elixir',
        cwd          = buffer_dir()
      }
    end,
    'Grep')
end
