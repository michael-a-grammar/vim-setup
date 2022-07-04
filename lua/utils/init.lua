local Utils = {}

Utils.t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return Utils
