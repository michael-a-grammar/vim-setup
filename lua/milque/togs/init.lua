local api  = vim.api
local togs = {}

local function tg_opt(name)
  local val     = not vim.opt[name]:get()
  vim.opt[name] = val
  return val
end

local names = api.nvim_get_all_options_info()

for name in pairs(names) do
  local opt = api.nvim_get_option_info(name)
  if opt.type == 'boolean' then
    togs['tg_' .. name] = function ()
      tg_opt(name)
    end
  end
end

return togs
