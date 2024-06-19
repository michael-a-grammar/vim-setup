local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set(
  { 'n', 'x' },
  '<leader>me',
  '<cmd>ElixirExpandMacro<cr>',
  { desc = 'Expand macro', buffer = bufnr, noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>mm',
  ':Mix ',
  { desc = 'Mix', buffer = bufnr, noremap = true }
)

vim.keymap.set({ 'n', 'x' }, '<leader>mo', function()
  require('elixir_ls.elixir_ls').open_output_panel({
    window = 'float',
  })
end, {
  desc = 'ElixirLS logs',
  buffer = bufnr,
  noremap = true,
})

vim.keymap.set(
  { 'n', 'x' },
  '<leader>mpf',
  '<cmd>ElixirFromPipe<cr>',
  { desc = 'From pipe', buffer = bufnr, noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>mpt',
  '<cmd>ElixirToPipe<cr>',
  { desc = 'To pipe', buffer = bufnr, noremap = true }
)

vim.keymap.set({ 'n', 'x' }, '<leader>mre', '<cmd>ElixirRestart | edit<cr>', {
  desc = 'Restart ElixirLS and reattach',
  buffer = bufnr,
  noremap = true,
})

vim.keymap.set(
  { 'n', 'x' },
  '<leader>mrr',
  '<cmd>ElixirRestart<cr>',
  { desc = 'Restart ElixirLS', buffer = bufnr, noremap = true }
)

vim.keymap.set({ 'n', 'x' }, '<leader>mrf', '<cmd>ElixirRestart | edit!<cr>', {
  desc = '' .. ' Restart ElixirLS',
  buffer = bufnr,
  noremap = true,
})

local to_register = {
  ['<leader>'] = {
    m = {
      name = '',

      p = {
        name = 'Pipes',
      },

      r = {
        name = 'Restart LSP',
      },
    },
  },
}

local which_key = require('which-key')

which_key.register(to_register, { mode = 'n' })
which_key.register(to_register, { mode = 'x' })
