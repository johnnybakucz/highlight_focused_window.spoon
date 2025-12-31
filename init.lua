local obj = {}

-- Metadata
obj.name = "HighlightFocusedWindow"
obj.version = "1.0"
obj.author = "Jonatan Bakucz"
obj.homepage = "https://github.com/johnnybakucz/highlight_focused_window.spoon"

-- Configuration
local borderColor = { red = 1, green = 0, blue = 0, alpha = 0.8 }
local borderWidth = 10
local borderPadding = 0
local borderRadius = 8

-- Global variable to store the border
local focusBorder = nil

-- Function to delete the border
local function deleteBorder()
    if focusBorder then
        focusBorder:hide()
        focusBorder = nil
    end
end

-- Function to draw the border
local function drawBorder()
    local win = hs.window.focusedWindow()

    deleteBorder()

    if not win then
        return
    end

    local frame = win:frame()

    -- Adjust frame for border width and padding
    local adjustedFrame = {
        x = frame.x,
        y = frame.y - borderPadding,
        w = frame.w,
        h = frame.h + borderPadding
    }

    if focusBorder then
        focusBorder:setFrame(adjustedFrame)
    else
        focusBorder = hs.drawing.rectangle(adjustedFrame)
        focusBorder:setStrokeColor(borderColor)
        focusBorder:setRoundedRectRadii(borderRadius, borderRadius)
        focusBorder:setFill(false)
        focusBorder:setStrokeWidth(borderWidth)
        focusBorder:show()
    end
end

-- Event listener for window focus changes
local windowFilter = hs.window.filter.new()

function obj:enable()
    local borderEvents = {
        {event = hs.window.filter.windowAllowed,        handler = deleteBorder},
        {event = hs.window.filter.windowCreated,        handler = deleteBorder},
        {event = hs.window.filter.windowDestroyed,      handler = deleteBorder},
        {event = hs.window.filter.windowFocused,        handler = drawBorder},
        {event = hs.window.filter.windowFullscreened,   handler = drawBorder},
        {event = hs.window.filter.windowHidden,         handler = deleteBorder},
        {event = hs.window.filter.windowMinimized,      handler = deleteBorder},
        {event = hs.window.filter.windowMoved,          handler = drawBorder},
        {event = hs.window.filter.windowOnScreen,       handler = drawBorder},
        {event = hs.window.filter.windowTitleChanged,   handler = drawBorder},
        {event = hs.window.filter.windowUnfocused,      handler = deleteBorder},
        {event = hs.window.filter.windowUnhidden,       handler = drawBorder},
        {event = hs.window.filter.windowUnminimized,    handler = drawBorder},
        {event = hs.window.filter.windowUnfullscreened, handler = drawBorder},
        {event = hs.window.filter.windowsChanged,       handler = drawBorder},
    }

    for _, v in ipairs(borderEvents) do
        windowFilter:subscribe(v.event, v.handler)
    end
    hs.alert("Border Highlight Enabled")
end

function obj:disable()
    windowFilter:unsubscribeAll()
    deleteBorder()
    hs.alert("Border Highlight Disabled")
end

obj:enable()

return obj
