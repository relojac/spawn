local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService") 
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
	Frame.Size = UDim2.new(0, 130, 0, 20)
	Frame.Position = UDim2.new(0, 25, 1, -25)
	Frame.AnchorPoint = Vector2.new(0, 1)
	Frame.BackgroundTransparency = 1
	Frame.ClipsDescendants = true

local Bar = Instance.new("Frame", Frame)
	Bar.Name = "HealthBar"
	Bar.Size = UDim2.new(1, 0, 1, 0)
	Bar.Position = UDim2.new(0, 0, 0, 0)
	Bar.BackgroundColor3 = Color3.new(1, 0, 0)
	Bar.BorderSizePixel = 0

local HP = Instance.new("TextLabel", Frame)
	HP.Name = "HP"
	HP.Font = Enum.Font.Code
	HP.TextColor3 = Color3.new(1, 1, 1)
	HP.BackgroundTransparency = 1
	HP.Size = UDim2.new(0.5, 0, 1, 0)
	HP.Position = UDim2.new(0, 5, 0, 0)
	HP.TextSize = 8
	HP.TextXAlignment = Enum.TextXAlignment.Left
	HP.ZIndex = 1

local Corner = Instance.new("UICorner", Frame)
	Corner.CornerRadius = UDim.new(2, 0)
local Corner2 = Instance.new("UICorner", Bar)
	Corner.CornerRadius = UDim.new(2, 0)

RunService.Heartbeat:Connect(function()
	HP.Text = tostring(math.round(Humanoid.Health))
end)


local function updateBar()
	local health = math.clamp(Humanoid.Health / Humanoid.MaxHealth, -2147483648, 1)
	local ease = TweenInfo.new(
		Humanoid.Health / Humanoid.MaxHealth,
		Enum.EasingStyle.Exponential,
		Enum.EasingDirection.Out,
		0,
		false,
		0
	)
	
	TweenService:Create(Bar, ease, {Size = UDim2.fromScale(health, 1)}):Play()
end

updateBar()

Humanoid:GetPropertyChangedSignal("Health"):Connect(updateBar)
Humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(updateBar)
