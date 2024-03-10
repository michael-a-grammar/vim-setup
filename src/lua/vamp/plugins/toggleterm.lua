return {
  'akinsho/toggleterm.nvim',

  opts = function()
    local catppuccin = require('catppuccin.palettes').get_palette('mocha')

    return {
      direction = 'float',

      float_opts = {
        border = 'rounded',
      },

      highlights = {
        FloatBorder = {
          guifg = catppuccin.blue,
        },
      },

      open_mapping = '<c-t>',

      shade_terminals = false,
    }
  end,

  config = function(_, opts)
    require('toggleterm').setup(opts)

    vim.keymap.set(
      't',
      '<c-esc>',
      '<c-\\><c-n>',
      { desc = 'Normal mode', noremap = true }
    )

    for index = 1, 5, 1 do
      local terminal_index = tostring(index)
      local keymap_index = index == 1 and '' or terminal_index

      vim.keymap.set(
        { 'n', 'x' },
        '<leader>r' .. keymap_index .. 'e',
        ':' .. terminal_index .. 'TermExec cmd="',
        { desc = 'Terminal exec', noremap = true }
      )

      vim.keymap.set(
        { 'n', 'x' },
        '<leader>r' .. keymap_index .. 'h',
        '<cmd>' .. terminal_index .. 'ToggleTerm direction=horizontal<cr>',
        { desc = 'Toggle terminal horizontal', noremap = true }
      )

      vim.keymap.set(
        { 'n', 'x' },
        '<leader>r' .. keymap_index .. 'r',
        '<cmd>' .. terminal_index .. 'ToggleTerm direction=float<cr>',
        { desc = 'Toggle terminal float', noremap = true }
      )

      vim.keymap.set(
        { 'n', 'x' },
        '<leader>r' .. keymap_index .. 'v',
        '<cmd>' .. terminal_index .. 'ToggleTerm direction=vertical<cr>',
        { desc = 'Toggle terminal vertical', noremap = true }
      )
    end

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>rx',
      '<cmd>ToggleTermToggleAll<cr>',
      { desc = 'Toggle all terminals', noremap = true }
    )
  end,
}
