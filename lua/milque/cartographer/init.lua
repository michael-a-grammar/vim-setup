local classy       = require'milque.classy'
local cartographer = {}

local function get_modes()
  return classy:create({
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
  return classy:create({
    desc  = {
      default   = '...',
      setter_fn = classy.setters.set_field_to_value,
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
  return classy:create_dynamic_fields({
    'leader',
    ctrl = {
      setter_fn = function(_, _, _, val)
        return '<' .. 'c-' .. val .. '>'
      end
    },
    alt = {
      setter_fn = function(_, _, _, val)
        return '<' .. 'a-' .. val .. '>'
      end
    },
    'space'
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
  return classy:create_dynamic_fields({
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

  for _, val in ipairs(tbls.lhs.__values) do
    lhs = lhs .. val
  end

  if not rhs then
    rhs = ''
    for _, val in ipairs(tbls.rhs.__values) do
      rhs = rhs .. val
    end
  end

  return modes, opts, lhs, rhs
end

local function exe(modes, opts, lhs, rhs)
  local i = require'neon'.i
  i(modes)
  i(opts)
  i(lhs)
  i(rhs)
  vim.keymap.set(modes, lhs, rhs, opts)

  return modes, opts, lhs, rhs
end

function cartographer.map()
  local modes, opts, lhs, rhs
    = get_modes(), get_opts(), get_lhs(), get_rhs()

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
    return exe(tbls.build())
  end

  return classy.conjoin(tbls)
end


--local w,x,y,z =
  --cartographer
    --.map()
    --.modes
      --.mode_n()
      --.mode_v()
    --.opts
      --.with_buffer()
      --.with_desc('hello!')
    --.lhs
      --.use_leader()
      --.use_ctrl('x')
      --.use_space()
    --.rhs
      --.cmd('help lua')
      --.exe()

--i(w)
--i(x)
--i(y)
--i(z)

return cartographer
