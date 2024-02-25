local fn    = vim.fn
local rtp   = vim.opt.rtp
local paths = require'elden.paths'
local lazy  = require'elden.opts'.lazy

local lazy_install_path

if lazy.is_install_path_relative then
  lazy_install_path = paths.data .. lazy.install_path
else
  lazy_install_path = lazy.install_path
end

require'elden.log'("Here", { path = lazy_install_path })

if fn.empty(fn.glob(lazy_install_path)) > 0 then
  local repo = lazy.repo

  fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    repo,
    '--branch=stable',
    lazy_install_path
  })
end

rtp:prepend(lazy_install_path)

require'lazy'.setup('elden.plugins')