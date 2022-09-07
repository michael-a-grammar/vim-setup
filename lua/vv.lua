return function()
  if vim.g.vv then
    local vv = vim.fn.VVset

    vv('fullscreen=1')
    vv([[fontfamily=Hasklug\ Nerd\ Font\ Mono]])
    vv('fontsize=16')
  end
end
