local execStart = tick() -- *starts timer* okay time to write code

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local MobileButtons = PlayerGui:WaitForChild("MobileButtonsLocal")
local JumpButtonFrame = MobileButtons:WaitForChild("JumpButtonFrame") -- This has a separate script that uses Math and the Screen's AbsoluteSize to move it to the jump button.

local DropButton = Instance.new("ImageButton", JumpButtonFrame)
	DropButton.Name = "SuicideButton"
	DropButton.Position = UDim2.new(-3.3, 0, -1.1, 0) -- This is not offscreen, as its Position is relative to its parent. This should be to the top-left of the jump button.
	DropButton.Size = UDim2.new(1, 0, 1, 0)
	DropButton.BackgroundTransparency = 1
	DropButton.Active = true
	DropButton.Visible = false
	DropButton.Image = "rbxassetid://134350713682140"
	DropButton.PressedImage = "rbxassetid://102541337489368"

RunService.RenderStepped:Connect(function()
	if Player.Character then
		local ch = Player.Character
		DropButton.Visible = ch:FindFirstChildWhichIsA("Tool", true) == true
	end
end)

local function drop()
	if Player.Character then
		local ch = Player.Character
		for _, tool in ipairs(ch:GetChildren()) do
			if tool:IsA("Tool") then
				tool.Parent = workspace
			end
		end
	end
end

DropButton.MouseButton1Click:Connect(drop)

local execEnd = tick() -- *stops timer* okay done :3
print("Loaded in " .. tostring(execEnd-execStart) .. ".")
