local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ==========================================
-- 1. UI CREATION & STYLING (THE CODE BRICK)
-- ==========================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FusionLabsUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main Menu Window
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 25, 50) -- Dark Purple Base
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Top Bar (Drag Area)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 15, 35) -- Darker Purple
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

-- Hide bottom corners of TopBar to blend perfectly
local TopBarLine = Instance.new("Frame")
TopBarLine.Size = UDim2.new(1, 0, 0, 5)
TopBarLine.Position = UDim2.new(0, 0, 1, -5)
TopBarLine.BackgroundColor3 = Color3.fromRGB(25, 15, 35)
TopBarLine.BorderSizePixel = 0
TopBarLine.Parent = TopBar

-- Title Text
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Fusion Labs"
Title.TextColor3 = Color3.fromRGB(220, 180, 255) -- Radiant Light Purple
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = TopBar

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
MinimizeButton.Position = UDim2.new(1, -40, 0, 0)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.Parent = TopBar

-- Left Sidebar (Navigation/Tabs Area)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 150, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 15, 35) -- Matches TopBar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 8)
SidebarCorner.Parent = Sidebar

-- Hide right/top corners of Sidebar to blend perfectly
local SidebarLine = Instance.new("Frame")
SidebarLine.Size = UDim2.new(0, 5, 1, 0)
SidebarLine.Position = UDim2.new(1, -5, 0, 0)
SidebarLine.BackgroundColor3 = Color3.fromRGB(25, 15, 35)
SidebarLine.BorderSizePixel = 0
SidebarLine.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.Padding = UDim.new(0, 4)
SidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 10)
SidebarPadding.Parent = Sidebar

-- Main Display Canvas (Where dropdown menus open their items)
local DisplayCanvas = Instance.new("Frame")
DisplayCanvas.Name = "DisplayCanvas"
DisplayCanvas.Size = UDim2.new(1, -160, 1, -50)
DisplayCanvas.Position = UDim2.new(0, 155, 0, 45)
DisplayCanvas.BackgroundTransparency = 1
DisplayCanvas.Parent = MainFrame

-- ==========================================
-- 2. DROPDOWN FACTORY FUNCTION
-- ==========================================

local activeDropdownContainer = nil

local function createDropdown(name, layoutOrder)
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Name = name .. "Dropdown"
    DropdownFrame.Size = UDim2.new(0, 135, 0, 32)
    DropdownFrame.BackgroundTransparency = 1
    DropdownFrame.LayoutOrder = layoutOrder
    DropdownFrame.Parent = Sidebar

    local Trigger = Instance.new("TextButton")
    Trigger.Name = "Trigger"
    Trigger.Size = UDim2.new(1, 0, 1, 0)
    Trigger.BackgroundColor3 = Color3.fromRGB(45, 30, 65)
    Trigger.Text = "  " .. name .. " ▼"
    Trigger.TextColor3 = Color3.fromRGB(230, 210, 255)
    Trigger.Font = Enum.Font.GothamMedium
    Trigger.TextSize = 14
    Trigger.TextXAlignment = Enum.TextXAlignment.Left
    Trigger.Parent = DropdownFrame

    local TriggerCorner = Instance.new("UICorner")
    TriggerCorner.CornerRadius = UDim.new(0, 6)
    TriggerCorner.Parent = Trigger

    -- Hover effects for the buttons
    Trigger.MouseEnter:Connect(function()
        TweenService:Create(Trigger, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 40, 85)}):Play()
    end)
    Trigger.MouseLeave:Connect(function()
        TweenService:Create(Trigger, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 30, 65)}):Play()
    end)

    -- The viewport container where the modules/buttons will layout inside the main panel
    local Container = Instance.new("ScrollingFrame")
    Container.Name = name .. "Container"
    Container.Size = UDim2.new(1, 0, 1, 0)
    Container.BackgroundTransparency = 1
    Container.BorderSizePixel = 0
    Container.Visible = false
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.ScrollBarThickness = 4
    Container.ScrollBarImageColor3 = Color3.fromRGB(80, 50, 110)
    Container.Parent = DisplayCanvas

    local ContainerList = Instance.new("UIListLayout")
    ContainerList.Padding = UDim.new(0, 6)
    ContainerList.SortOrder = Enum.SortOrder.LayoutOrder
    ContainerList.Parent = Container

    ContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Container.CanvasSize = UDim2.new(0, 0, 0, ContainerList.AbsoluteContentSize.Y)
    end)

    -- Click logic to toggle visibility and handle the arrow icon
    Trigger.MouseButton1Click:Connect(function()
        if activeDropdownContainer and activeDropdownContainer ~= Container then
            activeDropdownContainer.Visible = false
            local oldTrigger = activeDropdownContainer.Parent.Parent:WaitForChild(activeDropdownContainer.Name:gsub("Container", "Dropdown")):WaitForChild("Trigger")
            oldTrigger.Text = string.gsub(oldTrigger.Text, "▲", "▼")
        end

        Container.Visible = not Container.Visible
        if Container.Visible then
            Trigger.Text = string.gsub(Trigger.Text, "▼", "▲")
            activeDropdownContainer = Container
        else
            Trigger.Text = string.gsub(Trigger.Text, "▲", "▼")
            if activeDropdownContainer == Container then
                activeDropdownContainer = nil
            end
        end
    end)

    return Container
end

-- Generate our three specified dropdowns
local CheatsContainer = createDropdown("Cheats", 1)
local SettingsContainer = createDropdown("Settings", 2)
local GamesContainer = createDropdown("Games", 3)


-- ==========================================
-- 3. INTERACTION & UTILITY CODE (DRAG / MIN)
-- ==========================================

-- Draggable Functionality
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

-- Minimize Functionality
local isMinimizing = false
local originalSize = MainFrame.Size

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimizing = not isMinimizing
    if isMinimizing then
        MainFrame.Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, TopBar.Size.Y.Offset)
        Sidebar.Visible = false
        DisplayCanvas.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = originalSize
        Sidebar.Visible = true
        DisplayCanvas.Visible = true
        MinimizeButton.Text = "−"
    end
end)
