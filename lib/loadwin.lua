local ui = require("ui")

local win = {}
local loaded = {}

function win.load(name)
  if loaded[name] == nil then
    local window = require("windows."..name)
    loaded[name] = window
    loaded[name].loaded = false
    return window
  else
    return loaded[name]
  end
end

function win.unload(name)
  if loaded[name] ~= nil and loaded[name].loaded == true then
    loaded[name]:hide()
    loaded[name].loaded = false
    if name == "main" then
      for w in each(loaded) do
        win.unload(w)
      end
    end
  end
end

function win.run(name)
  local window = loaded[name]
  if window ~= nil and window.loaded == false then
    window.loaded = true
    window:show()
    repeat
      ui.update()
    until window.visible == false
    win.unload(name)
  end
end

return win