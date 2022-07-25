return function(opts)
  require'plugin-keymappings.lsp.definitions'(opts)
  require'plugin-keymappings.lsp.diagnostics'(opts)
  require'plugin-keymappings.lsp.navigation'()
  require'plugin-keymappings.lsp.refactor'(opts)
end
