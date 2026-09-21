-- ============================================
-- 1. UTILITY & SERVICES
-- ============================================
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ============================================
-- 2. LOADING SCREEN (Liquid Glass Theme)
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RynaHubUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 300, 0, 150)
loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
loadingFrame.BackgroundTransparency = 0.25
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = screenGui

local glassCorner = Instance.new("UICorner")
glassCorner.CornerRadius = UDim.new(0, 16)
glassCorner.Parent = loadingFrame

local glassStroke = Instance.new("UIStroke")
glassStroke.Color = Color3.fromRGB(255, 255, 255)
glassStroke.Transparency = 0.7
glassStroke.Thickness = 1.5
glassStroke.Parent = loadingFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 20)
titleLabel.Text = "RYNA HUB"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 22
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = loadingFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0, 60)
statusLabel.Text = "Loading Assets..."
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 13
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
statusLabel.BackgroundTransparency = 1
statusLabel.Parent = loadingFrame

-- Watermark Ryna
local watermark = Instance.new("TextLabel")
watermark.Size = UDim2.new(1, -20, 0, 20)
watermark.Position = UDim2.new(0, 10, 1, -25)
watermark.Text = "Powered by Ryna"
watermark.Font = Enum.Font.GothamMedium
watermark.TextSize = 10
watermark.TextColor3 = Color3.fromRGB(150, 150, 180)
watermark.TextXAlignment = Enum.TextXAlignment.Right
watermark.BackgroundTransparency = 1
watermark.Parent = loadingFrame

-- ============================================
-- 3. MAIN LOGIC & SHORTCUT
-- ============================================
-- Panggil fitur Korblox & Headless
local HEADLESS_MESH_ID = "rbxassetid://1095708"
local KORBLOX_MESH_ID = "rbxassetid://101851696"
local KORBLOX_TEXTURE_ID = "rbxassetid://101851254"

local function applyAvatars(character)
    if not character then return end
    
    -- Headless
    local head = character:FindFirstChild("Head")
    if head then
        head.Transparency = 1
        head.CanCollide = false
        local face = head:FindFirstChildOfClass("Decal")
        if face then face:Destroy() end
        for _, v in ipairs(head:GetChildren()) do
            if v:IsA("SpecialMesh") or v:IsA("CharacterMesh") then v:Destroy() end
        end
        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.FileMesh
        mesh.MeshId = HEADLESS_MESH_ID
        mesh.Scale = Vector3.new(0.001, 0.001, 0.001)
        mesh.Parent = head
    end

    -- Korblox
    local rightLeg = character:FindFirstChild("Right Leg")
    if rightLeg then
        for _, v in ipairs(rightLeg:GetChildren()) do
            if v:IsA("SpecialMesh") or v:IsA("CharacterMesh") then v:Destroy() end
        end
        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.FileMesh
        mesh.MeshId = KORBLOX_MESH_ID
        mesh.TextureId = KORBLOX_TEXTURE_ID
        mesh.Scale = Vector3.new(1, 1, 1)
        mesh.Parent = rightLeg
    end
end

-- Simulasi Loading halus
task.spawn(function()
    task.wait(1)
    statusLabel.Text = "Applying Korblox & Headless..."
    if player.Character then applyAvatars(player.Character) end
    player.CharacterAdded:Connect(function(char)
        task.wait(1)
        applyAvatars(char)
    end)
    
    task.wait(1)
    statusLabel.Text = "Loading Emotes Hub..."
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))()[cite: 5]
    
    statusLabel.Text = "Ready!"
    task.wait(0.5)
    
    -- Animasi Fade Out
    local tween = TweenService:Create(loadingFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1})
    TweenService:Create(glassStroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
    TweenService:Create(titleLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(statusLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(watermark, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    tween:Play()
    
    tween.Completed:Connect(function()
        loadingFrame.Visible = false
    end)
end)

-- Toggle Shortcut Keybind (Default: Backquote "`")
local TOGGLE_KEY = Enum.KeyCode.Backquote
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == TOGGLE_KEY then
        screenGui.Enabled = not screenGui.Enabled
    end
end)
