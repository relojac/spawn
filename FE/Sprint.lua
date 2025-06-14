local execStart = tick()

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

repeat task.wait() until Players.LocalPlayer.Character

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local Character = Player.Character
local Humanoid = Character:WaitForChild("Humanoid")
local BaseWalkSpeed = 16
local ResWalkSpeed = 16
local Camera = workspace:WaitForChild("CurrentCamera")
local BaseFOV = Camera.FieldOfView
local FovMultiplier = 1.3

Player.CharacterAdded:Connect(function(char)
	Character = char
	Humanoid = Character:FindFirstChildOfClass("Humanoid")
	ResWalkSpeed = Humanoid.WalkSpeed

	BaseWalkSpeed = ResWalkSpeed
end)

repeat task.wait() until PlayerGui.MobileButtons

local MobileButtons = PlayerGui:FindFirstChild("MobileButtonsLocal", true)
local JumpButtonFrame = MobileButtons:WaitForChild("JumpButtonFrame")

local SprintButton = Instance.new("ImageButton", JumpButtonFrame)
	SprintButton.Name = "SprintButton"
	SprintButton.Position = UDim2.new(-1.1, 0, -1.1, 0)
	SprintButton.Size = UDim2.new(1, 0, 1, 0)
	SprintButton.BackgroundTransparency = 1
	SprintButton.Active = true
	SprintButton.Image = "rbxassetid://118709768438655"
	SprintButton.PressedImage = "rbxassetid://111778431619800"

local function startS()
	TweenService:Create(Humanoid, Sine_InOut, { WalkSpeed = BaseWalkSpeed + (BaseWalkSpeed/2) }):Play()
	TweenService:Create(Camera, Sine_InOut, { FieldOfView = math.round(BaseFOV*FovMultiplier) }):Play()
end
local function endS()
	TweenService:Create(Humanoid, Expo_Out, { WalkSpeed = BaseWalkSpeed }):Play()
	TweenService:Create(Camera, Expo_Out, { FieldOfView = BaseFOV }):Play()
end

SprintButton.MouseButton1Down:Connect(startS)
SprintButton.MouseButton1Up:Connect(endS)

UserInputService.InputBegan:Connect(function(KeyCode)
	if KeyCode == Enum.KeyCode.LeftShift or KeyCode == Enum.KeyCode.ButtonX then
		startS()
	end
end)
UserInputService.InputEnded:Connect(function(KeyCode)
	if KeyCode == Enum.KeyCode.LeftShift or KeyCode == Enum.KeyCode.ButtonX then
		endS()
	end
end)

local execEnd = tick()
print("Loaded " .. SprintButton .. " in " .. execEnd-execStart .. ".")

local gamepad = {
	ButtonX = "ATTEMPT TO   HOLD [X]   ON YOUR  GAMEPAD", 
	ButtonSquare = "ATTEMPT TO   HOLD [SQUARE]   ON YOUR  GAMEPAD",
}
local keyboard = "ATTEMPT TO   HOLD [LEFTSHIFT]   ON YOUR  KEYBOARD"
local mobile = "ATTEMPT TO   HOLD THE RUN BUTTON   ON YOUR  SCREEN"

local inputType = UserInputService:GetLastInputType()
local contents = keyboard
if inputType == Enum.UserInputType.Touch then
	contents = mobile
elseif inputType == Enum.UserInputType.Focus then
	contents = keyboard
elseif inputType == Enum.UserInputType.Gamepad1 then
	contents = gamepad[UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonX)]
else
	warn("what are you on vro 💔")
end
	

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "HELLO   USER.",
	Text = contents,
	Duration = 10
})
