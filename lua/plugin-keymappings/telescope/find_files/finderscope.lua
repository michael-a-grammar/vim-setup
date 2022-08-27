local telescope         = require'telescope.builtin'
local file_browser      = require'telescope'.extensions.file_browser.file_browser
local finderscope       = {}
local file_browser_name = 'file_browser'

finderscope.find_files_using = function(opts) 
  local find_files_within_dir_fn = opts.find_files_within_dir_fn
  local file_types               = opts.file_types
  local desc_prefix              = opts.desc_prefix or ''
  local desc_suffix              = opts.desc_suffix or ''
  local result                   = {}

  local telescope_fns = {
    { file_browser_name, 'd', file_browser,          'File browser',     },
    { 'find_files',      'f', telescope.find_files,  'Find files'        },
    { 'live_grep',       's', telescope.live_grep,   'Grep'              },
    { 'grep_string',     'w', telescope.grep_string, 'Grep current word' }
  }

  for _, val in pairs(telescope_fns) do
    local name, key, telescope_fn, desc = unpack(val)

    desc = desc_prefix .. ' ' .. desc .. ' ' .. desc_suffix

    local telescope_opts  = {}
    local is_file_browser = name == file_browser_name

    if file_types and not is_file_browser then
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

      telescope_opts.find_command = { 'rg', file_types_joined, '--files' }
    end

    result[name] = {
      key    = key,
      desc   = desc,
      action = function()
        print(vim.bo.filetype)
        if find_files_within_dir_fn then
          local cwd_key           =  (is_file_browser and 'path') or 'cwd'
          telescope_opts[cwd_key] = find_files_within_dir_fn()
        end

        telescope_opts.additional_args = function(opts)
          require'milque.neon'.i(opts)
        end
        telescope_fn(telescope_opts)
      end
    }
  end

  return result
end

finderscope.set = function(set_fn, finderscope_fn)
  local set = set_fn()

  for key, val in pairs(finderscope_fn) do
    set(val.key, val.action, val.desc)
  end
end

return finderscope
