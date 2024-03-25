local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set({ 'n', 'x' }, '<leader>mra', function()
  vim.cmd.RustLsp('codeAction')
end, {
  desc = 'Code actions',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set('n', '<leader>mrh', function()
  vim.cmd.RustLsp({ 'hover', 'actions' })
end, {
  desc = 'Hover actions',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set('x', '<leader>mrh', function()
  vim.cmd.RustLsp({ 'hover', 'range' })
end, {
  desc = 'Hover range',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set({ 'n', 'x' }, '<leader>mrdd', function()
  vim.cmd.RustLsp('renderDiagnostic')
end, {
  desc = 'Render diagnostic',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set({ 'n', 'x' }, '<leader>mrde', function()
  vim.cmd.RustLsp('explainError')
end, {
  desc = 'Explain error',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set({ 'n', 'x' }, '<leader>mrif', function()
  vim.cmd.RustLsp({ 'moveItem', 'up' })
end, {
  desc = 'Move item up',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set({ 'n', 'x' }, '<leader>mrii', function()
  vim.cmd.RustLsp('joinLines')
end, {
  desc = 'Join lines',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set({ 'n', 'x' }, '<leader>mrip', function()
  vim.cmd.RustLsp({ 'moveItem', 'down' })
end, {
  desc = 'Move item down',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set({ 'n', 'x' }, '<leader>mrmm', function()
  vim.cmd.RustLsp('expandMacro')
end, {
  desc = 'Expand macro',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set({ 'n', 'x' }, '<leader>mrmp', function()
  vim.cmd.RustLsp('rebuildProMacros')
end, {
  desc = 'Rebuild pro macros',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set({ 'n', 'x' }, '<leader>mrrp', function()
  vim.cmd.RustLsp({ 'runnables', bang = true })
end, {
  desc = 'Rerun previous runnable',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set({ 'n', 'x' }, '<leader>mrrr', function()
  vim.cmd.RustLsp('runnables')
end, {
  desc = 'Runnables',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set({ 'n', 'x' }, '<leader>mrsc', function()
  vim.cmd.RustLsp('openCargo')
end, {
  desc = 'Open cargo',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set({ 'n', 'x' }, '<leader>mrsp', function()
  vim.cmd.RustLsp('parentModule')
end, {
  desc = 'Parent module',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set({ 'n', 'x' }, '<leader>mrss', function()
  vim.cmd.RustLsp('workspaceSymbol')
end, {
  desc = 'Workspace symbol search',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set({ 'n', 'x' }, '<leader>mrss', function()
  vim.cmd.RustLsp({ 'workspaceSymbol', 'onlyTypes' })
end, {
  desc = 'Workspace type symbol search',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set({ 'n', 'x' }, '<leader>mrtp', function()
  vim.cmd.RustLsp({ 'testables', bang = true })
end, {
  desc = 'Rerun previous testable',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

vim.keymap.set({ 'n', 'x' }, '<leader>mrtt', function()
  vim.cmd.RustLsp('testables')
end, {
  desc = 'Testables',
  buffer = bufnr,
  silent = true,
  noremap = true,
})

local to_register = {
  ['<leader>'] = {
    m = {
      name = '',

      d = {
        name = 'Diagnostics',
      },

      i = {
        name = 'Move item',
      },

      m = {
        name = 'Macros',
      },

      r = {
        name = 'Runnables',
      },

      s = {
        name = 'Find',
      },

      t = {
        name = 'Testables',
      },
    },
  },
}

local which_key = require('which-key')

which_key.register(to_register, { mode = 'n' })
which_key.register(to_register, { mode = 'x' })
