local execStart = tick() -- *starts timer* okay time to write code

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Sitting = false

Player.CharacterAdded:Connect(function(char)
	Character = char
	Humanoid = Character:WaitForChild("Humanoid")
end)

local MobileButtons = PlayerGui:WaitForChild("MobileButtonsLocal")
local JumpButtonFrame = MobileButtons:WaitForChild("JumpButtonFrame") -- This has a separate script that uses Math and the Screen's AbsoluteSize to move it to the jump button.

local SitButton = Instance.new("ImageButton")
	SitButton.Name = "SitButton"
	SitButton.Position = UDim2.new(-1.1, 0, 0, 0) -- This is not offscreen, as its Position is relative to its parent. This should be to the top-left of the jump button.
	SitButton.Size = UDim2.new(1, 0, 1, 0)
	SitButton.BackgroundTransparency = 1
	SitButton.Active = true
	SitButton.Image = "rbxassetid://79989066743509"
	SitButton.Parent = JumpButtonFrame

local function sit()
	if not Sitting then Sitting = true else Sitting = false end
end

while Humanoid and Humanoid.Health > 0 do
	task.wait()

	if Sitting then
		if not Humanoid.Sit then Humanoid.Sit = true end
		SitButton.Image = "rbxassetid://92918494397842"
	else
		if Humanoid.Sit then Humanoid.Sit = false end
		SitButton.Image = "rbxassetid://79989066743509"
	end
end

SitButton.MouseButton1Click:Connect(sit)

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.KeypadOne or input.KeyCode == Enum.KeyCode.ButtonY then
		sit()
	end
end)

local execEnd = tick() -- *stops timer* okay done :3
print("Loaded in " .. tostring(execEnd-execStart) .. ".") -- Basically this should print the amount of time to took to load this
