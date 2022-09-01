return function(opts)
  require'milque.purp.elixir-lsp'(opts)
  require'milque.purp.elixir-nvim'(opts)
  require'milque.purp.keymappings'(opts)
  require'milque.purp.telescope-keymappings'()
end
