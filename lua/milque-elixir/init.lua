return function(opts)
  require'milque-elixir.elixir-lsp'(opts)
  require'milque-elixir.elixir-nvim'(opts)
  require'milque-elixir.keymappings'(opts)
  require'milque-elixir.telescope-keymappings'()
end
