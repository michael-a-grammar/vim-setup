local M = {}

M.b = {}

local local_opts = {
  use_table_maps = false
}

local metatable = {
  __index = _G,
  __call  = function(self, opts)
    local_opts.use_table_maps = opts.use_table_maps
    return self
  end
}

local with_modes = function(modes, buffer)
  return function(maps)
    M.set(modes, maps, buffer)
  end
end

local with_fn = function(fn)
  return function(prefix)
    return function(maps)
      maps.prefix = prefix .. (maps.prefix or '')
      fn(maps)
    end
  end
end

local with = function(tbl, buffer)
  local leader_modes = {
    'n',
    'v',
    's',
    'x',
    'o',
    't',
    'nx',
    ['nvo'] = ''
  }

  for _, mode in ipairs(leader_modes) do
    local modes = {}

    mode:gsub('.', function(char)
      table.insert(modes, char)
    end)
  end

  for mode, mode_value in pairs(leader_modes) do
  end

  tbl.n   = with_modes('n',          buffer)
  tbl.nx  = with_modes({ 'n', 'x' }, buffer)
  tbl.nvo = with_modes('',           buffer)
  tbl.x   = with_modes('x',          buffer)
  tbl.i   = with_modes('i',          buffer)
  tbl.c   = with_modes('c',          buffer)

  tbl.n_with               = with_fn(tbl.n)
  tbl.n_leader             = with_fn(tbl.n)('<leader>')
  tbl.n_leader_with        = with_fn(tbl.n_leader)
  tbl.nx_with              = with_fn(tbl.nx)
  tbl.nx_leader            = with_fn(tbl.nx)('<leader>')
  tbl.nx_leader_with       = with_fn(tbl.nx_leader)
  tbl.nvo_with             = with_fn(tbl.nvo)
  tbl.nvo_leader           = with_fn(tbl.nvo)('<leader>')
  tbl.nvo_leader_with      = with_fn(tbl.nvo_leader)
  tbl.x_with               = with_fn(tbl.x)
  tbl.x_leader             = with_fn(tbl.x)('<leader>')
  tbl.x_leader_with        = with_fn(tbl.x_leader)

  tbl.nx_local_leader      = with_fn(tbl.nx)('<localleader>')
  tbl.nx_local_leader_with = with_fn(tbl.nx_local_leader)
end

local surround = function(s, e)
  return function(rhs)
    return s .. rhs .. e
  end
end

local special = surround('<', '>')

local modifier = function(mod)
  return function(key)
    return setmetatable({
      lhs  = surround('<' .. mod .. '-', '>')(key),
      with = function(self, lhs)
        self.lhs = self.lhs .. lhs
        return self
      end
    }, {
      __tostring = function(self)
        return self.lhs
      end
    })
  end
end

local leader = function(is_local)
  local key = 'map' .. ((is_local and 'local') or '') .. 'leader'

  return function(leader_key)
    vim.g[key] =
      vim.api.nvim_replace_termcodes(leader_key, true, true, true)
  end
end

M.set = function(modes, maps, buffer)
  local collected_maps = (local_opts.use_table_maps and maps) or {}

  if not local_opts.use_table_maps then
    local collected_map  = {}

    for index, map_segment in ipairs(maps) do
      table.insert(collected_map, map_segment)

      if index % 3 == 0 then
        table.insert(collected_maps, collected_map)
        collected_map = {}
      end
    end
  end

  for _, map in ipairs(collected_maps) do
    local lhs, rhs, desc = unpack(map)

    lhs  = (maps.prefix or '') .. tostring(lhs)
    expr = false

    if type(rhs) == 'table' then
      rhs = tostring(rhs)
    elseif type(rhs) == 'string'
      expr = true
    end

    vim.keymap.set(modes, lhs, rhs, {
      desc   = desc or '...',
      buffer = buffer,
      expr = expr
    })
  end
end

M.cmd   = special('cmd')
M.ent   = special('cr')
M.esc   = special('esc')
M.ldr   = special('leader')
M.nop   = special('nop')
M.spc   = special('space')
M.tab   = special('tab')
M.down  = special('down')
M.left  = special('left')
M.right = special('right')
M.up    = special('up')
M.ctrl  = modifier('c')
M.alt   = modifier('a')

M.exe      = surround(M.cmd,   M.ent)
M.plug     = surround('<plug>(', ')')
M.expr     = surround('<expr> ',  '')
M.cmd_mode = surround(':',        '')

M.leader       = leader(false)
M.local_leader = leader(true)

M.map = function(fn)
  debug.setfenv(fn, M)
  return fn()
end

with(M,   false)
with(M.b,  true)

setmetatable(M, metatable)

return M
