Roblox Gui

A modern, customizable, and responsive Roblox GUI library built with Lua. BulbGui provides a clean interface with modular components, dynamic themes, configuration saving, and interactive UI elements.

Features

- Modern Interface — Clean dark UI with a Bento-style section layout.
- Responsive Design — Automatically adapts to different screen sizes.
- Custom Themes — Three built-in color themes.
- Dynamic Search — Search for components across tabs.
- Configuration System — Automatically saves and loads supported settings.
- Window Controls — Drag, resize, minimize, hide, and restore the window.
- Performance Monitor — Displays FPS and network ping.
- Notifications — Animated notification system.
- Confirmation Dialogs — Built-in confirmation prompts.
- Mobile Support — Touch-friendly controls and draggable toggle button.

Installation

Load the library using "loadstring":

local RobloxGui = loadstring(game:HttpGet("YOUR_RAW_URL"))()

Replace "YOUR_RAW_URL" with your hosted raw Lua file URL.

Initialization

Create your GUI using "Init()":

local GUI = RobloxGui:Init({
    Name = "My Project",
    Subtitle = "Main Interface",
    Theme = "Obsidian Cyber",

    FolderName = "BulbGui_Configs",
    FileName = "settings.json",

    InitialScale = 0.6,

    LoadedNotification = true,
    NotifyTitle = "BulbGui",
    NotifyContent = "Interface successfully loaded!",
    NotifyDuration = 3
})

Initialization Parameters

Parameter| Type| Default| Description
Name| string| BulbGui| GUI name
Theme| string| Obsidian Cyber| Initial theme
FolderName| string| TumblrConfigs| Configuration folder
FileName| string| default.json| Configuration filename
InitialScale| number| 0.6| Initial window scale
Size| UDim2| Automatic| Custom window size
LoadedNotification| boolean| true| Enable startup notification
NotifyTitle| string| Load Script| Notification title
NotifyContent| string| Automatic| Notification message
NotifyDuration| number| 3| Notification duration
NotifyImage| string/number| Built-in icon| Notification image ID

Themes

BulbGui includes three built-in themes:

Theme| Description
Obsidian Cyber| Dark navy with cyan and indigo accents
Emerald Matrix| Dark green with emerald accents
Midnight Crimson| Dark red with crimson and amber accents

Change the theme dynamically:

GUI:SetTheme("Emerald Matrix")

Creating Tabs

Tabs organize your GUI into separate pages.

local MainTab = GUI:CreateTab({
    Name = "Main",
    Icon = 4483362458,
    Description = "Main features and controls.",
    Expanded = true
})

local PlayerTab = GUI:CreateTab({
    Name = "Player",
    Icon = 4483362458,
    Description = "Player customization."
})

You can also use the shorthand syntax:

local MainTab = GUI:CreateTab("Main", 4483362458)

Tab Parameters

Parameter| Type| Description
Name| string| Tab name
Icon| number| Roblox image asset ID
Description| string| Tab description
Expanded| boolean| Automatically select the tab

Additional behavior:

- Click a tab to switch pages.
- Hold a tab for approximately 0.8 seconds to open the delete confirmation.
- The Settings tab is automatically created.

Creating Sections

Sections group related components into collapsible cards.

GUI:CreateSection({
    Name = "General",
    Description = "General settings and controls.",
    Icon = 10723434711,
    Collapsed = false
})

Section Parameters

Parameter| Type| Description
Name| string| Section title
Description| string| Section description
Icon| number| Optional icon asset ID
Collapsed| boolean| Start collapsed
Expanded| boolean| Start expanded
Parent| Instance| Custom parent container

All components created afterward are placed inside the current section.

To stop adding components to the current section:

GUI:EndSection()

UI Components

1. Button

Create an interactive button.

GUI:CreateButton({
    Name = "Execute",
    Description = "Execute the selected action.",
    Interact = "Run",

    Callback = function()
        print("Button clicked!")
    end
})

Parameters:

Parameter| Type| Description
Name| string| Component name
Description| string| Optional description
Interact| string| Button text
Callback| function| Executed when clicked
DeleteMode| string| none, instant, or confirm
OnDelete| function| Executed when deleted
DeleteTitle| string| Confirmation title
DeleteMessage| string| Confirmation message
ConfirmText| string| Confirmation button text

Returned methods:

local Button = GUI:CreateButton({
    Name = "Test",
    Callback = function()
        print("Executed")
    end
})

Button:Set("Name", "New Name")
Button:Set("Interact", "Start")
Button:Set("Visible", false)
Button:Set("Callback", function()
    print("Updated callback")
end)

2. Toggle

Create an ON/OFF switch.

