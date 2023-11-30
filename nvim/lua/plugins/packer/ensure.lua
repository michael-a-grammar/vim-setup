return function()
  local fn     = vim.fn
  local paths  = require'api.paths'
  local packer = require'api.opts'.packer

  local packer_install_path

  if packer.is_install_path_relative then
    packer_install_path = paths.data .. packer.install_path
  else
    packer_install_path = packer.install_path
  end

  if fn.empty(fn.glob(packer_install_path)) > 0 then
    local repo = packer.repo

    fn.system({ 'git', 'clone', '--depth', '1', repo, packer_install_path })
  end
end
