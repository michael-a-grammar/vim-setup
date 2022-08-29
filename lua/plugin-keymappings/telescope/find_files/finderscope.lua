local telescope    = require'telescope.builtin'
local file_browser = require'telescope'.extensions.file_browser.file_browser
local finderscope  = {}

finderscope.find_files_using = function(opts)
  local find_files_within_dir_fn = opts.find_files_within_dir_fn
  local file_types               = opts.file_types
  local desc_suffix              = opts.desc_suffix or ''
  local maps                     = {}

  local set_wd = function(key, picker_opts)
    if find_files_within_dir_fn then
      picker_opts[key] = find_files_within_dir_fn()
    end
    return picker_opts
  end

  local cwd = function(picker_opts)
    return set_wd('cwd', picker_opts)
  end

  local path = function(picker_opts)
    return set_wd('path', picker_opts)
  end

  local rg = function(picker_opts)
    if file_types then
      local file_types_joined = ''

      local add_file_type = function(file_type)
        file_types_joined = file_types_joined .. '--type ' .. file_type .. ' '
      end

      if typeof(opts.file_types) == 'table' then
        for _, val in ipairs(file_types) do
          add_file_type(val)
        end
      else
        add_file_type(file_types)
      end

      picker_opts.find_command = { 'rg', file_types_joined, '--files' }
    end
    return picker_opts
  end

  local pickers = {
    {
      name = 'file_browser',
      key  = 'd',
      fn   = file_browser,
      desc = 'File browser',
      opts = {
        cwd        = path,
        file_types = false
      }
    },
    {
      name = 'find_files',
      key  = 'f',
      fn   = telescope.find_files,
      desc = 'Find files',
      opts = {
        cwd        = cwd,
        file_types = rg
      },
    },
    {
      name = 'live_grep',
      key  = 's',
      fn   = telescope.live_grep,
      desc = 'Grep',
      opts = {
        cwd        = cwd,
        file_types = rg
      }
    }
    --{ 'grep_string',     'w', telescope.grep_string, 'Grep current word' }
  }

  for _, picker in ipairs(pickers) do
    local picker_opts  = {}
    local desc         = picker.desc .. (desc_suffix and ' ' .. desc_suffix)

    maps[picker.name] = {
      key    = picker.key,
      desc   = desc,
      action = function()
        for _, opt in pairs(picker.opts) do
          if opt then
            opt(picker_opts)
          end
        end
        picker.fn(picker_opts)
      end
    }
  end

  return maps
end

finderscope.set = function(set_fn, finderscope_fn)
  local set = set_fn()

  for key, val in pairs(finderscope_fn) do
    set(val.key, val.action, val.desc)
  end
end

return finderscope
