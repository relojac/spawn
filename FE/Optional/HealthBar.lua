local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService") 
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local PlayerGui = Player.PlayerGui
local Humanoid = Character:WaitForChild("Humanoid")

for _, v in ipairs(PlayerGui:GetChildren()) do
	if v:IsA("ScreenGui") and v.Name == "HealthGuiLocal" then v:Destroy() end
end

local HealthGui = Instance.new("ScreenGui", PlayerGui)
	HealthGui.Name = "HealthGuiLocal"
	HealthGui.ResetOnSpawn = false
	HealthGui.IgnoreGuiInset = true

local Frame = Instance.new("Frame", HealthGui)
	Frame.Name = "HealthFrame"
	Frame.Size = UDim2.new(0, 180, 0, 20)
	Frame.Position = UDim2.new(0.5, 0, 0, 55)
	Frame.AnchorPoint = Vector2.new(0.5, 0)
	Frame.BackgroundColor3 = Color3.fromRGB(69, 69, 69)
	Frame.ClipsDescendants = true

local Bar = Instance.new("Frame", Frame)
	Bar.Name = "HealthBar"
	Bar.Size = UDim2.new(1, 0, 1, 0)
	Bar.Position = UDim2.new(0, 0, 0, 0)
	Bar.BackgroundColor3 = Color3.fromRGB(255, 95, 95)

local HP = Instance.new("TextLabel", Frame)
	HP.Name = "HP"
	HP.Font = Enum.Font.Code
	HP.TextColor3 = Color3.new(1, 1, 1)
	HP.BackgroundTransparency = 1
	HP.Size = UDim2.new(0.5, 0, 1, 0)
	HP.Position = UDim2.new(0, 10, 0, 0)
	HP.TextSize = 13
	HP.TextXAlignment = Enum.TextXAlignment.Left
	HP.ZIndex = 1

local Corner = Instance.new("UICorner", Frame)
	Corner.CornerRadius = UDim.new(2, 0)
local Corner2 = Corner:Clone()
	Corner2.Parent = Bar

local Stroke = Instance.new("UIStroke", Frame)
	Stroke.Color = Color3.fromRGB(69, 69, 69)
	Stroke.Thickness = 3
local Stroke2 = Stroke:Clone()
	Stroke2.Parent = Bar

local ease = TweenInfo.new(
	Humanoid.Health / Humanoid.MaxHealth,
	Enum.EasingStyle.Exponential,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)
local health = math.clamp(Humanoid.Health / Humanoid.MaxHealth, 0, 1) 
local Tween = TweenService:Create(Bar, ease, {Size = UDim2.fromScale(health, 1)})

RunService.Heartbeat:Connect(function()
	HP.Text = tostring(math.round(Character:WaitForChild("Humanoid").Health))
end)

Player.CharacterAdded:Connect(function(char)
	Character = char
	Humanoid = Character:WaitForChild("Humanoid")
	Bar.Size = UDim2.new(1, 0, 1, 0)

	ease  = TweenInfo.new(
		Humanoid.Health / Humanoid.MaxHealth,
		Enum.EasingStyle.Exponential,
		Enum.EasingDirection.Out,
		0,
		false,
		0
	)

	health = math.clamp(Humanoid.Health / Humanoid.MaxHealth, 0, 1)
	Tween = TweenService:Create(Bar, ease, {Size = UDim2.fromScale(health, 1)})
end)


local function updateBar()
	Tween:Play()
end

updateBar()

Humanoid:GetPropertyChangedSignal("Health"):Connect(updateBar)
Humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(updateBar)
Humanoid.Died:Connect(updateBar)
