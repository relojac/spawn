local Players = game:GetService("Players")

local RespawnTime = Players.RespawnTime
Players:GetPropertyChangedSignal("RespawnTime"):Connect(function()
	RespawnTime = Players.RespawnTime
end)

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local PlayerGui = Player:WaitForChild("PlayerGui")
local Humanoid = Character:WaitForChild("Humanoid")

local DeathGui = Instance.new("DeathGui", PlayerGui)
	DeathGui.Name = "DeathGui"
	DeathGui.ResetOnSpawn = false
	DeathGui.IgnoreGuiInset = true

local DeathFrame = Instance.new("Frame", DeathGui)
	DeathFrame.Name = "DeathFrame")
	DeathFrame.BackgroundTransparency = 1
	DeathFrame.Size = UDim2.new(1, 0, 1, 0)

local FailText = Instance.new("TextLabel", DeathFrame)
	FailText.Name = "FailText"
	FailText.Text = "You have failed the test"
	FailText.Font = Enum.Font.Merriweather
	FailText.AnchorPoint = Vector2.new(0.5, 0.5)
	FailText.Position = UDim2.new(0, 0, 0, -5)
	FailText.Size = UDim2.new(0.33, 0, 0.1, 0)
	FailText.BackgroundTransparency = 1
	FailText.TextColor3 = Color3.fromRGB(255, 140, 140)

local Countdown = Instance.new("TextLabel", DeathFrame)
	Countdown.Name = "Countdown"
	Countdown.Text = "5"
	Countdown.Font = Enum.Font.Merriweather
	Countdown.AnchorPoint = Vector2.new(0.5, 0.5)
	Countdown.Position = UDim2.new(0, 0, 0, 5)
	Countdown.Size = UDim2.new(0.33, 0, 0.1, 0)
