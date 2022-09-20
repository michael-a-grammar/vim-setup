local M = {}
M.b     = {}

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
  tbl.nx  = with_modes({ 'n', 'x' }, buffer)
  tbl.nvo = with_modes('',           buffer)
  tbl.i   = with_modes('i',          buffer)
  tbl.c   = with_modes('c',          buffer)

  tbl.nx_with              = with_fn(tbl.nx)
  tbl.nx_leader            = with_fn(tbl.nx)('<leader>')
  tbl.nx_leader_with       = with_fn(tbl.nx_leader)
  tbl.nx_local_leader      = with_fn(tbl.nx)('<localleader>')
  tbl.nx_local_leader_with = with_fn(tbl.nx_leader)
  tbl.nvo_with             = with_fn(tbl.nvo)
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

M.set = function(modes, maps, buffer)
  for _, map in ipairs(maps) do
    local lhs, rhs, desc = unpack(map)

    lhs = (maps.prefix or '') .. tostring(lhs)

    if type(rhs) == 'table' then
      rhs = tostring(rhs)
    end

    vim.keymap.set(modes, lhs, rhs, {
      desc   = desc or '...',
      buffer = buffer
    })
  end
end

M.cmd   = special('cmd')
M.ent   = special('cr')
M.esc   = special('esc')
M.down  = special('down')
M.left  = special('left')
M.right = special('right')
M.top   = special('top')
M.ctrl  = modifier('c')
M.alt   = modifier('a')

M.exe      = surround(M.cmd, M.ent)
M.cmd_mode = surround(':',   M.ent)

M.map = function(fn)
  debug.setfenv(fn, setmetatable(M, {
    __index = _G
  }))
  return fn()
end

with(M,   false)
with(M.b,  true)

return M
