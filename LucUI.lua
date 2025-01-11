local libary = {}

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
