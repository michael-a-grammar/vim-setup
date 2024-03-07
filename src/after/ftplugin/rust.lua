local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set({ 'n', 'x' }, '<localleader>ra', function()
  vim.cmd.RustLsp('codeAction')
end, { desc = 'Code actions', buffer = bufnr, noremap = true, silent = true })

vim.keymap.set('n', '<localleader>rh', function()
  vim.cmd.RustLsp({ 'hover', 'actions' })
end, { desc = 'Hover actions', buffer = bufnr, noremap = true, silent = true })

vim.keymap.set('x', '<localleader>rh', function()
  vim.cmd.RustLsp({ 'hover', 'range' })
end, { desc = 'Hover range', buffer = bufnr, noremap = true, silent = true })

vim.keymap.set(
  { 'n', 'x' },
  '<localleader>rdd',
  function()
    vim.cmd.RustLsp('renderDiagnostic')
  end,
  { desc = 'Render diagnostic', buffer = bufnr, noremap = true, silent = true }
)

vim.keymap.set({ 'n', 'x' }, '<localleader>rde', function()
  vim.cmd.RustLsp('explainError')
end, { desc = 'Explain error', buffer = bufnr, noremap = true, silent = true })

vim.keymap.set({ 'n', 'x' }, '<localleader>rif', function()
  vim.cmd.RustLsp({ 'moveItem', 'up' })
end, { desc = 'Move item up', buffer = bufnr, noremap = true, silent = true })

vim.keymap.set({ 'n', 'x' }, '<localleader>rii', function()
  vim.cmd.RustLsp('joinLines')
end, { desc = 'Join lines', buffer = bufnr, noremap = true, silent = true })

vim.keymap.set({ 'n', 'x' }, '<localleader>rip', function()
  vim.cmd.RustLsp({ 'moveItem', 'down' })
end, { desc = 'Move item down', buffer = bufnr, noremap = true, silent = true })

vim.keymap.set({ 'n', 'x' }, '<localleader>rmm', function()
  vim.cmd.RustLsp('expandMacro')
end, { desc = 'Expand macro', buffer = bufnr, noremap = true, silent = true })

vim.keymap.set(
  { 'n', 'x' },
  '<localleader>rmp',
  function()
    vim.cmd.RustLsp('rebuildProMacros')
  end,
  { desc = 'Rebuild pro macros', buffer = bufnr, noremap = true, silent = true }
)

vim.keymap.set({ 'n', 'x' }, '<localleader>rrp', function()
  vim.cmd.RustLsp({ 'runnables', bang = true })
end, {
  desc = 'Rerun previous runnable',
  buffer = bufnr,
  noremap = true,
  silent = true,
})

vim.keymap.set({ 'n', 'x' }, '<localleader>rrr', function()
  vim.cmd.RustLsp('runnables')
end, { desc = 'Runnables', buffer = bufnr, noremap = true, silent = true })

vim.keymap.set({ 'n', 'x' }, '<localleader>rsc', function()
  vim.cmd.RustLsp('openCargo')
end, { desc = 'Open cargo', buffer = bufnr, noremap = true, silent = true })

vim.keymap.set({ 'n', 'x' }, '<localleader>rsp', function()
  vim.cmd.RustLsp('parentModule')
end, { desc = 'Parent module', buffer = bufnr, noremap = true, silent = true })

vim.keymap.set({ 'n', 'x' }, '<localleader>rss', function()
  vim.cmd.RustLsp('workspaceSymbol')
end, {
  desc = 'Workspace symbol search',
  buffer = bufnr,
  noremap = true,
  silent = true,
})

vim.keymap.set({ 'n', 'x' }, '<localleader>rss', function()
  vim.cmd.RustLsp({ 'workspaceSymbol', 'onlyTypes' })
end, {
  desc = 'Workspace type symbol search',
  buffer = bufnr,
  noremap = true,
  silent = true,
})

vim.keymap.set({ 'n', 'x' }, '<localleader>rtp', function()
  vim.cmd.RustLsp({ 'testables', bang = true })
end, {
  desc = 'Rerun previous testable',
  buffer = bufnr,
  noremap = true,
  silent = true,
})

vim.keymap.set({ 'n', 'x' }, '<localleader>rtt', function()
  vim.cmd.RustLsp('testables')
end, { desc = 'Testables', buffer = bufnr, noremap = true, silent = true })
