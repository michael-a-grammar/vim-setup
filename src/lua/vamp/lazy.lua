local lazy_install_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazy_install_path) then
  local repo = 'https://github.com/folke/lazy.nvim.git'

  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    repo,
    '--branch=stable',
    lazy_install_path,
  })
end

vim.opt.rtp:prepend(lazy_install_path)

require('lazy').setup('vamp.plugins')
