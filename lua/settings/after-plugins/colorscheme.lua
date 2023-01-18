return function(globals)
  vim.api.nvim_exec('colorscheme ' .. globals.colorscheme, false)
end
