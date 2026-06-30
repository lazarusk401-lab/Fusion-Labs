local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Clean up any old UI iterations
if PlayerGui:FindFirstChild("FusionLabsUI") then
    PlayerGui.FusionLabsUI:Destroy()
end

-- ==========================================
-- 1. TERMINAL GREEN UI BRICK
-- ==========================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FusionLabsUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main Console Panel
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 620, 0, 420)
MainFrame.Position = UDim2.new(0.5, -310, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 8, 5) -- Terminal Black-Green
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 4) -- Sharp, industrial corners
MainCorner.Parent = MainFrame

-- Neon Matrix Cyber Border
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 255, 100) -- Toxic Neon Green
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.1
UIStroke.Parent = MainFrame

-- Matrix Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(10, 18, 12)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarBorder = Instance.new("Frame")
TopBarBorder.Size = UDim2.new(1, 0, 0, 1)
TopBarBorder.Position = UDim2.new(0, 0, 1, 0)
TopBarBorder.BackgroundColor3 = Color3.fromRGB(0, 180, 70)
TopBarBorder.BorderSizePixel = 0
TopBarBorder.Parent = TopBar

-- Console Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Position = UDim2.new(0, 14, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SYSTEM://FUSION_LABS.EXE [STATUS: ACTIVE]"
Title.TextColor3 = Color3.fromRGB(0, 255, 120)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.Code
Title.TextSize = 14
Title.Parent = TopBar

-- Collapse/Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
MinimizeButton.Position = UDim2.new(1, -40, 0, 0)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "[_]"
MinimizeButton.TextColor3 = Color3.fromRGB(0, 255, 120)
MinimizeButton.Font = Enum.Font.Code
MinimizeButton.TextSize = 14
MinimizeButton.Parent = TopBar

-- Fixed Sidebar Navigation
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 150, 1, -41)
Sidebar.Position = UDim2.new(0, 0, 0, 41)
Sidebar.BackgroundColor3 = Color3.fromRGB(8, 12, 8)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarRightBorder = Instance.new("Frame")
SidebarRightBorder.Size = UDim2.new(0, 1, 1, 0)
SidebarRightBorder.Position = UDim2.new(1, -1, 0, 0)
SidebarRightBorder.BackgroundColor3 = Color3.fromRGB(0, 100, 40)
SidebarRightBorder.BorderSizePixel = 0
SidebarRightBorder.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.Padding = UDim.new(0, 8)
SidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 12)
SidebarPadding.Parent = Sidebar

-- Dynamic Execution Display Canvas
local DisplayCanvas = Instance.new("Frame")
DisplayCanvas.Name = "DisplayCanvas"
DisplayCanvas.Size = UDim2.new(1, -165, 1, -55)
DisplayCanvas.Position = UDim2.new(0, 158, 0, 48)
DisplayCanvas.BackgroundTransparency = 1
DisplayCanvas.Parent = MainFrame


-- ==========================================
-- 2. INDUSTRIAL DROPDOWN INJECTION MATRIX
-- ==========================================

local activeDropdownContainer = nil

