local helpers = {}

local with_modes = function(modes)
  return function(lhs, rhs, desc)
    helpers.set(modes, lhs, rhs, desc)
  end
end

local with_fn = function(fn)
  return function(prefix)
    return function(lhs, rhs, desc)
      fn(prefix .. lhs, rhs, desc)
    end
  end
end

helpers.set = function(modes, lhs, rhs, desc)
  vim.keymap.set(modes, lhs, rhs, {
    desc = desc or '...'
  })
end

helpers.nx  = with_modes({ 'n', 'x' })
helpers.nvo = with_modes('')
helpers.i   = with_modes('i')
helpers.c   = with_modes('c')

helpers.nx_with        = with_fn(helpers.nx)
helpers.nx_leader      = with_fn(helpers.nx)('<leader>')
helpers.nx_leader_with = with_fn(helpers.nx_leader)
helpers.nvo_with       = with_fn(helpers.nvo)

return helpers
