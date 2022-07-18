return function()
  local api            = vim.api
  local events_augroup = api.nvim_create_augroup('events', {})

  api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank()
    end,
    group    = events_augroup,
    pattern  = '*'
  })
end
