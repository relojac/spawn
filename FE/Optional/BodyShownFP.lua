local Player = game:GetService("Players").LocalPlayer

for _, v in Player.Character:GetChildren() do
	if not v:IsA("BasePart") then
		continue
	end
	v:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
		v.LocalTransparencyModifier = 0
	end)
	
	v.LocalTransparencyModifier = 0
end

Player.Character.ChildAdded:Connect(function(v)
	if not v:IsA("BasePart") then
		return
	end
	v:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
		v.LocalTransparencyModifier = 0
	end)

	v.LocalTransparencyModifier = 0
end)
