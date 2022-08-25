local cartograhper = {}

local with_modes = function(modes)
  return function(lhs, rhs, desc)
    cartograhper.set(modes, lhs, rhs, desc)
  end
end

local with_fn = function(fn)
  return function(prefix)
    return function(lhs, rhs, desc)
      fn(prefix .. lhs, rhs, desc)
    end
  end
end

cartograhper.set = function(modes, lhs, rhs, desc)
  vim.keymap.set(modes, lhs, rhs, {
    desc = desc or '...'
  })
end

cartograhper.nx  = with_modes({ 'n', 'x' })
cartograhper.nvo = with_modes('')
cartograhper.i   = with_modes('i')
cartograhper.c   = with_modes('c')

cartograhper.nx_with              = with_fn(cartograhper.nx)
cartograhper.nx_leader            = with_fn(cartograhper.nx)('<leader>')
cartograhper.nx_leader_with       = with_fn(cartograhper.nx_leader)
cartograhper.nx_local_leader      = with_fn(cartograhper.nx)('<localleader>')
cartograhper.nx_local_leader_with = with_fn(cartograhper.nx_leader)
cartograhper.nvo_with             = with_fn(cartograhper.nvo)

return cartograhper
