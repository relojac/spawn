local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Camera = workspace.CurrentCamera or workspace:WaitForChild("Camera")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local rad = 180/math.pi

local Current = Vector2.zero
local targetX, targetY = 0, 0

local speed = 10 -- Speed of the animation
local sensitivity = 1 -- Sensitivity of the rotation
local releaseSpeed = 0.5 -- How much speed remains when you release

UserInputService.MouseDeltaSensitivity = 0.01
cam.CameraType = Enum.CameraType.Custom

RunService:BindToRenderStep("SmoothCam", Enum.RenderPriority.Camera.Value-1, function(dt)
	local delta = UserInputService:GetMouseDelta()*sensitivity*100
	targetX -= delta.X
	targetY = math.clamp(targetY-delta.Y,-89,89)
	current = Current:Lerp(Vector2.new(targetX,targetY), dt*speed)
	cam.CFrame = CFrame.fromOrientation(current.Y/rad,current.X/rad,0)
end)
mouse.Button2Up:Connect(function()
	local new = Current:Lerp(Vector2.new(targetX,targetY), releaseSpeed)
	targetX = new.X
	targetY = new.Y
end)
