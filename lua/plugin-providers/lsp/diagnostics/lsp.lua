local diagnostic = vim.diagnostic

return {
  info       = diagnostic.open_float,
  next       = diagnostic.goto_next,
  next_error = diagnostic.goto_next,
  prev       = diagnostic.goto_prev,
  prev_error = diagnostic.goto_prev,
  setloclist = diagnostic.setloclist
}
