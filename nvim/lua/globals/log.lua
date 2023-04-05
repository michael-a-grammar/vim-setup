return function(config)
  local M = {}

  local logs = {}

  local log_level = {
    info  = "INFO",
    warn  = "WARN",
    error = "ERROR"
  }

  local format_log = function(log, log_level, ...)
    local formatted_log = string.format(log, ...)
    local time          = os.date('%H:%M:%S')

    return
      string.format('%s - [%s] %s\n', time, log_level, formatted_log)
  end

  local add_log = function(log, log_level, ...)
    local formatted_log = format_log(log, log_level, ...)

    table.insert(logs, { formatted_log })

    return M
  end

  M.info = function(log, ...)
    return add_log(log, log_level.info, ...)
  end

  M.write_to_messages = function()
    vim.api.nvim_echo(logs, true, {})
  end

  return M
end
