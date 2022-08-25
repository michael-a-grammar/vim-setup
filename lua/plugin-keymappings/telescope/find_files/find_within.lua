local telescope              = require'telescope.builtin'
local buffer_dir             = require'telescope.utils'.buffer_dir
local file_browser           = require'telescope'.extensions.file_browser.file_browser
local find_within            = {}
local find_within.buffer_dir = {}

local within = function(within_fn)
  return function(fn, within_key, additional_opts)
    return function()
      local additional_opts = additional_opts or {}
      local opts            = {}
      local within_key      = within_key or 'cwd'

      for key, val in ipairs(additional_opts) do
        opts[key] = val
      end

      opts[key] = within_fn()

      fn(opts)
    end
  end
end

-- So like, you want to be able to generate these funcs for a provided within
-- func

local within_buffer_dir = within(buffer_dir)

find_within.buffer_dir.file_browser = function(opts)
  within_buffer_dir(file_browser, 'path', opts)
end

find_within.buffer_dir.find_files = function(opts)
  within_buffer_dir(telescope.find_files, 'path', opts)
end

find_within.buffer_dir.live_grep = function(opts)
  within_buffer_dir(telescope.live_grep, 'path', opts)
end

find_within.buffer_dir.grep_string = function(opts)
  within_buffer_dir(telescope.live_grep, 'path', opts)
end

find_within_buffer_dir(telescope.find_files),  'Find files')
find_within_buffer_dir(telescope.live_grep),   'Grep')
find_within_buffer_dir(telescope.grep_string), 'Grep current word')
