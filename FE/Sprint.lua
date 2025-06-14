local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Sine_InOut = TweenInfo.new(
	0.75,
	Enum.EasingType.Sine,
	Enum.EasingDirection.InOut
)

local Expo_Out = TweenInfo.new(
	1,
	Enum.EasingType.Exponential,
	Enum.EasingDirection.Out
)

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local Character = Player.Character or nil
local Humanoid = Character:FindFirstChildOfClass("Humanoid") or nil
local BaseWalkSpeed = 16
local ResWalkSpeed = 16
local Camera = workspace.CurrentCamera

Player.CharacterAdded:Connect(function(char)
	if (not Character) and (char) then
		Character = char
		Humanoid = Character:WaitForChild("Humanoid")
		ResWalkSpeed = Humanoid.WalkSpeed

		if BaseWalkSpeed ~= ResWalkSpeed then BaseWalkSpeed = Humanoid.WalkSpeed end
	end
end)

repeat task.wait() until PlayerGui.MobileButtons

local MobileButtons = PlayerGui:FindFirstChild("MobileButtonsLocal", true)
local JumpButtonFrame = MobileButtons:FindFirstChild("JumpButtonFrame")

local SprintButton = Instance.new("ImageButton", JumpButtonFrame)
	SprintButton.Name = "SprintButton"
	SprintButton.Position = UDim2.new(-1.1, 0, -1.1, 0)
	SprintButton.Size = UDim2.new(1, 0, 1, 0)
	SprintButton.BackgroundTransparency = 1
	SprintButton.Active = false
	SprintButton.Image = "rbxassetid://118709768438655"
	SprintButton.PressedImage = "rbxassetid://111778431619800"

local function startS()
	TweenService:Create(Humanoid, Sine_InOut, { WalkSpeed += (Humanoid.WalkSpeed/2) }):Play()
	TweenService:Create(Camera, Sine_InOut, { FieldOfView = math.round(Camera.FieldOfView*1.28571428571) }):Play()
end
local function endS()
	TweenService:Create(Humanoid, Expo_Out, { WalkSpeed += (WalkSpeed/2) }):Play()
	TweenService:Create(Camera, Expo_Out, { FieldOfView = math.round(Camera.FieldOfView/1.28571428571) }):Play()
end

SprintButton.MouseButton1Down:Connect(startS)
SprintButton.MouseButton1Up:Connect(endS)

UserInputService.InputBegan:Connect(function(KeyCode)
	if KeyCode == Enum.KeyCode.LeftShift or KeyCode == Enum.KeyCode.ButtonL2 then
		startS()
	end
end)
UserInputService.InputEnded:Connect(function(KeyCode)
	if KeyCode == Enum.KeyCode.LeftShift or KeyCode == Enum.KeyCode.ButtonL2 then
		endS()
	end
end)
