# HighlightFocusedWindow Spoon

`HighlightFocusedWindow` is a Hammerspoon spoon that visually highlights the currently focused window by drawing a customizable border around it. The border updates automatically when the window focus changes, or when the window is moved, minimized, or destroyed.

## Features

- **Customizable Border**: Modify the color, width, and appearance of the focus border.
- **Auto-updating**: Automatically updates the border on window focus changes, movements, minimization, or destruction.
- **Lightweight**: Efficient and minimal, focusing only on the task of highlighting the active window.

## Requirements

- [Hammerspoon](https://www.hammerspoon.org) installed on macOS.

## Installation

1. **Download and Install Hammerspoon**: If you haven't already, download and install Hammerspoon from [hammerspoon.org](https://www.hammerspoon.org).

2. **Save the Spoon**:
   - Save the provided Lua script as `HighlightFocusedWindow.lua` in your `~/.hammerspoon/Spoons/` directory.

3. **Load the Spoon**:
   - In your Hammerspoon `init.lua`, load the spoon:

     ```lua
     hs.loadSpoon("HighlightFocusedWindow")
     ```

4. **Start Hammerspoon**:
   - Ensure that Hammerspoon is running, and the spoon will automatically draw a border around the currently focused window.

## Configuration

The border's appearance and update interval can be customized by modifying the following variables within the script:

- `borderColor`: Defines the color and opacity of the border. The default is red with 80% opacity.
- `borderWidth`: The width of the border in pixels. The default is 15 pixels.
- `updateInterval`: Sets the interval for updating the border. The default is 0.5 seconds.

Example of customizing these settings:

```lua
local borderColor = {red=0, green=1, blue=0, alpha=0.8}  -- Green border
local borderWidth = 10  -- 10 pixels wide
local updateInterval = 1  -- Update every 1 second
