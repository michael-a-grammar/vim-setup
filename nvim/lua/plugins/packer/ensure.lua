return function(globals)
  local fn     = vim.fn
  local packer = globals.packer

  local M = function()
    local install_path = ''

    if packer.install_path_relative then
      install_path = globals.paths.data_path .. packer.install_path
    else
      install_path = packer.install_path
    end

    if fn.empty(fn.glob(install_path)) > 0 then
      local repo = packer.repo

      fn.system({ 'git', 'clone', '--depth', '1', repo, install_path })
    end
  end

  return M
end
