local execStart = tick() -- *starts timer* okay time to write code

local Global = (getgenv and getgenv()) or shared
local Config = Global.SpawnUtilsConfig.NightVision

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

local Ambient = Config.AmbientColor

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local MobileButtons = PlayerGui:WaitForChild("MobileButtonsLocal")
local JumpButtonFrame = MobileButtons:WaitForChild("JumpButtonFrame") -- This has a separate script that uses Math and the Screen's AbsoluteSize to move it to the jump button.

local NVButton = Instance.new("ImageButton", JumpButtonFrame)
	NVButton.Name = "NVButton"
	NVButton.Position = UDim2.new(-3.3, 0, 0, 0) -- This is not offscreen, as its Position is relative to its parent. This should be to the top-left of the jump button.
	NVButton.Size = UDim2.new(1, 0, 1, 0)
	NVButton.BackgroundTransparency = 1
	NVButton.Active = true
	NVButton.Image = "rbxassetid://120316668670756"

local NVText = Instance.new("TextLabel", NVButton)
	NVText.Name = "NVText" 
	NVText.Size = UDim2.new(1, 0, 1, 0)
	NVText.Text = "Night\nVision"
	NVText.BackgroundTransparency = 1
	NVText.TextSize = 11
	NVText.TextColor3 = Color3.new(1, 1, 1)
	NVText.TextStrokeColor3 = Color3.new(0, 0, 0)
	NVText.TextStrokeTransparency = 0
	NVText.ZIndex = 1
	NVText.Active = false

local NVE = Instance.new("ColorCorrectionEffect", Lighting)
	NVE.Name = "NVE_1"
	NVE.Enabled = false
	NVE.TintColor = Ambient
	NVE.Contrast = 0.2
	NVE.Saturation = -1

local VignetteGui = Instance.new("ScreenGui", PlayerGui)
	VignetteGui.Name = "VignetteGuiLocal"
	VignetteGui.IgnoreGuiInset = true
	VignetteGui.Enabled = false

local Vignette = Instance.new("ImageLabel", VignetteGui)
	Vignette.Name = "Vignette"
	Vignette.ImageTransparency = 0.5
	Vignette.Image = "rbxassetid://113537235654608"
	Vignette.Size = UDim2.new(1, 0, 1, 0)
	Vignette.BackgroundTransparency = 1

local SoundOn = Instance.new("Sound", game.SoundService)
	SoundOn.Name = "NightVisionOn"
	SoundOn.SoundId = "rbxassetid://376178316"
local SoundOff = Instance.new("Sound", game.SoundService)
	SoundOn.Name = "NightVisionOff"
	SoundOff.SoundId = "rbxassetid://79003354998655"

local nv = false
local function nvtoggle()
	print("Toggled", nv)
	if not nv then
		nv = true
		SoundOn:Play()

		NVButton.Image = "rbxassetid://125086742998263"
		if Config.Vignette then VignetteGui.Enabled = true end
		if Config.ColorCorrection then NVE.Enabled = true end
	else
		nv = false
		SoundOff:Play()

		NVButton.Image = "rbxassetid://120316668670756"
		VignetteGui.Enabled = false
		NVE.Enabled = false
	end
end

local function hl(ch)
	local Highlight = Instance.new("Highlight", ch)
		Highlight.Name = "NV_hl"
		Highlight.FillTransparency = 1
		Highlight.OutlineColor = Ambient
		Highlight.Enabled = false

	if Highlight then
		if Config.Highlights then
			local loop = RunService.RenderStepped:Connect(function()
				Highlight.Enabled = nv
				
				if not Highlight then loop:Disconnect() end
			end)
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

NVButton.MouseButton1Click:Connect(nvtoggle)

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.KeypadSeven then
		nvtoggle()
	end
end)

local execEnd = tick() -- *stops timer* okay done :3
print("Loaded in " .. tostring(execEnd-execStart) .. ".") -- Basically this should print the amount of time to took t o load this
