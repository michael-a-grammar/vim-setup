return function(opts)
  if opts.use.coc then
    vim.g.coc_global_extensions = {
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
