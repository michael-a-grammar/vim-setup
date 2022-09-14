return function()
  local telescope    = require'telescope.builtin'
  local buffer_dir   = require'telescope.utils'.buffer_dir
  local file_browser = require'telescope'.extensions.file_browser.file_browser
  local set          = require'milque.cartographer'.nx_leader_with'u'

  set(
    'd',
    function()
      file_browser{
        path = buffer_dir()
      }
    end,
    'File browser')

  set(
    'f',
    function()
      telescope.find_files{
        cwd = buffer_dir()
      }
    end,
    'Find files')

  set(
    's',
    function()
      telescope.live_grep{
        cwd = buffer_dir()
      }
    end,
    'Grep')

  set(
    'w',
    function()
      telescope.grep_string{
        cwd = buffer_dir()
      }
    end,
    'Grep current word')
end
