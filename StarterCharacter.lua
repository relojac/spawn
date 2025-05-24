local rs = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")

local characters = {
    [4066543490] = "Nick", -- relojac
    [3057358093] = "Matthew", -- Mug
    [2703241450] = "Lilith", -- Galaxy
    
    [1] = "Director", -- n/a
    [2495172515] = "Secretary", -- Raven
    [3233897743] = "Follower" -- Parsee
}
local banned = {
    1060616090, -- Mini
    882427078, -- Franko
    4164721347 -- My alt (For testing)
} 

plrs.CharacterAutoLoads = false
local p = workspace.SpawnPos

plrs.PlayerAdded:Connect(function(plr)
    print(plr.Name)

    local model = characters[plr.UserId]
    if rs:FindFirstChild(model) then
        local charTemplate = rs:FindFirstChild(model)
        if charTemplate then
            local char = charTemplate:Clone()
                char.Name = plr.Name
                char:SetPrimaryPartCFrame(p.CFrame)
                char.Parent = workspace
            plr.Character = char
        else
            warn("??? " .. plr.Name)
        end
    end
    
    for _, id in pairs(banned) do
        if plr.UserId == id then
                warn("BAD PERSON")
                plr:Kick([[ Hi!

		    Looks like you've been banned from this game.
		    Why? It's probably some history between you and our group.
                    In that case, please don't try to join again. You aren't getting unbanned. Ever.
					
                    You're a terrible person, you know that, right? ]])
        end

	plr:LoadCharacter()
    end
end)
