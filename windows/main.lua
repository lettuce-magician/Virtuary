local ui = require "ui"
local ini = require "lib.ini"
local lwin = require "lib.loadwin"

local currentfile = {
    name = "newfile",
    notAnActualFile = true
}

local config = ini.parseFile("./config.ini")

local last_text = ""
local was_edited = false

-- Load
local win = ui.Window('Virtuary', "dialog", 1280, 720)
win:loadicon("icons\\main.ico")
win.menu = ui.Menu()
win.title = "Virtuary - newfile"

-- Objects
local Edit = ui.Edit(win, "", 0, 0, 1280, 720)
Edit.font = config.Window.Font
Edit.fontsize = config.Window.FontSize
Edit.wordwrap = true

function Edit:onChange()
  if last_text ~= Edit.text and was_edited == false then
    win.title = win.title.."(*)"
    was_edited = true
  elseif last_text == Edit.text then
    win.title = "Virtuary - "..currentfile.name
    was_edited = false
  end
end

local function ChangeTheme()
  Edit.bgcolor = (config.Window.Theme == "White" and 0xFFFFFF) or 0x000000
end

ChangeTheme()

-- Menu
local File = win.menu:insert(1, "File", ui.Menu("New", "Save", "Open", "Quit"))
local Config = win.menu:insert(2, "Settings", ui.Menu("Theme", "Font", "RichText"))
local About = win.menu:insert(3, "About")

Config.submenu.items[3].checked = config.Window.RichText==1

function File.submenu:onClick(item)
  if item.text == "Quit" then
    win:hide()
  elseif item.text == "Open" then
    local file = ui.opendialog("Open a file to edit", false, "Any file (*.*)|*.*|Text file (*.txt)|*.txt")
    if file ~= nil then
      currentfile = file
      Edit.text = file:open("read", "utf8"):read()
      win.title = "Virtuary - "..file.name
      was_edited = false
      last_text = Edit.text
      file:close()
    end
  elseif item.text == "Save" then
    if currentfile.notAnActualFile then
      local file = ui.savedialog("Save to file", false, "Any file (*.*)|*.*|Text file (*.txt)|*.txt")
      if file ~= nil then
        currentfile = file
        win.title = "Virtuary - "..file.name
        last_text = Edit.text
        was_edited = false
        file:open("write"):write(Edit.text, "utf8")
        file:close()
      end
    else
      currentfile:open("write"):write(Edit.text, "utf8")
      win.title = "Virtuary - "..currentfile.name
      last_text = Edit.text
      was_edited = false
      currentfile:close()
    end
  elseif item.text == "New" then
    if (was_edited == false)
      or ui.confirm("Do you want to discard the current file changes?", "Discard file changes")=="yes"
    then
      sys.beep()
      currentfile = {
        name = "newfile",
        notAnActualFile = true
      }
      win.title = "Virtuary - newfile"
      Edit.text = ""
      last_text = Edit.text
      was_edited = false
    end
  end
end

function Config.submenu:onClick(item)
  if item.index == 1 then
    config.Window.Theme = (config.Window.Theme=="White"and "Black") or "White"
    ini.saveFile('./config.ini', config)
    ChangeTheme()
  elseif item.index == 2 then
    local fontw = lwin.load("font")
    lwin.run("font")
    repeat ui.update() until fontw.visible == false
    config = ini.parseFile('./config.ini')
    Edit.font = config.Window.Font
    Edit.fontsize = config.Window.FontSize
    Edit.color = config.Window.FontColor
  elseif item.index == 3 then
    config.Window.RichText = (config.Window.RichText==1 and 0) or 1
    ini.saveFile('./config.ini', config)
    Config.submenu.items[3].checked = not Config.submenu.items[3].checked
    Edit.richtext = not Edit.richtext
  end
end

function About:onClick()
  lwin.load('about')
  lwin.run('about')
end

return win