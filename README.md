# Roblox GUI (Bulb API)

A universal, modular Roblox GUI library built on the **Bulb API**. Every skin or theme (BulbGui, LuaCxre, JHGui, or your own) shares the same function names, so you can swap the visual style by changing only the loader URL, with no script changes.

## Features

- **One API, any skin**: the same code works across all compatible themes.
- **Responsive**: adapts to desktop and mobile screens.
- **Config saving**: components with a `Flag` are saved and restored automatically.
- **Window controls**: drag, resize, hide, and restore, plus a draggable toggle button.
- **Notifications & confirmation dialogs** built in.
- **Settings tab** with support for custom components.
- **Mobile-friendly**: touch input and hold-to-delete tabs.

## Installation

```lua
local Gui = loadstring(game:HttpGet("YOUR_RAW_URL"))()
```

Replace `YOUR_RAW_URL` with the raw link of any Bulb API compatible library. Switching skins only requires changing this URL.

## Initialization

```lua
local Window = Gui:Init({
    Name = "My Project",
    Subtitle = "Main Interface",
    FolderName = "MyConfigs",
    FileName = "settings.json",
    LoadedNotification = true,
    NotifyTitle = "Loaded",
    NotifyContent = "Interface ready!",
    NotifyDuration = 3
})
```

| Parameter | Type | Default | Description |
|---|---|---|---|
| Name | string | Library name | Window title |
| Subtitle | string | Automatic | Window subtitle |
| FolderName | string | Automatic | Config folder |
| FileName | string | default.json | Config file |
| Size | UDim2 | Automatic | Custom window size |
| LoadedNotification | boolean | true | Startup notification |
| NotifyTitle / NotifyContent | string | Automatic | Notification text |
| NotifyDuration | number | 3 | Notification duration |
| NotifyImage | string/number | Built-in | Notification icon |

> Some skins add extra options (for example `Theme` or `InitialScale`). Unsupported options are simply ignored.

## Tabs

```lua
local Main = Window:CreateTab("Main", 4483362458)
-- or
local Main = Window:CreateTab({ Name = "Main", Icon = 4483362458 })
```

Click a tab to open it. Hold a tab for about 0.8 seconds to delete it (with confirmation). The Settings page is created automatically.

## Sections

```lua
Main:CreateSection("General")
-- or
Main:CreateSection({ Name = "General", Description = "General controls." })
```

Some skins group the following components into a collapsible panel until the next `CreateSection` or `EndSection()`. Skins without panels render a simple divider instead. Both behave the same in code.

## Components

All components accept `Name`, `Description` (optional), and `Flag` (optional, enables saving).

### Button
```lua
Main:CreateButton({
    Name = "Execute",
    Interact = "Run",
    Callback = function() print("Clicked") end
})
```
Methods: `Set("Name" | "Interact" | "Visible" | "Callback", value)`

### Toggle
```lua
local Toggle = Main:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(state) print(state) end
})
```
Methods: `Set(bool)`, `State()`

### Slider
```lua
Main:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = 16,
    Suffix = " WS",
    Flag = "WalkSpeed",
    Callback = function(value) print(value) end
})
```
Methods: `Set(number)`

### Dropdown
```lua
local Dropdown = Main:CreateDropdown({
    Name = "Mode",
    Options = {"Easy", "Normal", "Hard"},
    CurrentOption = "Normal",
    MultipleOptions = false,
    Flag = "Mode",
    Callback = function(option) print(option) end
})
```
Methods: `Set`, `Add`, `Remove`, `Clear`, `Refresh(options, keepCurrent)`, `State()`

With `MultipleOptions = true`, the callback receives a dictionary: `{ ESP = true, Radar = true }`.

### Input
```lua
local Input = Main:CreateInput({
    Name = "Username",
    PlaceholderText = "Enter text...",
    CurrentValue = "",
    RemoveTextAfterFocusLost = false,
    Callback = function(text) print(text) end
})
```
Methods: `Set(text)`, `Get()`

### Keybind
```lua
Main:CreateKeybind({
    Name = "Action",
    CurrentKeybind = Enum.KeyCode.F,
    HoldToInteract = false,
    Callback = function() print("Pressed") end
})
```
Methods: `Set(Enum.KeyCode)`, `Key()`

### Paragraph
```lua
local Para = Main:CreateParagraph({
    Title = "Information",
    Content = "Welcome!",
    Icon = 10723434711,
    Copyable = false
})
```
Methods: `Set(title, content)`, `SetTitle`, `SetContent`, `Get()`

## Notifications

```lua
Window:Notify({
    Title = "Success",
    Content = "Action completed!",
    Duration = 3,
    Image = "10723434711"
})
```

## Confirmation Dialog

```lua
Window:ConfirmationAction({
    Title = "Confirm",
    Message = "Are you sure?",
    ConfirmText = "Yes",
    CancelText = "No",
    OnConfirm = function() print("Confirmed") end,
    OnCancel = function() print("Cancelled") end
})
```

## Settings

Add your own components to the Settings page:

```lua
Window:CreateSettingsSection("Custom")
Window:CreateSettingsToggle({ Name = "Option", Flag = "Option", Callback = print })
Window:CreateSettingsSlider(config)
Window:CreateSettingsDropdown(config)
Window:CreateSettingsButton(config)
Window:CreateSettingsParagraph(config)
Window:CreateSettingsInput(config)
Window:CreateSettingsKeybind(config)
```

## Configuration

Components with a `Flag` are saved to `FolderName/FileName`. Window size and position are saved as well.

> Requires an executor that supports `isfolder`, `makefolder`, `isfile`, `readfile`, and `writefile`. Without them the GUI still works, but nothing is saved.

## Complete Example

```lua
local Gui = loadstring(game:HttpGet("YOUR_RAW_URL"))()
local Window = Gui:Init({ Name = "My Project" })

local Main = Window:CreateTab("Main", 4483362458)
Main:CreateSection("General")

Main:CreateToggle({ Name = "Example", Flag = "Example", Callback = print })
Main:CreateSlider({ Name = "Speed", Range = {1, 100}, CurrentValue = 16, Callback = print })
Main:CreateButton({
    Name = "Notify",
    Interact = "Run",
    Callback = function()
        Window:Notify({ Title = "Hello", Content = "It works!" })
    end
})
```

## Requirements

- Roblox Luau executor with `loadstring` and `game:HttpGet`
- File API support (optional, for config saving)

## License

Add your preferred license before distributing.
