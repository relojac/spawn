local execStart = tick() -- *starts timer* okay time to write code

local Global = (getgenv and getgenv()) or shared
local Values = Global.Values

local FirstPersonLock = Values.FirstPersonLock

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

FirstPersonLock = false

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local HapticEffect = Instance.new("HapticEffect", workspace)
	HapticEffect.Type = Enum.HapticEffectType.UIClick
	HapticEffect.Looped = true

Player.CameraMinZoomDistance = 0
Player.CameraMaxZoomDistance = math.huge

local MobileButtons = PlayerGui:WaitForChild("MobileButtonsLocal")
local JumpButtonFrame = MobileButtons:WaitForChild("JumpButtonFrame") -- This has a separate script that uses Math and the Screen's AbsoluteSize to move it to the jump button.

local ZoomButton = Instance.new("ImageButton")
	ZoomButton.Name = "ZoomButton"
	ZoomButton.Position = UDim2.new(-3.3, 0, 0, 0) -- This is not offscreen, as its Position is relative to its parent. This should be to the top-left of the jump button.
	ZoomButton.Size = UDim2.new(1, 0, 1, 0)
	ZoomButton.BackgroundTransparency = 1
	ZoomButton.Active = true
	ZoomButton.Image = "rbxassetid://120316668670756"
	ZoomButton.Parent = JumpButtonFrame

local Zoom = Instance.new("TextLabel")
	Zoom.Name = "ZoomText" 
	Zoom.Size = UDim2.new(1, 0, 1, 0)
	Zoom.Text = "Zoom"
	Zoom.BackgroundTransparency = 1
	Zoom.TextSize = 15
	Zoom.TextColor3 = Color3.new(1, 1, 1)
	Zoom.TextStrokeColor3 = Color3.new(0, 0, 0)
	Zoom.TextStrokeTransparency = 0
	Zoom.ZIndex = 1
	Zoom.Parent = ZoomButton

local function hapt()
	HapticEffect:Play()
	task.wait(0.25)
	HapticEffect:Stop()
end

local function zoom()
	-- hapt() -- as much as i would've loved to use this, HapticEffects aren't released yet despite the documentation on it.
	if not FirstPersonLock then FirstPersonLock = true else FirstPersonLock = false end
end

local MaxZoom = true
RunService.Heartbeat:Connect(function()
	if FirstPersonLock then
		ZoomButton.Image = "rbxassetid://125086742998263"
		Zoom.Text = "1st"
		Player.CameraMode = Enum.CameraMode.LockFirstPerson
		MaxZoom = true
	else
		ZoomButton.Image = "rbxassetid://120316668670756"
		Zoom.Text = "3rd"
		if MaxZoom then
			MaxZoom = false
			Player.CameraMode = Enum.CameraMode.Classic
			Player.CameraMinZoomDistance = 20
			task.wait()
			Player.CameraMinZoomDistance = 0
		end
	end
end)

ZoomButton.MouseButton1Click:Connect(zoom)

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.KeypadFour then
		zoom()
	end
end)

local execEnd = tick() -- *stops timer* okay done :3
print("Loaded in " .. tostring(execEnd-execStart) .. ".") -- Basically this should print the amount of time to to ok t o load this
