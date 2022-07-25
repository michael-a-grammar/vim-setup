return function(within_fn)
  return function(fn, key)
    return function()
      local opts = {}

      if key == nil then
        key = 'cwd'
      end

      opts[key] = within_fn()

      fn(opts)
    end
  end
end
