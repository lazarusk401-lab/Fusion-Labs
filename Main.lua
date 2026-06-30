local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- HARD PURGE: Wipes out every possible cached iteration of the old UI
for _, child in pairs(PlayerGui:GetChildren()) do
    if child.Name == "FusionLabsUI" or child:FindFirstChild("MainFrame") then
        child:Destroy()
    end
end

-- ==========================================
-- 1. CRIMSON TERMINAL EXECUTOR CODE BRICK
-- ==========================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FusionLabsUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Master Console Window
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 580, 0, 380)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 8, 8) -- Matte Off-Black
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 4) -- Sharp, industrial edge
MainCorner.Parent = MainFrame

-- Neon Crimson Laser Accent Border
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 35, 60) -- Acid Red Glow
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Drag TopBar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 38)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 12, 12) -- Dark Blood Red Tint
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopLine = Instance.new("Frame")
TopLine.Size = UDim2.new(1, 0, 0, 1)
TopLine.Position = UDim2.new(0, 0, 1, -1)
TopLine.BackgroundColor3 = Color3.fromRGB(160, 20, 35)
TopLine.BorderSizePixel = 0
TopLine.Parent = TopBar

-- Console Title Header
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 350, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SYSTEM://FUSION_LABS.BAT [CONSOLE ROOT]"
Title.TextColor3 = Color3.fromRGB(255, 60, 80)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.Code
Title.TextSize = 13
Title.Parent = TopBar

-- Console Exit/Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 40, 0, 38)
MinimizeButton.Position = UDim2.new(1, -40, 0, 0)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "[X]"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 60, 80)
MinimizeButton.Font = Enum.Font.Code
MinimizeButton.TextSize = 13
MinimizeButton.Parent = TopBar

-- RIGID SIDEBAR (Locked Boundary Layout)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 140, 1, -38)
Sidebar.Position = UDim2.new(0, 0, 0, 38)
Sidebar.BackgroundColor3 = Color3.fromRGB(14, 10, 10)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarLine = Instance.new("Frame")
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(1, -1, 0, 0)
SidebarLine.BackgroundColor3 = Color3.fromRGB(90, 20, 30)
SidebarLine.BorderSizePixel = 0
SidebarLine.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.Padding = UDim.new(0, 6)
SidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 10)
SidebarPadding.Parent = Sidebar

-- Internal Center Display Panel Canvas
local DisplayCanvas = Instance.new("Frame")
DisplayCanvas.Name = "DisplayCanvas"
DisplayCanvas.Size = UDim2.new(1, -155, 1, -50)
DisplayCanvas.Position = UDim2.new(0, 148, 0, 44)
DisplayCanvas.BackgroundTransparency = 1
DisplayCanvas.Parent = MainFrame


-- ==========================================
-- 2. ENCAPSULATED DROPDOWN SYSTEM
-- ==========================================

local activeDropdownContainer = nil

local function createDropdown(name, layoutOrder)
    -- This structural frame is explicitly mapped INSIDE the sidebar bounds
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Name = name .. "Dropdown"
    DropdownFrame.Size = UDim2.new(0, 124, 0, 32)
    DropdownFrame.BackgroundTransparency = 1
    DropdownFrame.LayoutOrder = layoutOrder
