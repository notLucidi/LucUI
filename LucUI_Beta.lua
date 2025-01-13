library = {}

local Colors = {
    backgroundDarkSolid = {25, 25, 25, 255},
    backgroundLightSolid = {240, 240, 240, 255},
    textDarkSolid = {10, 10, 10, 255},
    textLightSolid = {255, 255, 255, 255},
    borderDarkSolid = {50, 50, 50, 255},
    borderLightSolid = {200, 200, 200, 255},
    primarySolid = {52, 152, 219, 255},
    primaryHoverSolid = {41, 128, 185, 255},
    accentSolid = {46, 204, 113, 255},
    dangerSolid = {231, 76, 60, 255},
    secondarySolid = {155, 89, 182, 255},
    warningSolid = {241, 196, 15, 255},
    infoSolid = {52, 73, 94, 255},
    successSolid = {39, 174, 96, 255},
    grayLightSolid = {220, 220, 220, 255},
    graySolid = {128, 128, 128, 255},
    grayDarkSolid = {64, 64, 64, 255},
    highlightSolid = {243, 156, 18, 255},
    selectionSolid = {142, 68, 173, 255},
    disabledSolid = {189, 195, 199, 255}
}

function library:addElement(element)
    table.insert(self.elements, element)
end

function getColor(colorName)
    if Colors[colorName] then
        return Colors[colorName]
    elseif colorName:match("^%d+,%d+,%d+,%d+$") then
        local rgba = {}
        for value in colorName:gmatch("%d+") do
            table.insert(rgba, tonumber(value))
        end
        return rgba
    else
        error("Please Input Correct Color!")
    end
end

function library:Window(str)
    local dialog = {
        elements = {},
        tabs = {},
        name = str.Name or "window",
        text = str.Text or "example",
        icon = str.Icon or 7188,
        exit = str.Exit or false,
        backgroundColor = str.BackgroundColor and getColor(str.BackgroundColor) or nil,
        borderColor = str.BorderColor and getColor(str.BorderColor) or nil
    }
    setmetatable(dialog, { __index = library })

    if dialog.exit then
        dialog:addElement("add_quick_exit|")
    end
    if dialog.backgroundColor then
        dialog:addElement("set_bg_color|".. table.concat(dialog.backgroundColor, ","))
    end
    if dialog.borderColor then
        dialog:addElement("set_border_color|".. table.concat(dialog.borderColor, ","))
    end
    if dialog.name then
        dialog:addElement("end_dialog|".. dialog.name .."|")
    end
    dialog:addElement("add_label_with_icon|big|" .. dialog.text .. "|left|" .. dialog.icon .. "|")
    
    function dialog:Tab(str)
        local tab = {
            elements = {},
            name = str.Name or "Name",
            image = str.Image or error("Please Input Path to RTTEX File!"),
            frame = str.Frame or "0,0",
            size = str.Size or "228,92",
            width = str.Width or 60,
            minWidth = str.MinWidth or 0.14 
        }
        setmetatable(tab, { __index = library })

        tab:addElement("add_custom_button|" .. tab.name .. "|image:" .. tab.image .. ";image_size:" .. tab.size .. ";frame:" .. tab.frame .. ";width:" .. tab.width .. ";min_width:" .. tab.minWidth .. "|")

        return tab
    end

    function dialog:addImage(str)
        local image = {
            elements = {},
            name = str.Name or "Image",
            image = str.Image or error("Please Input Path to RTTEX File!")
        }
        setmetatable(image, { __index = library })

        image:addElement("add_image_button|" .. image.name .. "|" .. image.image .. "|bannerlayout||NOFLAGS|0|1|")

        return image
    end
    
    function dialog:Button(str)
        local button = {
            elements = {},
            name = str.Name or "Button",
            text = str.Text or "Example",
            useIcon = str.UseIcon or false,
            frame = str.Frame or "",
            icon = str.Icon or "",
            amount = str.Amount or "",
            scaling = str.Scaling or "scalings",
            end_list = str.EndList or false
        }
        setmetatable(button, { __index = library })

        if str.UseIcon then
            local scalingExist = false
            for _, element in ipairs(dialog.elements) do
                if element:find("text_scaling_string|") then
                    scalingExist = true
                    break
                end
            end
            if not scalingExist then
                dialog:addElement("text_scaling_string|" .. button.scaling)
            end
            button:addElement("add_button_with_icon|".. str.name .."|".. str.text .."|".. str.frame .."|".. str.icon .."|".. str.amount .."|")
        else
            button:addElement("add_button|".. button.name .."|".. button.text .."|")
        end

        if str.EndList then
            dialog:addElement("add_button_with_icon||END_LIST||0||")
        end

        return button
    end

    function dialog:Text(str)
        local text = {
            elements = {},
            size = str.Size or "Small",
            text = str.Text
        }
        setmetatable(text, { __index = library })

        if str.Size == "Small" then
            text:addElement("add_smalltext|".. text.text .."|")
        else
            text:addElement("add_textbox|".. text.text .."|")
        end

        return text
    end

    function dialog:Spacer(str)
        local spacer = {
            elements = {},
            size = str.Size or "Small"
        }
        setmetatable(spacer, { __index = library })
        
        if str.Size then
            spacer:addElement("add_spacer|".. str.Size:lower() .."|")
        end

        return spacer
    end

    function dialog:Icon(str)
        local icon = {
            elements = {},
            text = str.Text or "Example",
            icon = str.Icon or 2
        }
        setmetatable(icon, { __index = library })

        icon:addElement("add_label_with_icon|small|".. icon.text .."|left|".. icon.icon .."|")

        return icon
    end

    function dialog:Build()
        local dialogs = ""

        dialogs = dialogs .. "start_custom_tabs|\n"

        if dialog.tabs then
            for _, tab in ipairs(dialog.tabs) do
                for _, element in ipairs(tab.elements) do
                    dialogs = dialogs .. element .."\n"
                end
            end
        end

        dialogs = dialogs .. "end_custom_tabs|\n"

        for _, element in ipairs(dialog.elements) do
            dialogs = dialogs .. element .. "\n"
        end

        return dialogs
    end

    return dialog
end

return library
