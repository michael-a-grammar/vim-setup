local classy    = {}
classy.field_fn = {}

function classy.field_fn.tg_field_value(_, _, _, val)
  return curr_val
end

function classy.field_fn.set_field_to_value(_, _, _, val)
  return val
end

function classy.field_fn.set_field_to_key(_, key, _, _)
  return key
end

function classy.merge(tbls)
  for key1, tbl1 in pairs(tbls) do
    if type(tbl1) == 'table' then
      for key2, tbl2 in pairs(tbls) do
        rawset(tbl1, key2, tbl2)
      end
    end
  end

  return tbls
end

function classy:create_field(tbl, field, opts)
  local opts                 = opts or {}
  local get_field_key_prefix = opts.get_field_key_prefix or nil
  local set_field_key_prefix = opts.set_field_key_prefix or 'set'

  local set_field_fn =
    opts.set_field_fn or self.field_fn.set_field_to_value

  local get_field_key =
    (get_field_key_prefix
      and get_field_key_prefix  .. '_' .. field)
    or field

  local set_field_key = set_field_key_prefix .. '_' .. field

  rawset(tbl, get_field_key, false)

  rawset(tbl, set_field_key, function(val)
    local curr_val = rawget(tbl, get_field_key)
    local new_val  = set_field_fn(tbl, field, curr_val, val)
    table.insert(rawget(tbl, '__values'), new_val)
    rawset(tbl, get_field_key, new_val)
    return tbl
  end)

  return get_field_key, set_field_key
end

function classy:create_fields(tbl, fields, opts)
  if rawget(tbl, '__values') == nil then
    rawset(tbl, '__values', {})
  end

  for _, field in pairs(fields) do
    self:create_field(tbl, field, opts)
  end
  return tbl
end

function classy:create(fields, opts)
  return self:create_fields({}, fields, opts)
end

return classy
