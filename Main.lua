-- Core Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FusionLabs_Menu"
ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Main rounded container window from reference layout
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 560, 0, 360)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22) -- Slate dark background
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Top Title Area (Updated to just "Fusion Labs")
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(0, 200, 0, 40)
TitleLabel.Position = UDim2.new(0, 16, 0, 8)
TitleLabel.Text = "Fusion Labs"
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 127) -- Brilliant Asgardian Green Accent
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.BackgroundTransparency = 1
TitleLabel.Parent = MainFrame

-- Sidebar layout column for tab navigation
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

-- Navigation button factory
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

-- Generating our master tabs
local UniversalButton = BuildMenuTab("Universal", 1)
local ESPButton       = BuildMenuTab("ESP", 2)
local SettingsButton  = BuildMenuTab("Settings", 3)
