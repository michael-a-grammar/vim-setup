local telescope         = require'telescope.builtin'
local buffer_dir        = require'telescope.utils.buffer_dir'
local file_browser      = require'telescope.extensions.file_browser.file_browser'
local file_browser_name = 'file_browser'

local finderscope = {}

finderscope.find_files_using = function() {
  local telescope_fns = {
    { file_browser_name, 'd', file_browser,          'File browser', 'path' },
    { 'find_files',      'f', telescope.find_files,  'Find files'           },
    { 'live_grep',       's', telescope.live_grep,   'Grep'                 },
    { 'grep_string',     'w', telescope.grep_string, 'Grep current word'    }
  }

}

set('d', find_within_buffer_dir(file_browser, 'path'),  'File browser')
set('f', find_within_buffer_dir(telescope.find_files),  'Find files')
set('s', find_within_buffer_dir(telescope.live_grep),   'Grep')
set('w', find_within_buffer_dir(telescope.grep_string), 'Grep current word')

local finderscope = function(telescope_fns_group)
  local using = {}

  local use = {
    find = {
      within_dir = function(within_dir_fn)
        using.within_dir_fn = within_dir_fn
        return use
      end
    },

    rg = {
      filter_files = function(file_types)
        local file_types_joined = ''

        local add_file_type = function(file_type)
          file_types_joined = file_types_joined .. '--type ' .. file_type .. ' '
        end

        if typeof(file_types) == 'table' then
          for _, val in ipairs(file_types) do
            add_file_type(val)
          end
        else
          add_file_type(file_types)
        end

        local rg_query     = { 'rg', file_types_joined, '--files' }
        using.find_command = rg_query

        return use
      end
    }

    build = function(opts)
      local desc_suffix = opts.desc_suffix  or ''
      local desc_prefix = opts.desc_prefix or ''

      if using.
      return using
    end
  }
end

local within_dir = function(within_dir_fn)
  return function(telescope_fn, within_dir_key, additional_opts)
    return function()
      local additional_opts = additional_opts or {}
      local opts            = {}

      for key, val in ipairs(additional_opts) do
        opts[key] = val
      end

      if within_dir_fn then
        opts[within_dir_key] = within_dir_fn()
      end

      telescope_fn(opts)
    end
  end
end

find_using.within_dir = function(within_dir_fn, additional_opts)
  local result                  = {}
  local telescope_within_dir_fn = within_dir(within_dir_fn)
  local additional_opts         = additional_opts                        or {}
  local telescope_builtin_opts  = additional_opts.telescope_builtin_opts or {}
  local file_browser_opts       = additional_opts.file_browser_opts      or {}
  local desc_suffix             = additional_opts.desc_suffix            or ''
  local desc_prefix             = additional_opts.desc_prefix            or ''


  for _, val in pairs(telescope_fns) do
    local name, key, telescope_fn, desc, within_dir_key = unpack(val)

    desc           = desc_prefix .. ' ' .. desc .. ' ' .. desc_suffix
    within_dir_key = within_dir_key or 'cwd'

    local opts =
      (name == file_browser_name and file_browser_opts) or
      telescope_builtin_opts

    result[name] = {
      name   = name,
      key    = key,
      action = telescope_within_dir_fn(telescope_fn, within_dir_key, opts),
      desc   = desc
    }
  end

  return result
end

find_using.set = function(key, find_using_fn)
  local set = require'milque.cartographer'.nx_leader_with(key)

  for key, val in pairs(find_using_fn) do
    set(val.key, val.action, val.desc)
  end
end

return find_using
