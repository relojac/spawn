local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

for _, v in Character:GetChildren() do
	if not v:IsA("BasePart") or v.Name == "Torso" then
		continue
	end
	v:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
		v.LocalTransparencyModifier = 0
	end)
	
	v.LocalTransparencyModifier = 0
end

Character.ChildAdded:Connect(function(v)
	if not v:IsA("BasePart") or v.Name == "Torso" then
		return
	end
	v:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
		v.LocalTransparencyModifier = 0
	end)

	v.LocalTransparencyModifier = 0
end)
