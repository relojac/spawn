local execStart = tick() -- *starts timer* okay time to write code

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

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
	SitButton.Image = "rbxassetid://120316668670756"
	SitButton.Parent = JumpButtonFrame

local function sit()
	if not Humanoid.Sit then Humanoid.Sit = true else Humanoid.Sit = false end
end

RunService.Heartbeat:Connect(function()
	if Humanoid.Sit then
		SitButton.Image = "rbxassetid://125086742998263"
	else
		SitButton.Image = "rbxassetid://120316668670756"
	end
end)

SitButton.MouseButton1Click:Connect(sit)

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.KeypadOne or input.KeyCode == Enum.KeyCode.ButtonY then
		sit()
	end
end)

local execEnd = tick() -- *stops timer* okay done :3
print("Loaded in " .. tostring(execEnd-execStart) .. ".") -- Basically this should print the amount of time to took t o load this
