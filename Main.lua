local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ==========================================
-- 0. STRIKE AND PURGE ALL PREVIOUS JANKY UI
-- ==========================================
for _, child in pairs(PlayerGui:GetChildren()) do
    if child.Name == "FusionLabsUI" or child:FindFirstChild("MainFrame") then
        child:Destroy()
    end
end

-- ==========================================
-- 1. HARD-CODED TERMINAL RED EXECUTOR FRAME
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
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 10, 10) -- Pitch Off-Black
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 4) -- Angular hacker aesthetic
MainCorner.Parent = MainFrame

-- Crimson Neon Laser Frame Stroke
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 30, 60) -- Neon Red
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Top Bar Drag Container
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 14, 14) -- Dark Blood Red Tint
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopLine = Instance.new("Frame")
TopLine.Size = UDim2.new(1, 0, 0, 1)
TopLine.Position = UDim2.new(0, 0, 1, -1)
TopLine.BackgroundColor3 = Color3.fromRGB(150, 20, 40)
TopLine.BorderSizePixel = 0
TopLine.Parent = TopBar

-- Code Style Header Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 350, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "CRITICAL_ERROR://FUSION_LABS.BAT [CONSOLE ROOT]"
Title.TextColor3 = Color3.fromRGB(255, 60, 80)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.Code
Title.TextSize = 13
Title.Parent = TopBar

-- Console Window Exit/Minimize Icon
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
MinimizeButton.Position = UDim2.new(1, -40, 0, 0)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "[X]"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 60, 80)
MinimizeButton.Font = Enum.Font.Code
MinimizeButton.TextSize = 13
MinimizeButton.Parent = TopBar

-- Locked Sidebar Frame (Forces dropdowns inside boundaries)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 145, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(16, 12, 12)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarLine = Instance.new("Frame")
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(1, -1, 0, 0)
SidebarLine.BackgroundColor3 = Color3.fromRGB(80, 20, 30)
SidebarLine.BorderSizePixel = 0
SidebarLine.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.Padding = UDim.new(0, 8)
SidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 12)
SidebarPadding.Parent = Sidebar

-- Inside Canvas Display Panel
local DisplayCanvas = Instance.new("Frame")
DisplayCanvas.Name = "DisplayCanvas"
DisplayCanvas.Size = UDim2.new(1, -160, 1, -55)
DisplayCanvas.Position = UDim2.new(0, 152, 0, 48)
DisplayCanvas.BackgroundTransparency = 1
DisplayCanvas.Parent = MainFrame


-- ==========================================
-- 2. ENCAPSULATION DROPDOWN ENGINE
-- ==========================================

local activeDropdownContainer = nil

