P = function(v)
  print(vim.inspect(v))
  return v
end

-- Reloader

local require = require
local reloader = require

RELOAD = function(...)
    local status, plenary_reload = pcall(require, "plenary.reload")
    if status then
        reloader = plenary_reload.reload_module
    end

    return reloader(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end
