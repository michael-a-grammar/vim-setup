local i = require 'neon'.i
local classy       = require'milque.classy'
local cartographer = {}
cartographer.map   = {}
cartographer.build = {}

local function keymap(modes, lhs_prefix, lhs_suffix, rhs, opts)
  vim.keymap.set(modes, lhs_prefix .. lhs_suffix, rhs, opts)
end

function cartographer.n_leader(lhs, rhs, opts)
  return function()
    keymap('n', '<leader>', rhs, opts)
  end
end

local function get_modes()
  local mode_fields = {
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

  local mode_opts = {
    set_field_key_prefix = 'mode',
    set_field_fn         = classy.field_fn.set_field_to_key
  }

  local modes = classy:create(mode_fields, mode_opts)

  mode_opts.set_field_fn = function() return ' '  end
  classy:create_field(modes, 'nvo', mode_opts)

  mode_opts.set_field_fn = function() return '!' end
  classy:create_field(modes, 'ic', mode_opts)

  return modes
end

local function get_opts()
  local opt_fields = {
    'desc',
    'buffer',
    'expr',
    'remap',
  }

  return classy:create(opt_fields, {
    set_field_key_prefix = 'with'
  })
end

local function get_lhs()
  local lhs_fields = {
    'leader',
    'ctrl'
  }

  local lhs_opts = {
    set_field_key_prefix = 'use',
    set_field_fn         = function(_, key)
      return '<' .. key .. '>'
    end
  }

  local lhs_mt_opts = {
    set_field_fn = function(_, key)
      return key:gsub(lhs_opts.set_field_key_prefix .. '_', '')
    end
  }

  local lhs_mt = setmetatable({}, {
    __index = function(tbl, key)
      return function()
        local _, set_field_key = classy:create_field(tbl, key, lhs_mt_opts)
        rawget(tbl, set_field_key)()
        return tbl
      end
    end
  })

  local lhs = classy:create_fields(lhs_mt, lhs_fields, lhs_opts)

  return lhs
end

function cartographer.build_map()
  local modes, opts, lhs = get_modes(), get_opts(), get_lhs()

  function map()
    local sel_modes = {}
    local sel_opts  = {}
    local sel_lhs   = {}

    for mode_name, mode_val in pairs(modes) do
      if type(mode_val) == 'string' then
        table.insert(sel_modes, mode_val)
      end
    end

    for opt_name, opt_val in pairs(opts) do
      if (type(opt_val) == 'boolean' or type(opt_val) == 'string')
          and opt_val then
        sel_opts[opt_name] = true
      end
    end

    for _, lhs_val in ipairs(rawget(lhs, '__values')) do
      if type(lhs_val) == 'string' then
        table.insert(sel_lhs, lhs_val)
      end
    end

    return {
      modes = sel_modes,
      opts  = sel_opts,
      lhs   = sel_lhs
    }
  end

  local tbls = {
    modes = modes,
    opts  = opts,
    lhs   = lhs,
    map   = map
  }

  local merged = classy.merge(tbls)

  return merged
end

--local x = cartographer.build_map()

local x =
  cartographer
    .build_map()
    .modes
      .mode_n()
      .mode_x()
      .mode_nvo()
      .mode_ic()
    .opts
      .with_desc('hello!')
    .lhs
      .use_leader()
      .use_xyz()
      .use_a()
      .use_b()
    .map()

local function set(sel_lhs)
  local lhs_j = ''
  for _, lhs in ipairs(sel_lhs) do
    lhs_j = lhs_j .. lhs
  end

  return lhs_j
end

i(set(x.lhs))

return cartographer
