return function()
  local M = {}

  local logs = {}

  local log_level = {
    info  = 'INFO',
    warn  = 'WARN',
    error = 'ERROR'
  }

  local format_log = function(message, level, data)
    return {
      message   = message,
      log_level = level,
      time      = os.date('%H:%M:%S'),
      data      = data
    }
  end

  local add_log = function(message, data, level)
    local formatted_log = format_log(message, data, level)

    table.insert(logs, formatted_log)

    return M
  end

  M.info = function(message, data)
    return add_log(message, data, log_level.info)
  end

  M.echo = function()
    local writable_logs =  {}

    for _, log in ipairs(logs) do
      local writable_log = vim.json.encode(log)

      if writable_log then
        table.insert(writable_logs, { writable_log })
      end
    end

    vim.api.nvim_echo(writable_logs, true, {})
  end

  M.flush = function()
    M.echo()

    logs = {}
  end

  local metatable = {
    __call = function(_, message, data, level)
      level = level or log_level.info

      return add_log(message, data, level)
    end
  }

  setmetatable(M, metatable)

  return M
end
