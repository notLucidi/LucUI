libary = {}

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
        local useColor = table.concat(color, ", ")
        return useColor
    else
        return error("Colors ".. color_name .." Not Found")
    end
end

function libary:Window(properties)
    -- Properti default
    local label = properties.Label or "Default Label"
    local backgroundColor = properties.BackgroundColor or nil
    local borderColor = properties.BorderColor or nil
    local icon = properties.Icon or 7188
    local exitButton = properties.ExitButton or false

    -- Template dialog
    local dialog = ""

    if exitButton then
        dialog = dialog .. "add_quick_exit|\n"
    end

    if backgroundColor then
        dialog = dialog .. "set_bg_color|" .. backgroundColor .. "\n"
    end

    if borderColor then
        dialog = dialog .. "set_border_color|" .. borderColor .. "\n"
    end

    dialog = dialog .. "add_label_with_Icon|Big|" .. label .. "|left|" .. icon .. "|\n"

    return dialog
end

return libary
