local obj = {}

-- Metadata
obj.name = "HighlightFocusedWindow"
obj.version = "1.0"
obj.author = "Jonatan Bakucz"
obj.homepage = "https://github.com/johnnybakucz/highlight_focused_window.spoon"

-- Configuration
local borderColor = {red=1, green=0, blue=0, alpha=0.8}
local borderWidth = 10

-- Global variable to store the border
local focusBorder = nil

-- Function to delete the border
local function deleteBorder()
    if focusBorder then
        focusBorder:delete()
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
        y = frame.y,
        w = frame.w,
        h = frame.h
    }

    if focusBorder then
        focusBorder:setFrame(adjustedFrame)
    else
        focusBorder = hs.drawing.rectangle(adjustedFrame)
        focusBorder:setStrokeColor(borderColor)
        focusBorder:setFill(false)
        focusBorder:setStrokeWidth(borderWidth)
        focusBorder:show()
    end
end

-- Event listener for window focus changes
local windowFilter = hs.window.filter.new()
windowFilter:subscribe(hs.window.filter.windowFocused, drawBorder)
windowFilter:subscribe(hs.window.filter.windowUnfocused, deleteBorder)
windowFilter:subscribe(hs.window.filter.windowDestroyed, deleteBorder)
windowFilter:subscribe(hs.window.filter.windowMoved, drawBorder)
windowFilter:subscribe(hs.window.filter.windowMinimized, deleteBorder)
windowFilter:subscribe(hs.window.filter.windowHidden, deleteBorder)
windowFilter:subscribe(hs.window.filter.windowUnminimized, drawBorder)
windowFilter:subscribe(hs.window.filter.windowUnhidden, drawBorder)

return obj
