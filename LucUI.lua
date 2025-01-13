libary = {}

function libary:addElement(element)
    table.insert(self.elements, element)
end

function Color(Colors)
    if Colors[Colors] then
        return Colors[Colors]
    elseif Colors:match("^%d+,%d+,%d+,%d+$") then
        return Colors
    else
        error("Please Input Correct Color!")
    end
end

function libary:Window(str)
    local dialog = {
        elements = {},
        tabs = {},
        name = str.Name or "window",
        text = str.Text or "example",
        icon = str.Icon or 7188,
        exit = str.Exit or false,
        backgroundColor = str.BackgroundColor and Color(str.backgroundColor) or nil,
        borderColor = str.BorderColor and Color(str.borderColor) or nil
    }
    setmetatable(dialog, { __index = libary })

    if dialog.exit then
        dialog:addElement("add_quick_exit|")
    end
    if dialog.backgroundColor then
        dialog:addElement("set_bg_color|".. str.backgroundColor)
    end
    if dialog.borderColor then
        dialog:addElement("set_border_color|".. str.borderColor)
    end
    if dialog.name then
        dialog:addElement("end_dialog|".. dialog.name .."|")
    end
    dialog:addElement("add_label_with_icon|big|" .. dialog.text .. "|left|" .. dialog.icon .. "|")
    
    function dialog:Tab(str)
        local tab = {
            elements = {},
            name = tab.Name or "Name",
            image = tab.Image or error("Please Input Path to RTTEX File!"),
            frame = tab.Frame or "0,0",
            size = tab.Size or "228,92",
            width = tab.width or 60,
            minWidth = tab.MinWidth or 0.14 
        }
        setmetatable(tab, { __index = libary })

        tab:addElement("add_custom_button|" .. tab.name .. "|image:" .. tab.image .. ";image_size:" .. tab.size .. ";frame:" .. tab.frame .. ";width:" .. tab.width .. ";min_width:" .. tab.minWidth .. "|")

        return tab
    end

    function dialog:addImage(str)
        local image = {
            elements = {},
            name = str.Name or "Image",
            image = str.Image or error("Please Input Path to RTTEX File!")
        }
        setmetatable(image, { __index = libary })

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
        setmetatable(button, { __index = libary })

        if str.useIcon then
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
            button:addElement("add_button|".. name .."|".. text .."|")
        end

        if str.end_list then
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
        setmetatable(text, { __index = libary })

        if str.size == "Small" then
            text:addElement("add_smalltext|".. text .."|")
        else
            text:addElement("add_textbox|".. text .."|")
        end

        return text
    end

    function dialog:Spacer(str)
        local spacer = {
            elements = {},
            size = str.Size or "Small"
        }
        setmetatable(spacer, { __index = libary })
        
        if str.size then
            spacer:addElement("add_spacer|".. str.size:lower() .."|")
        end

        return spacer
    end

    function dialog:Icon(str)
        local icon = {
            elements = {},
            text = str.Text or "Example",
            icon = str.Icon or 2
        }
        setmetatable(icon, { __index = libary })

        icon:addElement("add_label_with_icon|small|".. str.text .."|left|".. str.icon .."|")

        return icon
    end


    function dialog:Build()
        local dialogs = ""

        dialogs = dialogs .. "start_custom_tabs|\n"

        if dialog.tabs then
            for _, tab in ipairs(dialog.tabs) do
                for _, element in ipairs(tab.element) do
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

return libary
