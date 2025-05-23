local rs = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")

local characters = {
    [4066543490] = "Nick", -- relojac
    [3057358093] = "Matthew", -- Mug
    [2703241450] = "Lilith", -- Galaxy
    
    [0] = "Director", -- n/a
    [2495172515] = "Secretary", -- Raven
    [0] = "Follower" -- n/a
}

local spawnpos = CFrame.new(0, 10, 0)

plrs.CharacterAutoLoads = false

plrs.PlayerAdded:Connect(function(plr)
    print(plr.Name)

    local model = characters[plr.UserId]
    if rs:FindFirstChild(model) then
        local charTemplate = rs:FindFirstChild(model)
        if charTemplate then
            local char = charTemplate:Clone()
                char.Name = plr.Name
                char:SetPrimaryPartCFrame(spawnpos)
                char.Parent = workspace
            plr.Character = char
        else
            warn("??? " .. plr.Name)
        end
    end
    plr:LoadCharacter()
    
    if plr.Name == "87mq" or plr.Name == "Rylando11" or plr.Name == "relojalt" then
        plr:Kick("HELLO :)")
    end
end)
