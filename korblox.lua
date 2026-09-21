local Players = game:GetService("Players")
local player = Players.LocalPlayer

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

if player.Character then applyAvatars(player.Character) end
player.CharacterAdded:Connect(function(char)
    task.wait(1)
    applyAvatars(char)
end)
