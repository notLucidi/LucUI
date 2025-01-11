local lucUI = load(makeRequest("https://raw.githubusercontent.com/notLucidi/LucUI/refs/heads/main/LucUI.lua", "GET", "").content)()

local dialog1 = libary:Window({
    Label = "Formulir Pengguna",
    BackgroundColor = "backgroundDark",
    BorderColor = "grayDark",
    Icon = 7188,
    ExitButton = true
})

dialog1:addTextBox("LucUI")

local dialogString1 = dialog1:build()
sendVariant({[0] = "OnDialogRequest", [1] = dialogString1})

