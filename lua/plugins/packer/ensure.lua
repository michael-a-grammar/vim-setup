local fn = vim.fn

local ensure = function()
  local install_path =
    fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    local repo = 'https://github.com/wbthomason/packer.nvim'

    fn.system({ 'git', 'clone', '--depth', '1', repo, install_path })
  end
end

return ensure
