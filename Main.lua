-- LocalPlayer reference
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Connect(function(newChar)
    character = newChar
end)

-- Fly Cheat
local flySpeed = 50 -- Default speed
local isFlying = false

function startFly()
    local humanoidRootPart = character.HumanoidRootPart
    if not humanoidRootPart then return end
    
    local bg = Instance.new("BodyGyro", humanoidRootPart)
    local bv = Instance.new("BodyVelocity", humanoidRootPart)
    
    bg.P = 9e4
    bg.D = 100
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    
    bv.Velocity = Vector3.new()
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    
    local userInputService = game:GetService("UserInputService")
    
    userInputService.InputBegan:Connect(function(inputObject, gameProcessedEvent)
        if inputObject.KeyCode == Enum.KeyCode.Space and not gameProcessedEvent then
            bv.Velocity = Vector3.new(0, flySpeed, 0)
        end
    end)
end

function stopFly()
    local humanoidRootPart = character.HumanoidRootPart
    if not humanoidRootPart then return end
    
    for _, child in pairs(humanoidRootPart:GetChildren()) do
        if child:IsA("BodyGyro") or child:IsA("BodyVelocity") then
            child:Destroy()
        end
    end
end

-- Speed Cheat
local moveSpeed = 16 -- Default speed
local isSpeedBoosted = false

function startSpeedBoost()
    character.Humanoid.WalkSpeed = moveSpeed
    isSpeedBoosted = true
end

function stopSpeedBoost()
    character.Humanoid.WalkSpeed = 16
    isSpeedBoosted = false
end

-- Invisibility (with teleportation trick)
local function enableInvisibility()
    local cam = workspace.CurrentCamera
    local invisiblePosition = Vector3.new(0, -500, 0) -- Position under the map
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") and not part.Name == "HumanoidRootPart" then
            part.Material = Enum.Material.ForceField
            part.Color3 = Color3.new(0, 0, 0)
        end
    end
    
    character:MoveTo(invisiblePosition)
    
    cam.CFrame = CFrame.new(character.HumanoidRootPart.Position + Vector3.new(0, 500, 0))
end

local function disableInvisibility()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") and not part.Name == "HumanoidRootPart" then
            part.Material = Enum.Material.Neon
            part.Color3 = Color3.new(1, 0, 0)
        end
    end
    
    local visiblePosition = Vector3.new(character.HumanoidRootPart.Position.X, 50, character.HumanoidRootPart.Position.Z)
    
    character:MoveTo(visiblePosition)
end

-- Bind GUI elements to functions
local gui = script.Parent -- Assuming the script is a LocalScript parented to the ScreenGui or Frame containing the buttons

if not gui then
    warn("GUI not found. Ensure this LocalScript is parented to your ScreenGui or Frame.")
    return
end

local flyButton = gui.UniversalTab.FlyButton
flyButton.MouseButton1Click:Connect(function()
    if not isFlying then
        startFly()
        isFlying = true
        flyButton.Text = "Stop Fly"
    else
        stopFly()
        isFlying = false
        flyButton.Text = "Start Fly"
    end
end)

local speedBoostButton = gui.UniversalTab.SpeedBoostButton
speedBoostButton.MouseButton1Click:Connect(function()
    if not isSpeedBoosted then
        startSpeedBoost()
        isSpeedBoosted = true
        speedBoostButton.Text = "Stop Speed Boost"
    else
        stopSpeedBoost()
        isSpeedBoosted = false
        speedBoostButton.Text = "Start Speed Boost"
    end
end)

local invisibilityButton = gui.UniversalTab.InvisibilityButton
invisibilityButton.MouseButton1Click:Connect(function()
    enableInvisibility()
    invisibilityButton.Text = "Visible"
    wait(5) -- Temporarily disable for 5 seconds to prevent spamming
    invisibilityButton.Text = "Invisible"
end)

-- Hotkey Configuration
local userInputService = game:GetService("UserInputService")

local function setHotkey(keyCode, action)
    userInputService.InputBegan:Connect(function(inputObject, gameProcessedEvent)
        if inputObject.KeyCode == keyCode and not gameProcessedEvent then
            action()
        end
    end)
end

-- Example hotkeys (you can configure these in the GUI)
setHotkey(Enum.KeyCode.F, startFly) -- Fly Cheat
setHotkey(Enum.KeyCode.G, enableInvisibility) -- Invisibility Cheat

-- Placeholder for future ESP features
local function setupESP()
    print("ESP Setup")
end

setupESP()
