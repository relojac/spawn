local execStart = tick() -- *starts timer* okay time to write code

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

local Ambient = Color3.fromRGB(153, 255, 208)

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local MobileButtons = PlayerGui:WaitForChild("MobileButtonsLocal")
local JumpButtonFrame = MobileButtons:WaitForChild("JumpButtonFrame") -- This has a separate script that uses Math and the Screen's AbsoluteSize to move it to the jump button.

local NVButton = Instance.new("ImageButton")
	NVButton.Name = "NVButton"
	NVButton.Position = UDim2.new(-3.3, 0, 0, 0) -- This is not offscreen, as its Position is relative to its parent. This should be to the top-left of the jump button.
	NVButton.Size = UDim2.new(1, 0, 1, 0)
	NVButton.BackgroundTransparency = 1
	NVButton.Active = true
  NVButton.Image = "rbxassetid://120316668670756"
	NVButton.Parent = JumpButtonFrame

local NV = Instance.new("TextLabel")
	NV.Name = "NVText" 
	NV.Size = UDim2.new(1, 0, 1, 0)
	NV.Text = "NightVision"
	NV.BackgroundTransparency = 1
	NV.TextSize = 12
	NV.TextColor3 = Color3.new(1, 1, 1)
	NV.TextStrokeColor3 = Color3.new(0, 0, 0)
	NV.TextStrokeTransparency = 0
	NV.ZIndex = 1
	NV.Parent = NVButton

local NVE_1 = Instance.new("ColorCorrectionEffect", Lighting)
	NVEffect.Name = "NVE_1"
	NVEffect.Enabled = false
	NVEffect.TintColor = Ambient
	NVEffect.Contrast = 0.2
	NVEffect.Saturation = -1

local VignetteGui = Instance.new("ScreenGui", PlayerGui)
	VignetteGui.Name = "VignetteGuiLocal"
	VignetteGui.IgnoreGuiInset = false
	VignetteGui.Enabled = false

local Vignette = Instance.new("ImageLabel", VignetteGui)
	Vignette.Name = "Vignette"
	Vignette.ImageTransparenxy = 0.5
	Vignette.Image = "rbxassetid://113537235654608"
	Vignette.Size = UDim2.new(1, 0, 1, 0)

local SoundOn = Instance.new("Sound", SoundService)
	SoundOn.SoundId = "rbxassetid://376178316"
local SoundOff = Instance.new("Sound", SoundService)
	SoundOff.SoundId = "rbxassetid://79003354998655"

local nv = false
local function nvon()
	if not nv then
		nv = true
		SoundOn:Play()
	else
		nv = false
		SoundOff:Play()
	end
end

local function hl(Character)
	local NV_hl = Instance.new("Highlight", Character)
		NV_hl.Name = "NV_hl"
		NV_hl.FillTransparency = 1
		NV_hl.Enabled = nv

	if NV_hl then
		while true do
			task.wait()
			NV_hl.Enabled = nv

			if not NV_hl then break end
		end
	end
end

for _, plr in ipairs(Players:GetChildren()) do
	local Character = plr.Character or plr.CharacterAdded:Wait()

	if plr.Name ~= Player.Name then
		hl(Character)
	end

	plr.CharacterAdded:Connect(hl)
end

Players.PlayerAdded:Connect(function(plr)
	local Character = plr.Character or plr.CharacterAdded:Wait()

	if plr.Name ~= Player.Name then
		hl(Character)
	end

	plr.CharacterAdded:Connect(hl)
end)

RunService.Heartbeat:Connect(function()
	if nv then
		NVButton.Image = "rbxassetid://125086742998263"
		VignetteGui.Enabled = true
		NVE_1.Enabled = true
	else
		NVButton.Image = "rbxassetid://120316668670756"
		VignetteGui.Enabled = false
		NVE_1.Enabled = false
	end
end)

NVButton.MouseButton1Click:Connect(nvon)

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.KeypadSeven then
		nvon()
	end
end)

local execEnd = tick() -- *stops timer* okay done :3
print("Loaded in " .. tostring(execEnd-execStart) .. ".") -- Basically this should print the amount of time to took t o load this
