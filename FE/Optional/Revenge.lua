local Global = (getgenv and getgenv()) or shared
local Values = Global.Values

local FirstPersonLock = Values.FirstPersonLock

local IsLocked = nil
if FirstPersonLock ~= nil then
	IsLocked = true
else
	IsLocked = false
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
Player.CharacterAdded:Connect(function(char)
	Character = char or Player.Character
end)
local Camera = workspace.CurrentCamera

local function TweenCam(newSubj)
	local old
	local new

	if Camera.CameraSubject:IsA("Humanoid") then
		old = Camera.CameraSubject.Parent.Head
	else
		old = Camera.CameraSubject
	end
	if newSubj:IsA("Humanoid") then
		new = newSubj.Parent.Head
	else
		new = newSubj
	end

	local rPos = cam.CFrame.Position - oldPart.Position
	local CamCFrame = cam.CFrame
	Camera.CameraType = Enum.CameraType.Scriptable
	local moveCon
	local totalTime = 0
	moveCon = RunService.RenderStepped:Connect(function(delta)
        local newFrame = CamCFrame-CamCFrame.Position+new.Position+rPos
		totalTime = math.clamp(totalTime+delta/0.1, 0, 1)
		Camera.CFrame = camFrame:Lerp(newFrame, totalTime)
		if totalTime == 1 then
			moveCon:Disconnect()
			cam.CameraSubject = newSubj
			cam.CameraType = Enum.CameraType.Custom
			moveCon = nil
		end
	end)
	repeat task.wait() until not moveCon
end

local creator
local killedBy
Player.Character:WaitForChild("Humanoid").Died:Connect(function()
	creator = Player.Character.Humanoid:FindFirstChild("creator") or Player.Character.Humanoid:FindFirstChildOfClass("ObjectValue") or nil
	killedBy = creator.Value
	local creatorChar = killedBy.Character
		TweenCam(creatorChar.Humanoid)

	if creator and creator.Value and creator.Value.Parent and creator.Value.Character then
		local hl = Instance.new("Highlight", creatorChar)
			hl.OutlineColor = Color3.new(1, 1, 1)
			hl.FillColor = Color3.new(1, 0, 0)
			hl.FillTransparency = 0.5

		creatorChar.Humanoid.Died:Connect(function()
			if hl then
				hl:Destroy()
				if plr.Character then
					TweenCam(plr.Character.Humanoid)
				end
			end
		end) 
	end
end)
