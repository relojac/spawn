local execStart = tick() -- *starts timer* okay time to write code

local Global = (getgenv and getgenv()) or shared
local Config = Global.SpawnUtilsConfig or {}

local SprintConfig = Config.Sprint
local Mults = SprintConfig.Multipliers
local Easing = SprintConfig.Easing
local Toggle = SprintConfig.ButtonToggleable

local EaseIn = Easing.In
local EaseOut = Easing.Out

local TimeIn = EaseIn.Time or 0.75
local StyleIn = EaseIn.Style or Enum.EasingStyle.Sine
local DirectionIn = EaseIn.Direction or Enum.EasingDirection.InOut
--
local TimeOut = EaseOut.Time or 1
local StyleOut = EaseOut.Style or Enum.EasingStyle.Exponential
local DirectionOut = EaseOut.Direction or Enum.EasingDirection.Out

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Sine_InOut = TweenInfo.new(
	TimeIn,
	StyleIn,
	DirectionIn
)

local Expo_Out = TweenInfo.new(
	TimeOut,
	StyleOut,
	DirectionOut
)

local Sprinting = false
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local BaseWalkSpeed = 16
local ResWalkSpeed = 16 -- WalkSpeed on respawn. Should be the same as BaseWalkSpeed.
local Camera = workspace.CurrentCamera or workspace:WaitForChild("Camera")
local BaseFOV = Camera.FieldOfView
local WalkSpeedMultiplier = Mults.WalkSpeed or 1.5
local FovMultiplier = Mults.FieldOfView or 1.3

local Tween1 = TweenService:Create(Humanoid, Sine_InOut, { WalkSpeed = BaseWalkSpeed*WalkSpeedMultiplier })
local Tween2 = TweenService:Create(Camera, Sine_InOut, { FieldOfView = BaseFOV*FovMultiplier })
local Tween3 = TweenService:Create(Humanoid, Expo_Out, { WalkSpeed = BaseWalkSpeed })
local Tween4 = TweenService:Create(Camera, Expo_Out, { FieldOfView = BaseFOV })

local function startS()
	Tween3:Cancel()
	Tween4:Cancel()
	task.wait()
	Tween1:Play()
	Tween2:Play()
end
local function endS()
	Tween1:Cancel()
	Tween2:Cancel()
	task.wait()
	Tween3:Play()
	Tween4:Play()
end

local MobileButtons = PlayerGui:WaitForChild("MobileButtonsLocal")
local JumpButtonFrame = MobileButtons:WaitForChild("JumpButtonFrame") -- This has a separate script that uses Math and the Screen's AbsoluteSize to move it to the jump button.

local SprintButton = Instance.new("ImageButton")
	SprintButton.Name = "SprintButton"
	SprintButton.Position = UDim2.new(-1.1, 0, -1.1, 0) -- This is not offscreen, as its Position is relative to its parent. This should be to the top-left of the jump button.
	SprintButton.Size = UDim2.new(1, 0, 1, 0)
	SprintButton.BackgroundTransparency = 1
	SprintButton.Active = true
	SprintButton.Image = "rbxassetid://118709768438655"
	SprintButton.Parent = JumpButtonFrame

Player.CharacterAdded:Connect(function(char)
	Character = char
	Humanoid = Character:WaitForChild("Humanoid")
	ResWalkSpeed = Humanoid.WalkSpeed

	BaseWalkSpeed = ResWalkSpeed
	Sprinting = false
	SprintButton.Image = "rbxassetid://118709768438655"
end)

if Toggle then
	SprintButton.MouseButton1Click:Connect(function()
		if not Sprinting then Sprinting = true else Sprinting = false end

		task.wait()
		if Sprinting then
			startS()
			SprintButton.Image = "rbxassetid://111778431619800"
		else
			endS() 
			SprintButton.Image = "rbxassetid://118709768438655"
		end
	end)
else
	SprintButton.PressedImage = "rbxassetid://111778431619800"
	Sprinting = nil
	SprintButton.MouseButton1Down:Connect(function() startS end)
	SprintButton.MouseButton1Up:Connect(function() endS end)
end

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.ButtonX then
		startS()
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.ButtonX then
		endS()
	end
end)

local gamepad = {
	ButtonX = "ATTEMPT TO   HOLD [X]   ON YOUR  GAMEPAD.", 
	ButtonSquare = "ATTEMPT TO   HOLD [SQUARE]   ON YOUR  GAMEPAD."
}
local keyboard = "ATTEMPT TO   HOLD [LEFTSHIFT]   ON YOUR  KEYBOARD."
local mobile = "ATTEMPT TO   HOLD THE RUN BUTTON   ON YOUR  TOUCHSCREEN."

local inputType = UserInputService:GetLastInputType()
local contents = keyboard
if inputType == Enum.UserInputType.Touch then
	contents = mobile
elseif inputType == Enum.UserInputType.Focus then
	contents = keyboard
elseif inputType == Enum.UserInputType.Gamepad1 then
	local mapped = UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonX)
	contents = gamepad[mapped] -- According to the Roblox documentation, if the user is on PlayStation, this will return ButtonCross. The table is as seen in the example code provided.
else
	warn("what device are you on vro 💔") -- Yeah if you somehow get this console message you're probably playing on like a Gyroscope or something
	contents = mobile -- It's up to the user to find out what the run button is. Roblox most likely doesn't recognize their input device, either.
end
	

game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "HELLO   MY PLAYER.", -- Tried something Gaster-y because yeah
	Text = contents, -- If I wrote this stupid script right this should change based on your device. Idfk lmao I'm not gonna check
	Duration = 10 -- How long the notification actually stays on screen. Wish we could make the Roblox app notify people or create new windows lmao that would be sick
})

local execEnd = tick() -- *stops timer* okay done :3
print("Loaded in " .. tostring(execEnd-execStart) .. ".") -- Basically this should print the amount of time to took to load this
