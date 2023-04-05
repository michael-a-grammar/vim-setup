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

    table.insert(logs, { formatted_log })

    return M
  end

  M.info = function(message, data)
    return add_log(message, data, log_level.info)
  end

  M.write_to_messages = function()
    vim.api.nvim_echo(logs, true, {})
  end

  local metatable = {
    __call = function(self, message, data)
      self.info(message, data)
    end
  }

  setmetatable(M, metatable)

  return M
end
