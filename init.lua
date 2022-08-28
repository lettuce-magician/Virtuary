local embed = require("embed").zip
--local RequiredCheck, vitalityCheck = pcall(require, 'lib.checkvit')
--local ui = require("ui")
local win = require('lib.loadwin')

local icons = embed:extract('icons')

--[[local ignore = {
  ['.git'] = true,
  LICENSE = true,
  ['README.md'] = true,
  ['Build.bat'] = true,
  ['__mainLuaRTStartup__.lua'] = true,
  ['init.lua'] = true,
  ['CHANGELOG.md'] = true,
  ['build'] = true,
}

if RequiredCheck == false or vitalityCheck() == false then
  local response = ui.confirm("There are missing files/folders which are essential to Virtuary to work, restore them and start? (pressing no will start Virtuary without restoring.)", "Vitality Check Failed")
  
  if response == 'yes' then
    for entry in each(embed) do
      if ignore[entry] == nil then
        embed:extract(entry)
      end
    end
  elseif response == "cancel" then
    return
  end
end]]

win.load("main")
win.run('main')

icons:removeall()