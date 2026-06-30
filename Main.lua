local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Clean up any old iterations of the UI first
if PlayerGui:FindFirstChild("FusionLabsUI") then
    PlayerGui.FusionLabsUI:Destroy()
end

-- ==========================================
-- 1. GLOWING CYBERPUNK UI CODE BRICK
-- ==========================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FusionLabsUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main Panel
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(11, 10, 15) -- Deep Space Black
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Outer Neon Border Accent
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(130, 45, 255) -- Bright Neon Purple
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.2
UIStroke.Parent = MainFrame

-- Top Drag Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(16, 14, 23) -- Subtle Dark Purple Tint
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

-- Clean up bottom edges of TopBar
local TopBarLine = Instance.new("Frame")
TopBarLine.Size = UDim2.new(1, 0, 0, 10)
TopBarLine.Position = UDim2.new(0, 0, 1, -10)
TopBarLine.BackgroundColor3 = Color3.fromRGB(16, 14, 23)
TopBarLine.BorderSizePixel = 0
TopBarLine.Parent = TopBar

-- UI Title (Polished Sci-Fi Style)
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 250, 1, 0)
Title.Position = UDim2.new(0, 18, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "FUSION_LABS // v1.0"
Title.TextColor3 = Color3.fromRGB(165, 90, 255) -- Glowing Purple
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.RobotoMono
Title.TextSize = 16
Title.Parent = TopBar

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 45, 0, 45)
MinimizeButton.Position = UDim2.new(1, -45, 0, 0)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "[ − ]"
MinimizeButton.TextColor3 = Color3.fromRGB(130, 45, 255)
MinimizeButton.Font = Enum.Font.RobotoMono
MinimizeButton.TextSize = 16
MinimizeButton.Parent = TopBar

-- Left Tab Navigation Container
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 160, 1, -45)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.BackgroundColor3 = Color3.fromRGB(14, 12, 18)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

-- Neon Separator Line
local Separator = Instance.new("Frame")
Separator.Name = "Separator"
Separator.Size = UDim2.new(0, 1, 1, 0)
Separator.Position = UDim2.new(1, 0, 0, 0)
Separator.BackgroundColor3 = Color3.fromRGB(45, 35, 65)
Separator.BorderSizePixel = 0
Separator.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.Padding = UDim.new(0, 8)
SidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 15)
SidebarPadding.Parent = Sidebar

-- Main Window Display Canvas
local DisplayCanvas = Instance.new("Frame")
DisplayCanvas.Name = "DisplayCanvas"
DisplayCanvas.Size = UDim2.new(1, -175, 1, -60)
DisplayCanvas.Position = UDim2.new(0, 170, 0, 52)
DisplayCanvas.BackgroundTransparency = 1
DisplayCanvas.Parent = MainFrame


-- ==========================================
-- 2. POLISHED SELECTION DROPDOWN ENGINE
-- ==========================================

local activeDropdownContainer = nil

