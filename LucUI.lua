local Library = {}
Library.__index = Library

local Colors = {
    background = {25, 25, 25, 255},
    primary = {52, 152, 219, 255},
    danger = {231, 76, 60, 255},
    success = {39, 174, 96, 255}, 
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

function Library:New(config)
    local instance = setmetatable({}, Library)
    instance.elements = {}
    instance.tabs = {}
    instance.scalingAdded = false
    
    instance.name = config.Name or config.name or "ui_window"
    instance.title = config.Title or config.title or "Main Menu"
    instance.icon = config.Icon or config.icon or 7188
    
    local defaultColor = config.DefaultColor or config.defaultcolor
    if defaultColor then 
        instance:AddRaw("set_default_color|" .. defaultColor) 
    end

    local borderColor = config.BorderColor or config.bordercolor
    if borderColor then
        local bc = type(borderColor) == "table" and borderColor or Colors[borderColor]
        instance:AddRaw("set_border_color|" .. table.concat(bc or {50,50,50,255}, ","))
    end
    
    local bgConfig = config.BG or config.bg
    local bg = bgConfig and (type(bgConfig) == "table" and bgConfig or Colors[bgConfig]) or Colors.background
    instance:AddRaw("set_bg_color|" .. table.concat(bg, ","))
    
    if config.UseEleIcon or config.useeleicon then
        instance:LabelEle(instance.title, "big", instance.icon, config.EleID or config.eleid or 0)
    else
        instance:LabelIcon(instance.title, "big", instance.icon)
    end
    
    return instance
end

function Library:AddRaw(str)
    table.insert(self.elements, str)
    return self
end

function Library:LabelEle(text, size, icon, eleId)
    return self:AddRaw(string.format("add_label_with_ele_icon|%s|%s|left|%s|%s|", 
        size or "big", text, icon or 0, eleId or 0))
end

function Library:CustomText(text, size, color)
    local style = string.format("size:%s;color:%s;", size or "small", color or "255,255,255,255")
    return self:AddRaw(string.format("add_custom_textbox|%s|%s|", text, style))
end

function Library:Text(text, alignment)
    return self:AddRaw(string.format("add_textbox|%s|%s|", text, alignment or "left"))
end

function Library:SmallText(text)
    return self:AddRaw("add_smalltext|" .. text .. "|")
end

function Library:LabelIcon(text, size, icon)
    return self:AddRaw(string.format("add_label_with_icon|%s|%s|left|%s|", 
        size or "small", text, icon or 0))
end

function Library:Checkbox(id, text, state)
    return self:AddRaw(string.format("add_checkbox|%s|%s|%d|", id, text, state or 0))
end

function Library:Input(id, text, length, maxLength)
    return self:AddRaw(string.format("add_text_input|%s|%s|%s|%s|", id, text, length or 1, maxLength or 10))
end

function Library:Spacer(size)
    return self:AddRaw("add_spacer|" .. (size or "small"):lower() .. "|")
end

function Library:Tab(data)
    local name = data.Name or data.name or "Tab"
    local image = data.Image or data.image or ""
    local width = data.Width or data.width or 60
    
    local str = string.format("add_custom_button|%s|image:%s;width:%d;min_width:0.14|", 
        name, image, width)
    table.insert(self.tabs, str)
    return self
end

function Library:Button(data)
    local useIcon = data.UseIcon or data.useicon
    local scaling = data.Scaling or data.scaling
    local endList = data.EndList or data.endlist

    if useIcon then
        if scaling and not self.scalingAdded then
            self:AddRaw("text_scaling_string|" .. scaling .. "|")
            self.scalingAdded = true
        end
        
        local name = data.Name or data.name or "btn"
        local text = data.Text or data.text or ""
        local frame = data.Frame or data.frame or ""
        local icon = data.Icon or data.icon or ""
        local amount = data.Amount or data.amount or ""
        self:AddRaw(string.format("add_button_with_icon|%s|%s|%s|%s|%s|", name, text, frame, icon, amount))
    else
        local name = data.Name or data.name or "btn"
        local text = data.Text or data.text or "Button"
        self:AddRaw(string.format("add_button|%s|%s|", name, text))
    end

    if endList then
        self:AddRaw("add_button_with_icon||END_LIST||0||")
    end

    return self
end

function Library:Build(cancelText, confirmText, quickExit)
    local finalStr = ""
    if #self.tabs > 0 then
        finalStr = "start_custom_tabs|\n" .. table.concat(self.tabs, "\n") .. "\nend_custom_tabs|\n"
    end
    
    finalStr = finalStr .. table.concat(self.elements, "\n") .. "\n"
    finalStr = finalStr .. string.format("end_dialog|%s|%s|%s|", 
        self.name, cancelText or "", confirmText or "") 
    
    if quickExit then 
        finalStr = finalStr .. "\nadd_quick_exit|" 
    end

    return sendVariant({ v1 = "OnDialogRequest", v2 = finalStr }) -- Diperbaiki jadi sendVariant
end

return Library
