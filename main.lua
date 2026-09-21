-- ============================================
-- 1. UTILITY & SERVICES
-- ============================================
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Clean up UI lama jika ada
if player.PlayerGui:FindFirstChild("RynaHubUI") then
    player.PlayerGui.RynaHubUI:Destroy()
end

-- ============================================
-- 2. GUI BASE (Liquid Glass Style)
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RynaHubUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Loading Frame
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 320, 0, 160)
loadingFrame.Position = UDim2.new(0.5, -160, 0.5, -80)
loadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
loadingFrame.BackgroundTransparency = 0.25
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = screenGui

local glassCorner = Instance.new("UICorner")
glassCorner.CornerRadius = UDim.new(0, 16)
glassCorner.Parent = loadingFrame

local glassStroke = Instance.new("UIStroke")
glassStroke.Color = Color3.fromRGB(255, 255, 255)
glassStroke.Transparency = 0.75
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
statusLabel.Position = UDim2.new(0, 0, 0, 65)
statusLabel.Text = "Initializing..."
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 13
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
statusLabel.BackgroundTransparency = 1
statusLabel.Parent = loadingFrame

-- Watermark
local watermark = Instance.new("TextLabel")
watermark.Size = UDim2.new(1, -20, 0, 20)
watermark.Position = UDim2.new(0, 10, 1, -25)
watermark.Text = "Powered by Ryna"
watermark.Font = Enum.Font.GothamMedium
watermark.TextSize = 10
watermark.TextColor3 = Color3.fromRGB(140, 140, 170)
watermark.TextXAlignment = Enum.TextXAlignment.Right
watermark.BackgroundTransparency = 1
watermark.Parent = loadingFrame

-- ============================================
-- 3. KORBLOX & HEADLESS LOGIC
-- ============================================
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

-- ============================================
-- 4. EXECUTION & ANIMATION
-- ============================================
task.spawn(function()
    task.wait(0.5)
    statusLabel.Text = "Applying Korblox & Headless..."
    if player.Character then applyAvatars(player.Character) end
    player.CharacterAdded:Connect(function(char)
        task.wait(1)
        applyAvatars(char)
    end)
    
    task.wait(0.8)
    statusLabel.Text = "Loading Emotes Hub..."
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))()
    
    statusLabel.Text = "Ready!"
    task.wait(0.5)
    
    -- Animasi Fade Out Loading
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(loadingFrame, tweenInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(glassStroke, tweenInfo, {Transparency = 1}):Play()
    TweenService:Create(titleLabel, tweenInfo, {TextTransparency = 1}):Play()
    TweenService:Create(statusLabel, tweenInfo, {TextTransparency = 1}):Play()
    local fadeOut = TweenService:Create(watermark, tweenInfo, {TextTransparency = 1})
    fadeOut:Play()
    
    fadeOut.Completed:Connect(function()
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