local function createDropdown(name, layoutOrder)
    -- Explicitly parenting everything inside the master frame hierarchy structure
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Name = name .. "Dropdown"
    DropdownFrame.Size = UDim2.new(0, 134, 0, 34)
    DropdownFrame.BackgroundTransparency = 1
    DropdownFrame.LayoutOrder = layoutOrder
    DropdownFrame.Parent = Sidebar

    local Trigger = Instance.new("TextButton")
    Trigger.Name = "Trigger"
    Trigger.Size = UDim2.new(1, 0, 1, 0)
    Trigger.BackgroundColor3 = Color3.fromRGB(12, 22, 14)
    Trigger.Text = " [+] " .. string.upper(name)
    Trigger.TextColor3 = Color3.fromRGB(0, 200, 90)
    Trigger.Font = Enum.Font.Code
    Trigger.TextSize = 13
    Trigger.TextXAlignment = Enum.TextXAlignment.Left
    Trigger.Parent = DropdownFrame

    local TriggerCorner = Instance.new("UICorner")
    TriggerCorner.CornerRadius = UDim.new(0, 3)
    TriggerCorner.Parent = Trigger

    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.Color = Color3.fromRGB(0, 100, 40)
    ButtonStroke.Thickness = 1
    ButtonStroke.Parent = Trigger

    -- Cyber Hover Matrix Actions
    Trigger.MouseEnter:Connect(function()
        TweenService:Create(Trigger, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(16, 36, 20),
            TextColor3 = Color3.fromRGB(0, 255, 150)
        }):Play()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(0, 255, 100)}):Play()
    end)
    Trigger.MouseLeave:Connect(function()
        if activeDropdownContainer and activeDropdownContainer.Name == name .. "Container" then return end
        TweenService:Create(Trigger, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(12, 22, 14),
            TextColor3 = Color3.fromRGB(0, 200, 90)
        }):Play()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(0, 100, 40)}):Play()
    end)

    -- Display Grid panel output for item injection
    local Container = Instance.new("ScrollingFrame")
    Container.Name = name .. "Container"
    Container.Size = UDim2.new(1, 0, 1, 0)
    Container.BackgroundTransparency = 1
    Container.BorderSizePixel = 0
    Container.Visible = false
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.ScrollBarThickness = 4
    Container.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 100)
    Container.Parent = DisplayCanvas

    local ContainerList = Instance.new("UIListLayout")
    ContainerList.Padding = UDim.new(0, 8)
    ContainerList.SortOrder = Enum.SortOrder.LayoutOrder
    ContainerList.Parent = Container

    ContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Container.CanvasSize = UDim2.new(0, 0, 0, ContainerList.AbsoluteContentSize.Y)
    end)

    Trigger.MouseButton1Click:Connect(function()
        -- Handle global tabs changes smoothly without overlap issues
        if activeDropdownContainer and activeDropdownContainer ~= Container then
            activeDropdownContainer.Visible = false
            local oldName = activeDropdownContainer.Name:gsub("Container", "Dropdown")
            local oldDropdown = Sidebar:FindFirstChild(oldName)
            if oldDropdown then
                local oldTrigger = oldDropdown:FindFirstChild("Trigger")
                local oldStroke = oldTrigger and oldTrigger:FindFirstChild("UIStroke")
                if oldTrigger then 
                    oldTrigger.Text = " [+] " .. oldTrigger.Name:gsub("Dropdown", ""):upper()
                    TweenService:Create(oldTrigger, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(12, 22, 14), TextColor3 = Color3.fromRGB(0, 200, 90)}):Play()
                end
                if oldStroke then oldStroke.Color = Color3.fromRGB(0, 100, 40) end
            end
        end

        Container.Visible = not Container.Visible
        if Container.Visible then
            Trigger.Text = " [-] " .. string.upper(name)
            TweenService:Create(Trigger, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(20, 45, 25), TextColor3 = Color3.fromRGB(0, 255, 120)}):Play()
            TweenService:Create(ButtonStroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(0, 255, 120)}):Play()
            activeDropdownContainer = Container
        else
            Trigger.Text = " [+] " .. string.upper(name)
            TweenService:Create(Trigger, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(12, 22, 14), TextColor3 = Color3.fromRGB(0, 200, 90)}):Play()
            TweenService:Create(ButtonStroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(0, 100, 40)}):Play()
            if activeDropdownContainer == Container then activeDropdownContainer = nil end
        end
    end)

    return Container
end

local CheatsContainer = createDropdown("Cheats", 1)
local SettingsContainer = createDropdown("Settings", 2)
local GamesContainer = createDropdown("Games", 3)


-- ==========================================
-- 3. WINDOW INTERACTION CONTROLS
-- ==========================================

-- Seamless Panel Drag Controls
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

-- Window Minimize Execution
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
        MinimizeButton.Text = "[_]"
    end
end)
