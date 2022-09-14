local cartographer = {}
cartographer.b     = {}

local with_modes = function(modes, buffer)
  return function(maps)
    cartographer.set(modes, maps, buffer)
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

cartographer.set = function(modes, maps, buffer)
  for _, map in ipairs(maps) do
    local lhs, rhs, desc = unpack(map)

    vim.keymap.set(modes, maps.prefix .. lhs, rhs, {
      desc   = desc or '...',
      buffer = buffer
    })
  end
end

with(cartographer,   false)
with(cartographer.b, true)

return cartographer
