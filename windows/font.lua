local ui = require "ui"
local ini = require "lib.ini"
local lwin = require "lib.loadwin"

local config = ini.parseFile('./config.ini')

local win = ui.Window('Font Configuration', "fixed", 250, 95)
win:loadicon("icons\\font.ico")

local Font = ui.Label(win, 'Font', 25, 25)
Font.text = 'Font: '..config.Window.Font

local FontSize = ui.Label(win, 'FontSize', 25, 45)
FontSize.text = 'Font Size: '..config.Window.FontSize

local FontColor = ui.Label(win, 'FontColor', 25, 65)
FontColor.text = 'Font Color: '..config.Window.FontColor

ui.Button(win, "Edit Font", 150, 25).onClick = function(self)
  local font, size, style, color = ui.fontdialog()
  font = (font~='' and font~=nil and font) or nil
  config.Window.Font = font or config.Window.Font
  config.Window.FontSize = size or config.Window.FontSize
  config.Window.FontColor = color or config.Window.FontColor
  ini.saveFile("./config.ini", config)
  Font.text = 'Font: '..config.Window.Font
  FontSize.text = 'Font Size: '..config.Window.FontSize
  FontColor.text = 'Font Color: '..config.Window.FontColor
  lwin.unload('font')
end

return win