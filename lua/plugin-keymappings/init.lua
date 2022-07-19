return function(opts)
  require'plugin-keymappings.easyalign'()
  require'plugin-keymappings.easymotion'(opts)
  require'plugin-keymappings.gundo'()
  require'plugin-keymappings.lsp.goto'()
  require'plugin-keymappings.slime'()
  require'plugin-keymappings.telescope'(opts)
end
