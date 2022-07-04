local NineToFive = {}

local v    = vim
local exec = function(cmd)
  return vim.api.nvim_exec(cmd, true)
end

local NineToFive.get_all_wds = function()
  local tab_page = exec'tabpagenr'
  local win      = exec'winnr'
  local dirs     = {}

  local get_wds = function()
    local wd = v.split(exec'verbose pwd')
  end
end

return NineToFive
