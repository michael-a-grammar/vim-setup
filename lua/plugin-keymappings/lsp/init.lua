return function(opts)
  require'plugin-keymappings.lsp.definitions'(opts)
  require'plugin-keymappings.lsp.diagnostics'(opts)
  require'plugin-keymappings.lsp.goto'()
end