local Toggle = GUI:CreateToggle({
    Name = "Auto Farm",
    Description = "Enable or disable auto farm.",
    CurrentValue = false,
    Flag = "AutoFarm",

    Callback = function(value)
        print("Auto Farm:", value)
    end
})

Parameters:

Parameter| Type| Description
Name| string| Component name
Description| string| Optional description
CurrentValue| boolean| Initial state
Flag| string| Configuration identifier
Callback| function| Returns the new boolean state

Returned methods:

Toggle:Set(true)
print(Toggle:State())

3. Slider

Create a customizable value slider.

local Slider = GUI:CreateSlider({
    Name = "Walk Speed",
    Description = "Adjust movement speed.",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = 16,
    Suffix = " WS",
    Flag = "WalkSpeed",

    Callback = function(value)
        print("Speed:", value)
    end
})

Parameters:

Parameter| Type| Description
Name| string| Component name
Description| string| Optional description
Range| table| Minimum and maximum values
Increment| number| Value increment
CurrentValue| number| Initial value
Suffix| string| Value suffix
Flag| string| Configuration identifier
Callback| function| Returns the updated value

Returned methods:

Slider:Set(50)

4. Dropdown

Create a single-selection or multiple-selection dropdown.

Single Selection:

local Dropdown = GUI:CreateDropdown({
    Name = "Select Mode",
    Description = "Choose your preferred mode.",
    Options = {"Easy", "Normal", "Hard"},
    CurrentOption = "Normal",
    Flag = "GameMode",

    Callback = function(option)
        print("Selected:", option)
    end
})

Multiple Selection:

local Dropdown = GUI:CreateDropdown({
    Name = "Select Features",
    Options = {"ESP", "Aimbot", "Radar"},
    MultipleOptions = true,
    Flag = "SelectedFeatures",

    Callback = function(options)
        for option in pairs(options) do
            print(option)
        end
    end
})

Parameters:

Parameter| Type| Description
Name| string| Component name
Description| string| Optional description
Options| table| Available options
CurrentOption| string| Initial selection
MultipleOptions| boolean| Enable multiple selection
Flag| string| Configuration identifier
Callback| function| Returns selected option(s)

Returned methods:

Dropdown:Set("Easy")
Dropdown:Add("Extreme")
Dropdown:Remove("Normal")
Dropdown:Clear()
Dropdown:Refresh({"Option A", "Option B"}, false)

print(Dropdown:State())

For multiple selection, "Set()" accepts a table of selected options, represented as a dictionary:

Dropdown:Set({
    ESP = true,
    Radar = true
})

5. Input

Create a text input field.

local Input = GUI:CreateInput({
    Name = "Username",
    Description = "Enter your username.",
    PlaceholderText = "Enter text...",
    CurrentValue = "",
    Flag = "Username",

    Callback = function(value)
        print("Input:", value)
    end
})

Parameters:

Parameter| Type| Description
Name| string| Component name
Description| string| Optional description
PlaceholderText| string| Placeholder text
CurrentValue| string| Initial value
Default| string| Alternative default value
RemoveTextAfterFocusLost| boolean| Clear text after losing focus
Flag| string| Configuration identifier
Callback| function| Returns input text

Returned methods:

Input:Set("Hello World")
print(Input:Get())

6. Keybind

Create a customizable keyboard shortcut.

local Keybind = GUI:CreateKeybind({
    Name = "Toggle UI",
    Description = "Press a key to execute.",
    CurrentKeybind = Enum.KeyCode.RightControl,
    HoldToInteract = false,
    Flag = "ToggleKey",

    Callback = function()
        print("Key pressed!")
    end
})

Parameters:

Parameter| Type| Description
Name| string| Component name
Description| string| Optional description
CurrentKeybind| Enum.KeyCode| Initial key
HoldToInteract| boolean| Trigger on key press and release
Flag| string| Configuration identifier
Callback| function| Executed when the key is pressed

When "HoldToInteract" is enabled, the callback receives:

- "true" when the key is pressed.
- "false" when the key is released.

Returned methods:

Keybind:Set(Enum.KeyCode.F)
print(Keybind:Key())

7. Paragraph

Display informational text.

local Paragraph = GUI:CreateParagraph({
    Title = "Information",
    Content = "Welcome to BulbGui!",
    Icon = 10723434711,
    Copyable = false
})

Parameters:

Parameter| Type| Description
Title| string| Paragraph title
Content| string| Paragraph content
Icon| number| Optional icon asset ID
Copyable| boolean| Allow text selection and copying

Returned methods:

Paragraph:Set("New Title", "Updated content.")
Paragraph:SetTitle("New Title")
Paragraph:SetContent("Updated content.")

local title, content = Paragraph:Get()

Notifications

Display animated notifications anywhere on the screen.

GUI:Notify({
    Title = "Success",
    Content = "Your action has been completed!",
    Duration = 3,
    Image = "10723434711"
})

