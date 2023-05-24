return function()
  local M = {}

  local logs = {}

  local log_levels = {
    info  = 'INFO',
    warn  = 'WARN',
    error = 'ERROR',
  }

  local format_log = function(message, data, level)
    return {
      message = message,
      level   = level,
      time    = os.date('%H:%M:%S'),
      data    = data,
    }
  end

  local add_log = function(message, data, level)
    local formatted_log = format_log(message, data, level)

    table.insert(logs, formatted_log)

    return M
  end

  M.level = log_levels

  M.filter_logs = function(filter)
    if not filter then
      filter = function()
        return true
      end
    end

    return vim.tbl_filter(filter, logs)
  end

  M.filter_logs_by_level = function(level)
    if not level then
      level = log_levels.info
    end

    return M.filter_logs(function(log)
      return log.level == level
    end)
  end

  M.echo = function(filter)
    local writable_logs = vim.tbl_map(function(log)
      return {
        vim.json.encode(log)
      }
    end, M.filter_logs(filter))

    vim.api.nvim_echo(writable_logs, true, {})
  end

  M.flush = function()
    M.echo()

    logs = {}
  end

  for log_level, log_level_value in pairs(log_levels) do
    M[log_level] = function(message, data)
      return add_log(message, data, log_level_value)
    end

    M[log_level .. 's' ] = function()
      return M.filter_logs_by_level(log_level_value)
    end
  end

  local metatable = {
    __call = function(_, message, data, level)
      if not level then
        if data.success ~= nil then
          if data.success then
            level = log_levels.info
          else
            level = log_levels.error
          end
        else
          level = log_levels.info
        end
      end

      return add_log(message, data, level)
    end
  }

  setmetatable(M, metatable)

  return M
end
