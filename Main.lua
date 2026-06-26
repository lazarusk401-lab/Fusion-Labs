-- Load Fusion UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/FusionLib.lua"))()

-- Create the window
local Window = Library.CreateWindow({
    Name = "Fusion Labs",
    Theme = "Dark",
})

-- Main frame
local MainFrame = Window.Main

-- Minimize button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 50, 0, 50)
minimizeButton.Position = UDim2.new(0.9, -55, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(44, 47, 51)
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Text = "-"
minimizeButton.Parent = MainFrame

local isMinimized = false
minimizeButton.MouseButton1Click:Connect(function()
    if not isMinimized then
        -- Minimize window
        Window.Main:TweenSize(UDim2.new(0, 100, 0, 100), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3)
        minimizeButton:TweenPosition(UDim2.new(0.95, -75, 0.85, -75), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3)
        isMinimized = true
    else
        -- Restore window
        Window.Main:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3) -- Adjusted to fit the screen
        minimizeButton:TweenPosition(UDim2.new(0.9, -55, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3)
        isMinimized = false
    end
end)

-- Universal Tab
local UniversalTab = Window.AddTab("Universal")

-- Settings Tab
local SettingsTab = Window.AddTab("Settings")

local HotkeysSection = SettingsTab.AddSection("Hotkeys")
HotkeysSection.AddKeybind({
    Name = "Toggle Minimize",
    Default = Enum.KeyCode.RightAlt,
    Callback = function()
        if not isMinimized then
            -- Minimize window
            Window.Main:TweenSize(UDim2.new(0, 100, 0, 100), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3)
            minimizeButton:TweenPosition(UDim2.new(0.95, -75, 0.85, -75), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3)
            isMinimized = true
        else
            -- Restore window
            Window.Main:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3) -- Adjusted to fit the screen
            minimizeButton:TweenPosition(UDim2.new(0.9, -55, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3)
            isMinimized = false
        end
    end,
})

-- Add more sections and elements as needed

--- ========================================== ---
---        Mischievous Mechanics (Scripting)   ---
--- ========================================== ---

-- 1. Smooth Dragging Logic
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    -- Linear interpolation (Lerp) creates that buttery smooth following effect
    local targetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    TweenService:Create(MainFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPos}):Play()
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- 2. Sleek Minimize Logic (Already handled by the button click event)
