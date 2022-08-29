return function()
  local telescope = require'telescope.builtin'
  local set       = require'milque.cartographer'.nx_leader_with('t')

  set(
    't',
    function()
      telescope.buffers{
        ignore_current_buffer = true,
        sort_mru              = true
      }
    end,
    'Buffers')
end