local function createDropdown(name, layoutOrder)
    -- Root Frame hard-parented directly to internal sidebar array layout
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Name = name .. "Dropdown"
    DropdownFrame.Size = UDim2.new(0, 130, 0, 34)
    DropdownFrame.BackgroundTransparency = 1
    DropdownFrame.LayoutOrder = layoutOrder
    DropdownFrame.Parent = Sidebar

    local Trigger = Instance.new("TextButton")
    Trigger.Name = "Trigger"
    Trigger.Size = UDim2.new(1, 0, 1, 0)
    Trigger.BackgroundColor3 = Color3.fromRGB(26, 16, 16)
    Trigger.Text = " // " .. string.upper(name)
    Trigger.TextColor3 = Color3.fromRGB(220, 70, 80)
    Trigger.Font = Enum.Font.Code
    Trigger.TextSize = 13
    Trigger.TextXAlignment = Enum.TextXAlignment.Left
    Trigger.Parent = DropdownFrame

    local TriggerCorner = Instance.new("UICorner")
    TriggerCorner.CornerRadius = UDim.new(0, 2)
    TriggerCorner.Parent = Trigger

    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.Color = Color3.fromRGB(90, 25, 30)
    ButtonStroke.Thickness = 1
    ButtonStroke.Parent = Trigger

    -- Interactive Matrix Glow Updates
    Trigger.MouseEnter:Connect(function()
        TweenService:Create(Trigger, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(40, 18, 22),
            TextColor3 = Color3.fromRGB(255, 100, 110)
        }):Play()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(255, 40, 60)}):Play()
    end)
    Trigger.MouseLeave:Connect(function()
        if activeDropdownContainer and activeDropdownContainer.Name == name .. "Container" then return end
        TweenService:Create(Trigger, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(26, 16, 16),
            TextColor3 = Color3.fromRGB(220, 70, 80)
        }):Play()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(90, 25, 30)}):Play()
    end)

    -- Item Container Display Port
    local Container = Instance.new("ScrollingFrame")
    Container.Name = name .. "Container"
    Container.Size = UDim2.new(1, 0, 1, 0)
    Container.BackgroundTransparency = 1
    Container.BorderSizePixel = 0
    Container.Visible = false
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.ScrollBarThickness = 4
    Container.ScrollBarImageColor3 = Color3.fromRGB(255, 30, 60)
    Container.Parent = DisplayCanvas

    local ContainerList = Instance.new("UIListLayout")
    ContainerList.Padding = UDim.new(0, 8)
    ContainerList.SortOrder = Enum.SortOrder.LayoutOrder
    ContainerList.Parent = Container

    ContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Container.CanvasSize = UDim2.new(0, 0, 0, ContainerList.AbsoluteContentSize.Y)
    end)

    Trigger.MouseButton1Click:Connect(function()
        if activeDropdownContainer and activeDropdownContainer ~= Container then
            activeDropdownContainer.Visible = false
            local oldName = activeDropdownContainer.Name:gsub("Container", "Dropdown")
            local oldDropdown = Sidebar:FindFirstChild(oldName)
            if oldDropdown then
                local oldTrigger = oldDropdown:FindFirstChild("Trigger")
                local oldStroke = oldTrigger and oldTrigger:FindFirstChild("UIStroke")
                if oldTrigger then 
                    oldTrigger.Text = " // " .. oldTrigger.Name:gsub("Dropdown", ""):upper()
                    TweenService:Create(oldTrigger, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(26, 16, 16), TextColor3 = Color3.fromRGB(220, 70, 80)}):Play()
                end
                if oldStroke then oldStroke.Color = Color3.fromRGB(90, 25, 30) end
            end
        end

        Container.Visible = not Container.Visible
        if Container.Visible then
            Trigger.Text = " >  " .. string.upper(name)
            TweenService:Create(Trigger, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 15, 20), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(ButtonStroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(255, 30, 60)}):Play()
            activeDropdownContainer = Container
        else
            Trigger.Text = " // " .. string.upper(name)
            TweenService:Create(Trigger, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(26, 16, 16), TextColor3 = Color3.fromRGB(220, 70, 80)}):Play()
            TweenService:Create(ButtonStroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(90, 25, 30)}):Play()
            if activeDropdownContainer == Container then activeDropdownContainer = nil end
        end
    end)

    return Container
end

local CheatsContainer = createDropdown("Cheats", 1)
local SettingsContainer = createDropdown("Settings", 2)
local GamesContainer = createDropdown("Games", 3)


-- ==========================================
-- 3. INTERACTION CONTROLS (DRAG / MINIMIZE)
-- ==========================================

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

topBarInputChangedConnection = TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

local isMinimizing = false
local originalSize = MainFrame.Size

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimizing = not isMinimizing
    if isMinimizing then
        MainFrame.Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, TopBar.Size.Y.Offset)
        Sidebar.Visible = false
        DisplayCanvas.Visible = false
        MinimizeButton.Text = "[+]"
    else
        MainFrame.Size = originalSize
        Sidebar.Visible = true
        DisplayCanvas.Visible = true
        MinimizeButton.Text = "[X]"
    end
end)
