local LucUI = load(makeRequest("https://raw.githubusercontent.com/notLucidi/LucUI/refs/heads/main/LucUI.lua", "GET", "").content)()

-- Create a window
local Window = LucUI:Window({
    Label = "Example Window",
    BackgroundColor = "backgroundDarkSolid",
	BorderColor = "dangerSolid",
    Icon = 7188,
    ExitButton = false
})

-- Add a tab to the window
local Tab = Window:MakeTab({
    Id = "example_tab",
    Icon = "interface/large/gacha_banner.rttex",
    Size = "228,92",
    Frame = "0,0",
    Width = 0.14,
    MinWidth = 60,
    Callback  = function()
		logToConsole("Callback Called!")
	end
})

local Tab2 = Window:MakeTab({
    Id = "example_tab1",
    Icon = "interface/large/gacha_banner.rttex",
    Size = "228,92",
    Frame = "0,1",
    Width = 0.14,
    MinWidth = 60
})

local image = Window:addImage({
	Id = "example_image",
    Image = "interface/large/galaxy_banner.rttex"
})

local dialogString = Window:build()

sendVariant({[0] = "OnDialogRequest", [1] = dialogString})
