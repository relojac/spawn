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

local SuicideButton = Instance.new("ImageButton")
	SuicideButton.Name = "SuicideButton"
	SuicideButton.Position = UDim2.new(-2.2, 0, -1.1, 0) -- This is not offscreen, as its Position is relative to its parent. This should be to the top-left of the jump button.
	SuicideButton.Size = UDim2.new(1, 0, 1, 0)
	SuicideButton.BackgroundTransparency = 1
	SuicideButton.Active = true
	SuicideButton.Image = "rbxassetid://126419275995568"
	SuicideButton.PressedImage = "rbxassetid://105161719865735"
	SuicideButton.Parent = JumpButtonFrame

local function suicide()
	Humanoid.Health = -2147483648
end

SuicideButton.MouseButton1Click:Connect(suicide)

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.KeypadThree or input.KeyCode == Enum.KeyCode.ButtonL2 then
		suicide()
	end
end)

local execEnd = tick() -- *stops timer* okay done :3
print("Loaded in " .. tostring(execEnd-execStart) .. ".")
