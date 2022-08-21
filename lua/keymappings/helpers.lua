local helpers = {}

helpers.set = function(modes, lhs, rhs, desc)
  vim.keymap.set(modes, lhs, rhs, {
    desc = desc or '...'
  })
end

helpers.nx = function(lhs, rhs, desc)
  helpers.set({ 'n', 'x' }, lhs, rhs, desc)
end

helpers.i = function(lhs, rhs, desc)
  helpers.set('i', lhs, rhs, desc)
end

helpers.c = function(lhs, rhs, desc)
  helpers.set('c', lhs, rhs, desc)
end

helpers.nx_leader = function(lhs, rhs, desc)
  helpers.nx('<leader>' .. lhs, rhs, desc)
end

helpers.nx_leader_with = function(prefix)
  return function(lhs, rhs, desc)
    helpers.nx_leader(prefix .. lhs, rhs, desc)
  end
end

return helpers
