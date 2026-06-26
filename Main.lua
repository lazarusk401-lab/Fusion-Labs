-- Services required for our enchantments
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Core Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FusionLabs_Menu"
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Main rounded container window
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 560, 0, 360)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true -- Essential for the minimization illusion
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Top Drag/Title Area (The handle we will use to move the frame)
local DragHeader = Instance.new("Frame")
DragHeader.Name = "DragHeader"
DragHeader.Size = UDim2.new(1, 0, 0, 40)
DragHeader.BackgroundTransparency = 1
DragHeader.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(0, 200, 0, 40)
TitleLabel.Position = UDim2.new(0, 16, 0, 0)
TitleLabel.Text = "Fusion Labs"
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 127) -- Emerald green
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.BackgroundTransparency = 1
TitleLabel.Parent = DragHeader

-- The Minimize Button (A elegant, subtle dash)
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -40, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = DragHeader

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 4)
MinCorner.Parent = MinimizeButton

-- Sidebar navigation column
local NavigationColumn = Instance.new("Frame")
NavigationColumn.Name = "NavigationColumn"
NavigationColumn.Size = UDim2.new(0, 140, 1, -60)
NavigationColumn.Position = UDim2.new(0, 16, 0, 48)
NavigationColumn.BackgroundTransparency = 1
NavigationColumn.Parent = MainFrame

local NavLayout = Instance.new("UIListLayout")
NavLayout.Padding = UDim.new(0, 6)
NavLayout.SortOrder = Enum.SortOrder.LayoutOrder
NavLayout.Parent = NavigationColumn

-- Main interactive section container
local DisplayPanel = Instance.new("Frame")
DisplayPanel.Name = "DisplayPanel"
DisplayPanel.Size = UDim2.new(1, -184, 1, -60)
DisplayPanel.Position = UDim2.new(0, 168, 0, 48)
DisplayPanel.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
DisplayPanel.BorderSizePixel = 0
DisplayPanel.Parent = MainFrame

local PanelCorner = Instance.new("UICorner")
PanelCorner.CornerRadius = UDim.new(0, 6)
PanelCorner.Parent = DisplayPanel

-- Tab Generation
local function BuildMenuTab(labelName, orderIndex)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = labelName .. "_Tab"
    TabButton.Size = UDim2.new(1, 0, 0, 32)
    TabButton.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
    TabButton.BorderSizePixel = 0
    TabButton.Text = "  " .. labelName
    TabButton.TextColor3 = Color3.fromRGB(180, 180, 190)
    TabButton.Font = Enum.Font.GothamMedium
    TabButton.TextSize = 13
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.LayoutOrder = orderIndex
    TabButton.Parent = NavigationColumn
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 4)
    ButtonCorner.Parent = TabButton
    return TabButton
end

local UniversalButton = BuildMenuTab("Universal", 1)
local ESPButton       = BuildMenuTab("ESP", 2)
local SettingsButton  = BuildMenuTab("Settings", 3)

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

DragHeader.InputBegan:Connect(function(input)
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

DragHeader.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- 2. Sleek Minimize Logic
local isMinimized = false
local originalSize = MainFrame.Size

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    
    local targetSize = isMinimized and UDim2.new(0, 560, 0, 40) or originalSize
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    -- Animate the frame folding up or down
    TweenService:Create(MainFrame, tweenInfo, {Size = targetSize}):Play()
    MinimizeButton.Text = isMinimized and "+" or "-"
end)
