local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local PlayerGui = Player.PlayerGui
local Humanoid = Character:WaitForChild("Humanoid")

Player.CharacterAdded:Connect(function(char)
	Character = char
	Humanoid = Character:WaitForChild("Humanoid")
end)

local HealthGui = Instance.new("ScreenGui", PlayerGui)
	HealthGui.Name = "HealthGuiLocal"
	HealthGui.ResetOnSpawn = true
	HealthGui.IgnoreGuiInset = true

local Frame = Instance.new("Frame", HealthGui)
	Frame.Name = "HealthFrame"
	Frame.Position = UDim2.new(20, -20, 1, 0)
	Frame.AnchorPoint = Vector2.new(0, 1)
	Frame.BackgroundTransparency = 1
	Frame.ClipsDescendants = true
