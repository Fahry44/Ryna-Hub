-- Execute Script Korblox Luar
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/gerka842-afk/KorbloxVisualRight/refs/heads/main/KorbloxVisualRight'))()
    end)
end)

-- Sembunyikan UI Bawaan Script Luar Otomatis
task.spawn(function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local pgui = player:WaitForChild("PlayerGui")
    
    -- Cari dan hapus/sembunyikan UI eksternal
    local function hideExternalUI()
        for _, gui in ipairs(pgui:GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Name ~= "RynaHubUI" then
                gui.Enabled = false
            end
        end
    end

    task.wait(1)
    hideExternalUI()
    
    pgui.ChildAdded:Connect(function(child)
        if child:IsA("ScreenGui") and child.Name ~= "RynaHubUI" then
            task.wait(0.1)
            child.Enabled = false
        end
    end)
end)
