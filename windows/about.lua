local ui = require "ui"
local crypto = require "crypto"
local ini = require "lib.ini"

local config = ini.parseFile('./config.ini')
local version = 'Virtuary v'..config.Metadata.Version..' | Codename '..config.Metadata.Codename

local win = ui.Window('About', "fixed", 450, 100)
win:loadicon('icons\\about.ico')

ui.Label(win, version, 25, 25)
ui.Label(win, "Any bugs or suggestions DM me: Vegetable#3256", 25, 45)

return win