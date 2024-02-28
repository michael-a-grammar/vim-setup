local fn = vim.fn
local rtp = vim.opt.rtp

local lazy_install_path = fn.stdpath('data') .. '/lazy/lazy.nvim'

if fn.empty(fn.glob(lazy_install_path)) > 0 then
  local repo = 'https://github.com/folke/lazy.nvim.git'

  fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    repo,
    '--branch=stable',
    lazy_install_path,
  })
end

rtp:prepend(lazy_install_path)

require('lazy').setup('vamp.plugins')
