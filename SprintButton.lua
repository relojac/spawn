local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer

local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")

local sine = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local expo = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local cam = workspace:WaitForChild("Camera") 
local frame = script.Parent.Parent

local function startSprint()
	local hum = plr.Character:WaitForChild("Humanoid")
	
	ts:Create(hum, sine, { WalkSpeed = 24 }):Play()
	ts:Create(cam, sine, { FieldOfView = 90 }):Play()  
end

local function endSprint()
	local hum = plr.Character:WaitForChild("Humanoid")
	
	ts:Create(hum, sine, { WalkSpeed = 16 }):Play()
	ts:Create(cam, expo, { FieldOfView = 70 }):Play()  
end

button.MouseButton1Down:Connect(function()
	startSprint()
end)

button.MouseButton1Up:Connect(function()
	endSprint()
end)

uis.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.LeftShift then
		startSprint()
	end
end)

uis.InputEnded:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.LeftShift then
		endSprint()
	end
end)
