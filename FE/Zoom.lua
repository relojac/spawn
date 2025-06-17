local execStart = tick() -- *starts timer* okay time to write code

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

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

local function zoom()
	if Player.CameraMode ~= "LockFirstPerson" then
		Player.CameraMode = "LockFirstPerson"
	else
		Player.CameraMode = "Classic"
	end
end

RunService.Heartbeat:Connect(function()
	if Player.CameraMode == "LockFirstPerson" then
		ZoomButton.Image = "rbxassetid://125086742998263"
		Player.CameraMaxZoomDistance = 0
	else
		ZoomButton.Image = "rbxassetid://120316668670756"
		Player.CameraMaxZoomDistance = math.huge
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
