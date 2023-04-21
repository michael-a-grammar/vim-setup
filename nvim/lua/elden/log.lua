return function()
  local M = {}

  local logs = {}

  local log_level = {
    info  = 'INFO',
    warn  = 'WARN',
    error = 'ERROR'
  }

  local format_log = function(message, data, level)
    return {
      message = message,
      level   = level,
      time    = os.date('%H:%M:%S'),
      data    = data
    }
  end

  M.levels = log_level

  local add_log = function(message, data, level)
    local formatted_log = format_log(message, data, level)

    table.insert(logs, formatted_log)

    return M
  end

  M.info = function(message, data)
    return add_log(message, data, log_level.info)
  end

  M.echo = function(level)
    local writable_logs =  {}

    for _, log in ipairs(logs) do
      if not level or log.level == level then
        local writable_log = vim.json.encode(log)

        if writable_log then
          table.insert(writable_logs, { writable_log })
        end
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
      if not level then
        if data.success ~= nil then
          if data.success then
            level = log_level.info
          else
            level = log_level.error
          end
        else
          level = log_level.info
        end
      end

      return add_log(message, data, level)
    end
  }

  setmetatable(M, metatable)

  return M
end
