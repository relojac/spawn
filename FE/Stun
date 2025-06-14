local execStart = tick() -- *starts timer* okay time to write code

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Stunned = false

Player.CharacterAdded:Connect(function(char)
	Character = char
	Humanoid = Character:WaitForChild("Humanoid")
end)

local MobileButtons = PlayerGui:WaitForChild("MobileButtonsLocal")
local JumpButtonFrame = MobileButtons:WaitForChild("JumpButtonFrame") -- This has a separate script that uses Math and the Screen's AbsoluteSize to move it to the jump button.

local StunButton = Instance.new("ImageButton")
	StunButton.Name = "StunButton"
	StunButton.Position = UDim2.new(-1.1, 0, 0, 0) -- This is not offscreen, as its Position is relative to its parent. This should be to the top-left of the jump button.
	StunButton.Size = UDim2.new(1, 0, 1, 0)
	StunButton.BackgroundTransparency = 1
	StunButton.Active = true
	StunButton.Image = "rbxassetid://120316668670756"
	StunButton.Parent = JumpButtonFrame

local Stun = Instance.new("TextLabel")
  Stun.Name = "Text" 
  Stun.Size = UDim2.new(1, 0, 1, 0)
  Stun.Text = "Stun"
  Stun.BackgroundTransparency = 1
  Stun.TextSize = 15
  Stun.TextColor3 = Color3.new(1, 1, 1)
  Stun.TextStrokeColor3 = Color3.new(0, 0, 0)
  Stun.TextStrokeTransparency = 0
  Stun.ZIndex = 1
  Stun.Parent = StunButton

local function stun()
	if not Stunned then Stunned = true else Stunned = false end
end

while Humanoid and Humanoid.Health > 0 do
	task.wait()

	if Stunned then
		Humanoid.Stun = true
		StunButton.Image = "rbxassetid://125086742998263"
	else
		Humanoid.PlatformStand = false
		StunButton.Image = "rbxassetid://120316668670756
	end
end

StunButton.MouseButton1Click:Connect(stun)

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.KeypadOne or input.KeyCode == Enum.KeyCode.ButtonY then
		stun()
	end
end)

local execEnd = tick() -- *stops timer* okay done :3
print("Loaded in " .. tostring(execEnd-execStart) .. ".") -- Basically this should print the amount of time to took t o load this