local function createDropdown(name, layoutOrder)
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Name = name .. "Dropdown"
    DropdownFrame.Size = UDim2.new(0, 140, 0, 36)
    DropdownFrame.BackgroundTransparency = 1
    DropdownFrame.LayoutOrder = layoutOrder
    DropdownFrame.Parent = Sidebar

    local Trigger = Instance.new("TextButton")
    Trigger.Name = "Trigger"
    Trigger.Size = UDim2.new(1, 0, 1, 0)
    Trigger.BackgroundColor3 = Color3.fromRGB(22, 18, 32)
    Trigger.Text = " >  " .. string.upper(name)
    Trigger.TextColor3 = Color3.fromRGB(200, 180, 240)
    Trigger.Font = Enum.Font.RobotoMono
    Trigger.TextSize = 13
    Trigger.TextXAlignment = Enum.TextXAlignment.Left
    Trigger.Parent = DropdownFrame

    local TriggerCorner = Instance.new("UICorner")
    TriggerCorner.CornerRadius = UDim.new(0, 4)
    TriggerCorner.Parent = Trigger

    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.Color = Color3.fromRGB(50, 40, 70)
    ButtonStroke.Thickness = 1
    ButtonStroke.Parent = Trigger

    -- Premium Hover Visual Response Matrix
    Trigger.MouseEnter:Connect(function()
        TweenService:Create(Trigger, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(32, 24, 48),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(140, 50, 255)}):Play()
    end)
    Trigger.MouseLeave:Connect(function()
        if activeDropdownContainer and activeDropdownContainer.Name == name .. "Container" then return end
        TweenService:Create(Trigger, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(22, 18, 32),
            TextColor3 = Color3.fromRGB(200, 180, 240)
        }):Play()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(50, 40, 70)}):Play()
    end)

    -- Viewport container for modular content injections
    local Container = Instance.new("ScrollingFrame")
    Container.Name = name .. "Container"
    Container.Size = UDim2.new(1, 0, 1, 0)
    Container.BackgroundTransparency = 1
    Container.BorderSizePixel = 0
    Container.Visible = false
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.ScrollBarThickness = 4
    Container.ScrollBarImageColor3 = Color3.fromRGB(140, 50, 255)
    Container.Parent = DisplayCanvas

    local ContainerList = Instance.new("UIListLayout")
    ContainerList.Padding = UDim.new(0, 8)
    ContainerList.SortOrder = Enum.SortOrder.LayoutOrder
    ContainerList.Parent = Container

    ContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Container.CanvasSize = UDim2.new(0, 0, 0, ContainerList.AbsoluteContentSize.Y)
    end)

    Trigger.MouseButton1Click:Connect(function()
        -- Handle closure of active drop menus seamlessly
        if activeDropdownContainer and activeDropdownContainer ~= Container then
            activeDropdownContainer.Visible = false
            local oldName = activeDropdownContainer.Name:gsub("Container", "Dropdown")
            local oldDropdown = Sidebar:FindFirstChild(oldName)
            if oldDropdown then
                local oldTrigger = oldDropdown:FindFirstChild("Trigger")
                local oldStroke = oldTrigger and oldTrigger:FindFirstChild("UIStroke")
                if oldTrigger then 
                    oldTrigger.Text = oldTrigger.Text:gsub("▼", "")
                    TweenService:Create(oldTrigger, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(22, 18, 32), TextColor3 = Color3.fromRGB(200, 180, 240)}):Play()
                end
                if oldStroke then oldStroke.Color = Color3.fromRGB(50, 40, 70) end
            end
        end

        Container.Visible = not Container.Visible
        if Container.Visible then
            Trigger.Text = " ▼  " .. string.upper(name)
            TweenService:Create(Trigger, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(42, 28, 64), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(ButtonStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(165, 90, 255)}):Play()
            activeDropdownContainer = Container
        else
            Trigger.Text = " >  " .. string.upper(name)
            TweenService:Create(Trigger, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(22, 18, 32), TextColor3 = Color3.fromRGB(200, 180, 240)}):Play()
            TweenService:Create(ButtonStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(50, 40, 70)}):Play()
            if activeDropdownContainer == Container then activeDropdownContainer = nil end
        end
    end)

    return Container
end

local CheatsContainer = createDropdown("Cheats", 1)
local SettingsContainer = createDropdown("Settings", 2)
local GamesContainer = createDropdown("Games", 3)


-- ==========================================
-- 3. INTERACTION UTILITIES
-- ==========================================

-- Frictionless Smooth Panel Dragging Matrix
local dragging, dragInput, dragStart, startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
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

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- Window Minimize Animation Matrix
local isMinimizing = false
local originalSize = MainFrame.Size

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimizing = not isMinimizing
    if isMinimizing then
        MainFrame.Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, TopBar.Size.Y.Offset)
        Sidebar.Visible = false
        DisplayCanvas.Visible = false
        MinimizeButton.Text = "[ + ]"
    else
        MainFrame.Size = originalSize
        Sidebar.Visible = true
        DisplayCanvas.Visible = true
        MinimizeButton.Text = "[ − ]"
    end
end)
