return function(globals)
  local fn     = vim.fn
  local packer = globals.packer

  local M = function()
    local packer_install_path

    if packer.install_path_relative then
      packer_install_path = globals.paths.data_path .. packer.install_path
    else
      packer_install_path = packer.install_path
    end

    if fn.empty(fn.glob(packer_install_path)) > 0 then
      local repo = packer.repo

      fn.system({ 'git', 'clone', '--depth', '1', repo, packer_install_path })
    end
  end

  return M
end
