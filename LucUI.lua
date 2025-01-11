local libary = {}

--// Colors //--
local Colors = {
    backgroundDark = {25, 0, 25, 25},
    backgroundLight = {240, 0, 240, 240},
    textDark = {10, 0, 10, 10},
    textLight = {255, 0, 255, 255},
    borderDark = {50, 0, 50, 50},
    borderLight = {200, 0, 200, 200},
    primary = {52, 0, 152, 219},
    primaryHover = {41, 0, 128, 185},
    accent = {46, 0, 204, 113},
    danger = {231, 0, 76, 60},
    secondary = {155, 0, 89, 182},
    warning = {241, 0, 196, 15},
    info = {52, 0, 73, 94},
    success = {39, 0, 174, 96},
    grayLight = {220, 0, 220, 220},
    gray = {128, 0, 128, 128},
    grayDark = {64, 0, 64, 64},
    highlight = {243, 0, 156, 18},
    selection = {142, 0, 68, 173},
    disabled = {189, 0, 195, 199},
}

function color(color_name)
    local color = Colors[color_name]
    if color then
        local useColor = table.concat(color, ",")
        return useColor
    else
        return error("Colors ".. color_name .." Not Found")
    end
end

-- Constructor untuk membuat dialog baru
function libary:Window(properties)
    local dialog = {}
    dialog.elements = {} -- Menyimpan elemen dialog
    setmetatable(dialog, { __index = libary })

    -- Properti default
    dialog.label = properties.Label or "Default Label"
    dialog.backgroundColor = properties.BackgroundColor and color(properties.BackgroundColor) or nil
    dialog.borderColor = properties.BorderColor and color(properties.BorderColor) or nil
    dialog.icon = properties.Icon or 7188
    dialog.exitButton = properties.ExitButton or false

    -- Tambahkan elemen dasar dialog
    if dialog.exitButton then
        dialog:addElement("add_quick_exit|")
    end
    if dialog.backgroundColor then
        dialog:addElement("set_bg_color|" .. dialog.backgroundColor)
    end
    if dialog.borderColor then
        dialog:addElement("set_border_color|" .. dialog.borderColor)
    end
    dialog:addElement("add_label_with_Icon|big|" .. dialog.label .. "|left|" .. dialog.icon .. "|")
    dialog:addElement("add_spacer|small|")

    return dialog
end

-- Menambahkan elemen dialog
function libary:addElement(element)
    table.insert(self.elements, element)
end

-- Menambahkan textbox
function libary:addTextbox(text)
    self:addElement("add_textbox|" .. text .. "|")
end

-- Menambahkan tombol
function libary:addButton(name, buttonText)
    self:addElement("add_button|" .. name .. "|" .. buttonText .. "|")
end

-- Menambahkan baris akhir dialog
function libary:endDialog(dialogName, button1, button2)
    self:addElement("end_dialog|" .. dialogName .. "|" .. button1 .. "|" .. button2 .. "|")
end

-- Membuat string dialog akhir
function libary:build()
    return table.concat(self.elements, "\n")
end

return libary
