return function(opts)
  require'plugin-keymappings.telescope.lsp.diagnostics'(opts)
  require'plugin-keymappings.telescope.lsp.navigation'(opts)
  require'plugin-keymappings.telescope.lsp.refactor'(opts)
end
