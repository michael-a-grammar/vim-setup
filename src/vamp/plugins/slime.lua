return {
  'jpalardy/vim-slime',

  init = function()
    local env = vim.env
    local g = vim.g
    local split = vim.split
    local set_keymap = vim.keymap.set

    g.slime_no_mappings = true

    if env.TMUX then
      g.slime_dont_ask_default = true
      g.slime_target = 'tmux'

      g.slime_default_config = {
        socket_name = split(env.TMUX, ',')[1],
        target_pane = ':0.{last}',
      }
    elseif env.KITTY_LISTEN_ON then
      g.slime_target = 'kitty'

      g.slime_default_config = {
        listen_on = 'unix:/tmp/mykitty',
      }
    end

    set_keymap(
      { 'n', 'x' },
      '<leader>c%',
      '<cmd>%SlimeSend<cr>',
      { desc = 'Send buffer to REPL', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>cc',
      '<plug>(SlimeConfig)',
      { desc = 'Configure REPL', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>ci',
      '<cmd>SlimeSendCurrentLine<cr>',
      { desc = 'Send line to REPL', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>cp',
      '<plug>(SlimeParagraphSend)',
      { desc = 'Send paragraph to REPL', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>cr',
      '<plug>(SlimeRegionSend)',
      { desc = 'Send region to REPL', noremap = true }
    )

    set_keymap(
      'x',
      '<leader>cv',
      "<cmd>'<,'>SlimeSend<cr>",
      { desc = 'Send selection to REPL', noremap = true }
    )
  end,
}
