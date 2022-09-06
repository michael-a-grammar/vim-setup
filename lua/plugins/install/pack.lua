local pack = function()
  require'milque.neon'.cmd('packadd cfilter')
end

return function()
  pack()
end
