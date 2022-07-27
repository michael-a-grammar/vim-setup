local classy       = require'milque.classy'
local cartographer = {}
cartographer.with  = {}
cartographer.wk    = {}

local function join(tbl)
  local joined = ''
  for _, val in ipairs(tbl) do
    joined = joined .. val
  end
  return joined
end

local function get_modes()
  return classy.create({
    nvo = {
      setter_fn = ' '
    },
    'n',
    'v',
    's',
    'x',
    'o',
    ic = {
      setter_fn = '!'
    },
    'i',
    'l',
    'c',
    't'
  }, {
    setter_prefix = 'mode',
    setter_fn     = classy.setters.set_field_to_key,
    values        = true,
    no_dict       = true
  })
end

local function get_opts()
  return classy.create({
    desc  = {
      default   = '...',
      setter_fn = classy.setters.set_field_to_value
    },
    'buffer',
    'expr',
    'remap'
  }, {
    setter_prefix = 'with',
    setter_fn     = classy.setters.tg_field_value,
    no_getter     = true
  })
end

local function get_lhs()
  return classy.create_dynamic_fields({
    use = {
      setter_prefix = '',
      setter_fn     = classy.setters.set_field_to_value
    },
    'leader',
    'localleader',
    'space',
    'nul',
    'tab',
    'up',
    'right',
    'down',
    'left',
    ctrl = {
      setter_fn = function(_, _, _, val)
        return '<c-' .. val .. '>'
      end
    },
    alt = {
      setter_fn = function(_, _, _, val)
        return '<a-' .. val .. '>'
      end
    }
  }, {
    setter_fn = classy.setters.set_field_to_key
  }, {
    setter_prefix = 'use',
    values        = true,
    no_dict       = true,
    setter_fn     = function(_, field_key)
      return '<' .. field_key .. '>'
    end
  })
end

local function get_rhs()
  return classy.create_dynamic_fields({
    cmd = {
      setter_fn = function(_, _, _, val)
        return '<cmd>' .. val .. '<cr>'
      end
    },
    plug = {
      setter_fn = function(_, _, _, val)
        return '<plug>(' .. val .. ')'
      end
    },
    provider = {
      setter_fn = function(tbl, _, _, val)
        if type(val) == 'function' then
          return tbl.fn(val)
        end

        for key, value in pairs(val) do
          return tbl[key](value)
        end
      end
    },
    'fn'
  }, {
    no_dict       = true,
    values        = true,
    setter_prefix = 'cmd',
    setter_fn     = function(_, field_key)
      return '<cmd>' .. field_key:gsub('_', ' ') .. '<cr>'
    end
  }, {
    setter_prefix = ''
  })
end

local function build(tbls)
  local modes = tbls.modes.__values
  local opts  = tbls.opts.__dict
  local lhs   = ''
  local rhs   = tbls.rhs.get_cmd() or tbls.rhs.get_plug() or tbls.rhs.get_fn()
  local modes_str  = ''

  modes_str = join(tbls.modes.__values)

  lhs = join(tbls.lhs.__values)

  if not rhs then
    rhs = join(tbls.rhs.__values)
  end

  --set.desc = opts.desc
  --set.rhs  = rhs

  return modes, opts, lhs, rhs
end

local function exe(modes, opts, lhs, rhs)
  vim.keymap.set(modes, lhs, rhs, opts)
end

local function with(name, modes, lhs)
  return function(desc)
    local modes_tbl = {}
    local use_wk    = name or false
    local skip      = use_wk and 2 or 1
    local count     = #lhs
    local wk        = nil

    modes:gsub('.', function(mode)
      table.insert(modes_tbl, mode)
    end)

    local map = cartographer.map()

    for _, val in pairs(modes_tbl) do
      map.modes['mode_' .. val]()
    end

    if use_wk then
      local modes_str = join(map.modes.__values)

      if cartographer.wk[modes_str] == nil then
        cartographer.wk[modes_str] = {}
      end

      wk = cartographer.wk[modes_str]
    end

    map.opts.with_desc(desc or '')

    for idx, val in pairs(lhs) do
      if idx <= skip then
        goto continue
      end

      if use_wk then
        if wk[val] == nil then
          wk[val] = {}
        end

        if idx == count then
          wk[val].name = name
        end

        wk = wk[val]
      end

      map.lhs['use_' .. val]()

      ::continue::
    end

    return map.lhs
  end
end

function cartographer.map()
  local modes = get_modes()
  local opts  = get_opts()
  local lhs   = get_lhs()
  local rhs   = get_rhs()

  local tbls = {
    modes = modes,
    opts  = opts,
    lhs   = lhs,
    rhs   = rhs
  }

  function tbls:build()
    return build(tbls)
  end

  function tbls:exe()
    return exe(tbls:build())
  end

  return classy.conjoin(tbls)
end

setmetatable(cartographer.wk, {
  __index = function(_, key)
    local set   = vim.split(key, '_')
    local name  = set[1]
    local modes = set[2]

    return with(name, modes, set)
  end
})

setmetatable(cartographer.with, {
  __index = function(_, key)
    local set   = vim.split(key, '_')
    local name  = nil
    local modes = set[1]

    return with(name, modes, set)
  end
})

return cartographer
