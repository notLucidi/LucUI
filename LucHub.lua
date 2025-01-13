-- Load the library
local LucUI = dofile("storage/emulated/0/Android/data/laancher.powerkuy.growlauncher/ScriptLua/LucUIP.lua")

-- Create a new window
local TestUI = LucUI:Window({
    Name = "TestWindow",
    Text = "Test Window",
    Icon = 7188,
    Exit = true,
    BackgroundColor = "backgroundDarkSolid",
    BorderColor = "borderDarkSolid"
})

-- Add a text element
local text1 = TestUI:Text({
    Size = "Small",
    Text = "`9LucUI"
})

-- Add a button element
local button1 = TestUI:Button({
    Name = "MyButton",
    Text = "Click Me",
    UseIcon = true,
    Frame = "0,0",
    Icon = 7188,
    Amount = 10,
    Scaling = "scale",
    EndList = false
})

-- Build and print the UI
local ui = TestUI:Build()
print(ui)