Parameters:

Parameter| Type| Default
Title| string| Notification
Content| string| This is a notification
Duration| number| 3
Image| string/number| 10723434711

Confirmation Dialog

Create a confirmation dialog with confirm and cancel callbacks.

GUI:ConfirmationAction({
    Title = "Confirmation",
    Message = "Are you sure you want to continue?",
    ConfirmText = "Yes",
    CancelText = "No",

    OnConfirm = function()
        print("Confirmed!")
    end,

    OnCancel = function()
        print("Cancelled!")
    end
})

Clicking outside the dialog also triggers "OnCancel".

Settings

BulbGui automatically creates a Settings tab containing:

- Information — GUI version, current username, and game name.
- Theme — Switch between built-in themes.
- UI Toggle Key — Customize the window toggle key.

You can also add your own components to Settings.

GUI:CreateSettingsSection("Custom Settings")

GUI:CreateSettingsToggle({
    Name = "Example Toggle",
    CurrentValue = true,
    Flag = "ExampleToggle",
    Callback = function(value)
        print(value)
    end
})

GUI:CreateSettingsButton({
    Name = "Reset",
    Interact = "Reset",
    Callback = function()
        print("Reset clicked")
    end
})

GUI:CreateSettingsParagraph({
    Title = "About",
    Content = "Custom settings information."
})

Available Settings methods:

GUI:CreateSettingsSection(config)
GUI:CreateSettingsToggle(config)
GUI:CreateSettingsSlider(config)
GUI:CreateSettingsDropdown(config)
GUI:CreateSettingsButton(config)
GUI:CreateSettingsParagraph(config)
GUI:CreateSettingsInput(config)
GUI:CreateSettingsKeybind(config)

Configuration System

BulbGui automatically saves and restores supported component values when a "Flag" is assigned.

Example:

GUI:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarm",

    Callback = function(value)
        print(value)
    end
})

Configuration files are stored using the following structure:

BulbGui_Configs/
└── settings.json

Supported saved data includes:

- Toggle states.
- Slider values.
- Dropdown selections.
- Input values.
- Keybinds.
- Selected theme.
- Window dimensions and position.

Note: File persistence requires the execution environment to support "isfolder", "makefolder", "isfile", "readfile", and "writefile".

Search System

BulbGui includes a built-in search bar that allows users to find components across different tabs.

- Search by component or section name.
- Search descriptions.
- Automatically switch to a matching tab.
- "Ctrl + K" focuses the search field on supported keyboards.

Window Controls

BulbGui provides several built-in window controls:

Control| Function
Toggle Button| Show or hide the interface
Minimize| Collapse the window
Close| Hide the window
Drag| Move the window
Resize| Adjust window dimensions

The circular toggle button can also be dragged to another screen position.

Complete Example

local BulbGui = loadstring(game:HttpGet("YOUR_RAW_URL"))()

local GUI = BulbGui:Init({
    Name = "My Project",
    Theme = "Obsidian Cyber",
    FolderName = "BulbGui_Configs",
    FileName = "settings.json"
})

local Main = GUI:CreateTab({
    Name = "Main",
    Description = "Main controls.",
    Icon = 4483362458,
    Expanded = true
})

GUI:CreateSection({
    Name = "General",
    Description = "General settings."
})

GUI:CreateToggle({
    Name = "Example Toggle",
    CurrentValue = false,
    Flag = "ExampleToggle",

    Callback = function(value)
        print("Toggle:", value)
    end
})

GUI:CreateSlider({
    Name = "Speed",
    Range = {1, 100},
    Increment = 1,
    CurrentValue = 16,
    Flag = "Speed",

    Callback = function(value)
        print("Speed:", value)
    end
})

GUI:CreateDropdown({
    Name = "Mode",
    Options = {"Easy", "Normal", "Hard"},
    CurrentOption = "Normal",

    Callback = function(value)
        print("Mode:", value)
    end
})

GUI:CreateInput({
    Name = "Username",
    PlaceholderText = "Enter username...",

    Callback = function(value)
        print("Username:", value)
    end
})

GUI:CreateButton({
    Name = "Test Notification",
    Interact = "Notify",

    Callback = function()
        GUI:Notify({
            Title = "Hello!",
            Content = "BulbGui is working.",
            Duration = 3
        })
    end
})

GUI:CreateParagraph({
    Title = "Welcome",
    Content = "Thank you for using BulbGui!"
})

Requirements

- Roblox Lua / Luau.
- A compatible execution environment.
- "loadstring" and HTTP request support for remote loading.
- File API support for configuration persistence.

License

Add your preferred license before distributing or modifying this project.

---

RobloxGui — A modern and flexible Roblox GUI library.
