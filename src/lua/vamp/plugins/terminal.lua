return {
  'rebelot/terminal.nvim',

  config = function(_, _)
    require('terminal').setup()

    local term_map = require('terminal.mappings')
    local terminal_mappings = require('terminal.mappings')

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>rs',
      term_map.operator_send,
      { expr = true }
    )

    vim.keymap.set('n', '<leader>ro', term_map.toggle)
    vim.keymap.set('n', '<leader>rO', term_map.toggle({ open_cmd = 'enew' }))
    vim.keymap.set('n', '<leader>rr', term_map.run)

    vim.keymap.set(
      'n',
      '<leader>rR',
      term_map.run(nil, { layout = { open_cmd = 'enew' } })
    )

    vim.keymap.set('n', '<leader>rk', term_map.kill)
    vim.keymap.set('n', '<leader>r]', term_map.cycle_next)
    vim.keymap.set('n', '<leader>r[', term_map.cycle_prev)

    vim.keymap.set(
      'n',
      '<leader>rl',
      term_map.move({ open_cmd = 'belowright vnew' })
    )

    vim.keymap.set(
      'n',
      '<leader>rL',
      term_map.move({ open_cmd = 'botright vnew' })
    )

    vim.keymap.set(
      'n',
      '<leader>rh',
      term_map.move({ open_cmd = 'belowright new' })
    )

    vim.keymap.set(
      'n',
      '<leader>rH',
      term_map.move({ open_cmd = 'botright new' })
    )

    vim.keymap.set('n', '<leader>rf', term_map.move({ open_cmd = 'float' }))

    vim.api.nvim_create_autocmd({
      'BufWinEnter',
      'WinEnter',
      'TermOpen',
    }, {
      callback = function(args)
        if vim.startswith(vim.api.nvim_buf_get_name(args.buf), 'term://') then
          vim.cmd('startinsert')
        end
      end,
    })
  end,
}
