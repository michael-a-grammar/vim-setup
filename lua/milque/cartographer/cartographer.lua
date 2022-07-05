function cartographer.keymap.modes()
  local modes = {
    'n',
    'v',
    's',
    'x',
    'o',
    'i',
    'l',
    'c',
    't'
  }

  local selected_modes = {}
  local mode_selector  = {}

  local function add_mode_selector(mode)
    return function()
      selected_modes[mode] = mode
      return mode_selector
    end
  end

  for _, mode in ipairs(modes) do
    mode_selector[mode] = add_mode_selector(mode)
  end

  mode_selector['nvo'] = add_mode_selector(' ')
  mode_selector['ic']  = add_mode_selector('!')

  return mode_selector
end

function cartographer.keymap.lhs()
end

cartographer.keymap.modes()

return cartographer
