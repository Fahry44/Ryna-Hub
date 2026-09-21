-- ============================================
-- FITUR HEADLESS & KORBLOX WORKING
-- ============================================
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local HEADLESS_MESH_ID = "rbxassetid://1095708"

-- 1. Jalankan Korblox Script (Terbukti Bekerja)
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/gerka842-afk/KorbloxVisualRight/refs/heads/main/KorbloxVisualRight'))()
    end)
end)

-- 2. Logika Headless
local function applyHeadless(character)
    if not character then return end
    local head = character:FindFirstChild("Head")
    if head then
        head.Transparency = 1
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
end

if player.Character then applyHeadless(player.Character) end
player.CharacterAdded:Connect(function(char)
    task.wait(1)
    applyHeadless(char)
end)
