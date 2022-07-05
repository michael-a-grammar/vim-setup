local api  = vim.api
local opt  = vim.opt
local togs = {}

local function tg_opt(opt_name)
  local opt_val = not opt[opt_name]:get()
  opt[opt_name] = opt_val
  return opt_val
end

local opt_names = api.nvim_get_all_options_info()

for opt_name in pairs(opt_names) do
  local opt_info = api.nvim_get_option_info(opt_name)
  if opt_info.type == 'boolean' then
    togs['tg_' .. opt_name] = function ()
      tg_opt(opt_name)
    end
  end
end

return togs
