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
  if font and size and color then
    config.Window.Font = font
    config.Window.FontSize = size
    config.Window.FontColor = color
    ini.saveFile("./config.ini", config)
    Font.text = 'Font: '..config.Window.Font
    FontSize.text = 'Font Size: '..config.Window.FontSize
    FontColor.text = 'Font Color: '..config.Window.FontColor
    lwin.unload('font')
  end
end

return win