local telescope         = require'telescope.builtin'
local buffer_dir        = require'telescope.utils'.buffer_dir
local file_browser      = require'telescope'.extensions.file_browser.file_browser
local telescope_pickers = {}
local file_browser      = {}
local find_files        = {}
local live_grep         = {}
local grep_string       = {}

local set_opt_with_fn = function(opts, key, fn)
  opts[key] = fn
end

local file_browser.find_within_buffer_dir = function()
  set_opt_with_fn(file_browser.opts, 'path', buffer_dir)
  return file_browser
end

local telescope_pickers.file_browser = function(fn)
  fn(file_browser)
end

local telescope_pickers.find_files = function(fn)
  fn(find_files)
end

local set_picker_opts_fns = function(picker, opts_fns)
end

set_picker_opts_fns(find_files

return telescope_pickers
