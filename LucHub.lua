local lucUI = load(makeRequest("https://raw.githubusercontent.com/notLucidi/LucUI/refs/heads/main/LucUI.lua", "GET", "").content)()

local Window = lucUI:Window({
    Label = "Label Example",
    BackgroundColor = color("backgroundDark"),
    BorderColor = color("grayDark"),
    Icon = 1234,
    ExitButton = true
})
logToConsole(Window)
sendVariant({[0] = "OnDialogRequest", [1] = Window})
