-- Load Fusion UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/FusionLib.lua"))()

-- Create the window
local Window = Library.CreateWindow({
    Name = "Fusion Labs",
    Theme = "Dark",
    Position = Enum.WindowPosition.Center,
})

-- Minimize button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 50, 0, 50)
minimizeButton.Position = UDim2.new(0.9, -55, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(44, 47, 51)
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Text = "-"
minimizeButton.Parent = Window.Main

local isMinimized = false
minimizeButton.MouseButton1Click:Connect(function()
    if not isMinimized then
        -- Minimize window
        Window.Main:TweenSize(UDim2.new(0, 100, 0, 100), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3)
        minimizeButton:TweenPosition(UDim2.new(0.95, -75, 0.85, -75), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3)
        isMinimized = true
    else
        -- Restore window
        Window.Main:TweenSize(UDim2.new(0, 600, 0, 400), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3)
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
            Window.Main:TweenSize(UDim2.new(0, 600, 0, 400), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3)
            minimizeButton:TweenPosition(UDim2.new(0.9, -55, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3)
            isMinimized = false
        end
    end,
})

-- ESP Tab
local ESPTab = Window.AddTab("ESP")

-- Add glowing effect to the UI
Window.Main.BackgroundColor3 = Color3.fromRGB(44, 47, 51)
for i,v in pairs(Window.Main:GetDescendants()) do
    if v:IsA("UIStroke") then
        v.Color = Color3.fromRGB(255, 0, 0)
        v.Transparency = 0.8
        v.Thickness = 2
    end
end

-- Glow effect for minimize button
minimizeButton.Stroke = Instance.new("UIStroke")
minimizeButton.Stroke.Color = Color3.fromRGB(255, 0, 0)
minimizeButton.Stroke.Transparency = 0.8
minimizeButton.Stroke.Thickness = 2

-- Enable glow effect when hovering over minimize button
minimizeButton.MouseEnter:Connect(function()
    minimizeButton.Stroke.Transparency = 0.6
end)

minimizeButton.MouseLeave:Connect(function()
    minimizeButton.Stroke.Transparency = 0.8
end)
