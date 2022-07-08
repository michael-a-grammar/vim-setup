local env   = vim.env
local g     = vim.g
local split = vim.split
local map   = require'milque.cartographer'.nx_leader

return function(opts)
  if opts.use.coc then
    g.coc_global_extensions = {
      'coc-elixir',
      'coc-html',
      'coc-json',
      'coc-markdown-preview-enhanced',
      'coc-markdownlint',
      'coc-prettier',
      'coc-snippets',
      'coc-solargraph',
      'coc-spell-checker',
      'coc-sumneko-lua',
      'coc-vimlsp',
      'coc-webview',
      'coc-yank'
    }
  end
end
