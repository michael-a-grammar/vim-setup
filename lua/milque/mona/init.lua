return function(opts)
  require'milque.mona.elixir-lsp'(opts)
  require'milque.mona.elixir-nvim'(opts)
  require'milque.mona.keymappings'(opts)
  require'milque.mona.telescope-keymappings'()
end
