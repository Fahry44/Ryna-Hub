local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Clean UI Lama
if player.PlayerGui:FindFirstChild("RynaHubUI") then
    player.PlayerGui.RynaHubUI:Destroy()
end

-- ============================================
-- GUI BASE (Liquid Glass Style)
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RynaHubUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 240)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -120)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BackgroundTransparency = 0.25
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 255, 255)
mainStroke.Transparency = 0.75
mainStroke.Thickness = 1.5
mainStroke.Parent = mainFrame

local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.new(1, -20, 0, 40)
mainTitle.Position = UDim2.new(0, 15, 0, 10)
mainTitle.Text = "RYNA HUB"
mainTitle.Font = Enum.Font.GothamBold
mainTitle.TextSize = 20
mainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainTitle.TextXAlignment = Enum.TextXAlignment.Left
mainTitle.BackgroundTransparency = 1
mainTitle.Parent = mainFrame

local mainWatermark = Instance.new("TextLabel")
mainWatermark.Size = UDim2.new(0, 100, 0, 20)
mainWatermark.Position = UDim2.new(1, -115, 0, 20)
mainWatermark.Text = "Powered by Ryna"
mainWatermark.Font = Enum.Font.GothamMedium
mainWatermark.TextSize = 10
mainWatermark.TextColor3 = Color3.fromRGB(140, 140, 170)
mainWatermark.TextXAlignment = Enum.TextXAlignment.Right
mainWatermark.BackgroundTransparency = 1
mainWatermark.Parent = mainFrame

local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(1, -30, 1, -70)
buttonContainer.Position = UDim2.new(0, 15, 0, 55)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = mainFrame

local uilist = Instance.new("UIListLayout")
uilist.SortOrder = Enum.SortOrder.LayoutOrder
uilist.Padding = UDim.new(0, 10)
uilist.Parent = buttonContainer

local function createGlassButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundTransparency = 0.9
    btn.Text = text
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(240, 240, 255)
    btn.AutoButtonColor = false
    btn.Parent = buttonContainer

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(255, 255, 255)
    btnStroke.Transparency = 0.85
    btnStroke.Thickness = 1
    btnStroke.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.5}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.9}):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.85}):Play()
    end)

    btn.MouseButton1Click:Connect(callback)
end

-- LOADING FRAME
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

-- Tombol UI
createGlassButton("Load Korblox & Headless", function()
    task.spawn(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Fahry44/Ryna-Hub/refs/heads/main/korblox.lua"))()
    end)
end)

createGlassButton("Open Emotes Hub", function()
    task.spawn(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))()
    end)
end)

-- LOGIC UTAMA
task.spawn(function()
    task.wait(0.5)
    statusLabel.Text = "Loading Korblox Script..."
    task.spawn(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Fahry44/Ryna-Hub/refs/heads/main/korblox.lua"))()
    end)
    
    task.wait(0.8)
    statusLabel.Text = "Loading Emotes Script..."
    task.spawn(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))()
    end)
    
    statusLabel.Text = "Ready!"
    task.wait(0.5)
    
    -- Fade Out Loading Screen
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(loadingFrame, tweenInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(glassStroke, tweenInfo, {Transparency = 1}):Play()
    TweenService:Create(titleLabel, tweenInfo, {TextTransparency = 1}):Play()
    TweenService:Create(statusLabel, tweenInfo, {TextTransparency = 1}):Play()
    local fadeOut = TweenService:Create(watermark, tweenInfo, {TextTransparency = 1})
    fadeOut:Play()
    
    fadeOut.Completed:Connect(function()
        loadingFrame:Destroy()
        mainFrame.Visible = true
    end)
end)

-- Toggle Shortcut (Tombol "`")
local TOGGLE_KEY = Enum.KeyCode.Backquote
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == TOGGLE_KEY then
        mainFrame.Visible = not mainFrame.Visible
    end
end)
